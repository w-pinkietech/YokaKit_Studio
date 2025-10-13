#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  scripts/exec_plan/bootstrap.sh --slug <slug> [--repo <owner/repo>] [--title <issue-title>]
                                  [--labels label1,label2,...] [--body-file <path>]
                                  [--assignee <handle>] [--filter-label <label>] [--dry-run]

概要:
  - 現在のブランチ名や GitHub の Issue 状況を確認し、Exec Plan で紐づける Issue 番号を特定します。
  - `--title` を指定した場合、該当 Issue が存在しなければ自動で作成します。
  - Issue が複数候補として見つかった場合は一覧を表示し、手動選択を促します。

前提:
  - `gh` CLI にログイン済みであること。
  - リポジトリの `origin` が GitHub 上の URL を指している、または `--repo` で明示すること。

出力:
  - 標準出力に `ISSUE=<number>` を出力し、次の手順で参照しやすくします。
EOF
}

slug=""
repo=""
title=""
labels="track::framework,status::triage"
body_file=""
assignee=""
dry_run=false
filter_label=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --slug)
      slug="${2:-}"
      shift 2
      ;;
    --repo)
      repo="${2:-}"
      shift 2
      ;;
    --title)
      title="${2:-}"
      shift 2
      ;;
    --labels)
      labels="${2:-}"
      shift 2
      ;;
    --body-file)
      body_file="${2:-}"
      shift 2
      ;;
    --assignee)
      assignee="${2:-}"
      shift 2
      ;;
    --dry-run)
      dry_run=true
      shift
      ;;
    --filter-label)
      filter_label="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "${slug}" ]]; then
  echo "error: --slug is required" >&2
  usage
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "error: gh CLI is required" >&2
  exit 1
fi

if [[ -z "${repo}" ]]; then
  origin_url=$(git remote get-url origin 2>/dev/null || true)
  if [[ "${origin_url}" =~ github.com[:/]+([^/]+/[^/.]+) ]]; then
    repo="${BASH_REMATCH[1]}"
  fi
fi

if [[ -z "${repo}" ]]; then
  echo "error: failed to detect repo; specify with --repo <owner/repo>" >&2
  exit 1
fi

issue_number=""

branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
if [[ "${branch_name}" =~ ^[a-zA-Z0-9_-]+/([0-9]+)- ]]; then
  candidate="${BASH_REMATCH[1]}"
  if gh issue view "${candidate}" --repo "${repo}" >/dev/null 2>&1; then
    issue_number="${candidate}"
  fi
fi

if [[ -z "${issue_number}" ]]; then
  issue_list=$(gh issue list --repo "${repo}" --state open --limit 100 --json number,title,labels,url)
  resolution=$(
    ISSUE_LIST="${issue_list}" python3 - "${slug}" "${filter_label}" <<'PY'
import json
import os
import re
import sys

issues = json.loads(os.environ.get("ISSUE_LIST", "[]"))
raw_slug = sys.argv[1]
filter_label = sys.argv[2]
matches = []

def normalize(text: str) -> str:
    return re.sub(r"[^a-z0-9]+", " ", text.lower()).strip()

slug_norm = normalize(raw_slug)
slug_tokens = [token for token in slug_norm.split() if token]

def token_matches(issue_number: int, title: str) -> bool:
    title_norm = normalize(title)
    if not slug_tokens and not slug_norm:
        return False
    title_tokens = set(title_norm.split())
    if slug_tokens and all(token in title_tokens for token in slug_tokens):
        return True
    if slug_norm and slug_norm in title_norm:
        return True
    for token in slug_tokens:
        if token.isdigit() and int(token) == issue_number:
            return True
    return False

for issue in issues:
    labels = [label["name"] for label in issue.get("labels", [])]
    if filter_label and filter_label not in labels:
        continue
    if token_matches(issue["number"], issue["title"]):
        matches.append(issue)

if not matches:
    print("NONE")
elif len(matches) == 1:
    print(f"MATCH:{matches[0]['number']}")
else:
    print("MULTIPLE")
    for issue in matches:
        labels = ", ".join(label["name"] for label in issue.get("labels", []))
        print(f"#{issue['number']}|{issue['title']}|{labels}|{issue['url']}")
PY
)

  if [[ "${resolution}" == "NONE" ]]; then
    :
  elif [[ "${resolution}" == MATCH:* ]]; then
    issue_number="${resolution#MATCH:}"
    echo "info: matched existing issue #${issue_number}" >&2
  elif [[ "${resolution%%$'\n'*}" == "MULTIPLE" ]]; then
    echo "error: multiple open issues matched slug '${slug}':" >&2
    printf '%s\n' "${resolution#MULTIPLE$'\n'}"
    exit 1
  fi
fi

if [[ -z "${issue_number}" ]] && [[ -n "${title}" ]]; then
  if ${dry_run}; then
    echo "[dry-run] would create issue '${title}' in ${repo}" >&2
    issue_number="(pending)"
  else
    base_args=(issue create --repo "${repo}" --title "${title}")
    IFS=',' read -ra label_array <<<"${labels}"
    for label in "${label_array[@]}"; do
      trimmed="${label#"${label%%[![:space:]]*}"}"
      trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
      if [[ -n "${trimmed}" ]]; then
        base_args+=(--label "${trimmed}")
      fi
    done
    if [[ -n "${body_file}" ]]; then
      if [[ ! -f "${body_file}" ]]; then
        echo "error: body file not found: ${body_file}" >&2
        exit 1
      fi
      base_args+=(--body-file "${body_file}")
    fi
    if [[ -n "${assignee}" ]]; then
      base_args+=(--assignee "${assignee}")
    fi

    json_args=("${base_args[@]}" --json number,url)
    json_output=""
    json_supported=true
    if ! json_output=$(gh "${json_args[@]}" 2>&1); then
      if [[ "${json_output}" == *"unknown flag: --json"* ]]; then
        json_supported=false
      else
        echo "error: failed to create issue: ${json_output}" >&2
        exit 1
      fi
    fi

    if [[ "${json_supported}" == true ]]; then
      issue_number=$(python3 - <<'PY' <<<"${json_output}"
import json
import sys
data = json.load(sys.stdin)
print(data["number"])
PY
)
      issue_url=$(python3 - <<'PY' <<<"${json_output}"
import json
import sys
data = json.load(sys.stdin)
print(data["url"])
PY
)
      echo "info: created issue #${issue_number} -> ${issue_url}" >&2
    else
      if ! created_text=$(gh "${base_args[@]}" 2>&1); then
        echo "error: failed to create issue: ${created_text}" >&2
        exit 1
      fi
      issue_url=$(grep -Eo 'https://github.com/[^ ]+/issues/[0-9]+' <<<"${created_text}" | head -n1 || true)
      if [[ -n "${issue_url}" ]]; then
        issue_number="${issue_url##*/}"
      else
        issue_number=$(grep -Eo '#[0-9]+' <<<"${created_text}" | head -n1 | tr -d '#' || true)
        if [[ -n "${issue_number}" ]]; then
          issue_url="https://github.com/${repo}/issues/${issue_number}"
        fi
      fi
      if [[ -z "${issue_number}" ]]; then
        echo "error: failed to parse issue number from gh output" >&2
        echo "${created_text}" >&2
        exit 1
      fi
      echo "info: created issue #${issue_number} -> ${issue_url}" >&2
    fi
  fi
fi

if [[ -z "${issue_number}" ]]; then
  echo "error: no issue could be resolved for slug '${slug}'. Provide --title to create one or refine existing issues." >&2
  exit 1
fi

echo "ISSUE=${issue_number}"

if [[ "${issue_number}" =~ ^[0-9]+$ ]]; then
  if [[ ! "${branch_name}" =~ ^[a-zA-Z0-9_-]+/${issue_number}- ]]; then
    echo "hint: consider using branch name 'framework/${issue_number}-${slug// /-}' for consistency." >&2
  fi
fi
