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
  resolution=$(python3 - "${slug}" "${filter_label}" <<'PY' <<<"${issue_list}"
import json
import sys

issues = json.load(sys.stdin)
slug = sys.argv[1].lower()
filter_label = sys.argv[2]
matches = []

for issue in issues:
    title = issue["title"].lower()
    labels = [label["name"] for label in issue["labels"]]
    if slug in title and (not filter_label or filter_label in labels):
        matches.append(issue)

if not matches:
    print("NONE")
elif len(matches) == 1:
    print(f"MATCH:{matches[0]['number']}")
else:
    print("MULTIPLE")
    for issue in matches:
        labels = ", ".join(label["name"] for label in issue["labels"])
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
    args=(issue create --repo "${repo}" --title "${title}" --json number,url)
    IFS=',' read -ra label_array <<<"${labels}"
    for label in "${label_array[@]}"; do
      trimmed="${label#"${label%%[![:space:]]*}"}"
      trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
      if [[ -n "${trimmed}" ]]; then
        args+=(--label "${trimmed}")
      fi
    done
    if [[ -n "${body_file}" ]]; then
      if [[ ! -f "${body_file}" ]]; then
        echo "error: body file not found: ${body_file}" >&2
        exit 1
      fi
      args+=(--body-file "${body_file}")
    fi
    if [[ -n "${assignee}" ]]; then
      args+=(--assignee "${assignee}")
    fi
    created_json=$(gh "${args[@]}")
    issue_number=$(python3 - <<'PY' <<<"${created_json}"
import json
import sys
data = json.load(sys.stdin)
print(data["number"])
PY
)
    issue_url=$(python3 - <<'PY' <<<"${created_json}"
import json
import sys
data = json.load(sys.stdin)
print(data["url"])
PY
)
    echo "info: created issue #${issue_number} -> ${issue_url}" >&2
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
