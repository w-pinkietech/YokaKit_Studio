#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  scripts/exec_plan/prepare_pr_body.sh --issue <n> [--issue <n> ...]
                                       [--issues <n1,n2,...>] [--template <path>] [--output <path>]

概要:
  - `.github/pull_request_template.md` を元に PR 本文の下書きを生成し、Related Issues セクションに
    `Closes #<issue-number>` の行を自動挿入します。
  - 出力ファイルはデフォルトで `PR_DRAFT.md`。Draft PR 作成時に `gh pr create --body-file PR_DRAFT.md` と併用してください。

オプション:
  --issue <n>     : Closes で紐づける Issue 番号（複数指定可、`#35` 形式も許容）
  --issues <list> : カンマ or 空白区切りで複数 Issue を一度に指定
  --template <p>  : 雛形となる PR テンプレート（デフォルト: .github/pull_request_template.md）
  --output <p>    : 生成される PR 本文ファイル（デフォルト: PR_DRAFT.md）
  -h, --help      : 本ヘルプを表示
EOF
}

template=".github/pull_request_template.md"
output="PR_DRAFT.md"
declare -a issues=()
declare -A seen=()

add_issue() {
  local raw="${1:-}"
  if [[ -z "${raw}" ]]; then
    return
  fi
  raw="${raw#\#}"
  if [[ ! "${raw}" =~ ^[0-9]+$ ]]; then
    echo "error: issue must be numeric (got '${1}')" >&2
    exit 1
  fi
  if [[ -z "${seen[${raw}]:-}" ]]; then
    issues+=("${raw}")
    seen["${raw}"]=1
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --issue)
      add_issue "${2:-}"
      shift 2
      ;;
    --issues)
      list="${2:-}"
      list="${list//,/ }"
      for token in ${list}; do
        add_issue "${token}"
      done
      shift 2
      ;;
    --template)
      template="${2:-}"
      shift 2
      ;;
    --output)
      output="${2:-}"
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

if [[ "${#issues[@]}" -eq 0 ]]; then
  echo "error: specify at least one --issue" >&2
  usage
  exit 1
fi

if [[ ! -f "${template}" ]]; then
  echo "error: template not found: ${template}" >&2
  exit 1
fi

python3 - "${template}" "${output}" "${issues[@]}" <<'PY'
import sys
from pathlib import Path

if len(sys.argv) < 4:
    raise SystemExit("error: insufficient arguments passed to helper")

template_path = Path(sys.argv[1])
output_path = Path(sys.argv[2])
issues = sys.argv[3:]

start_marker = "<!-- autop:related-issues:start -->"
end_marker = "<!-- autop:related-issues:end -->"

lines = template_path.read_text(encoding="utf-8").splitlines()
out_lines = []
in_block = False
block_found = False

for line in lines:
    if start_marker in line:
        block_found = True
        in_block = True
        out_lines.append(line)
        out_lines.append("")
        for issue in issues:
            out_lines.append(f"- Closes #{issue}")
        continue
    if end_marker in line:
        if not block_found:
            raise SystemExit("error: end marker found before start marker in template")
        out_lines.append(line)
        in_block = False
        continue
    if in_block:
        # Skip placeholder lines inside auto block
        continue
    out_lines.append(line)

if in_block:
    raise SystemExit("error: start marker found without matching end marker in template")
if not block_found:
    raise SystemExit("error: template missing related issues auto markers")

output_path.write_text("\n".join(out_lines) + "\n", encoding="utf-8")
PY

echo "Generated ${output} with Closes references: ${issues[*]}"
echo "Next: gh pr create --draft --body-file \"${output}\"  # or remove --draft when ready"
