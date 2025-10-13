#!/usr/bin/env bash
set -euo pipefail

# archive_plan.sh <pr-number> <slug> [--plan-path <path>] [--title <text>]

if [[ ${1:-} == "" || ${2:-} == "" ]]; then
  echo "Usage: $0 <pr-number> <slug> [--plan-path <path>] [--title <text>]" >&2
  exit 1
fi

PR_NUM="$1"; shift
SLUG="$1"; shift

PLAN_PATH="plans.md"
TITLE="Exec Plan Snapshot"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --plan-path)
      PLAN_PATH="$2"; shift 2 ;;
    --title)
      TITLE="$2"; shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 1;;
  esac
done

if [[ ! -f "$PLAN_PATH" ]]; then
  echo "Plan file not found: $PLAN_PATH" >&2
  exit 2
fi

DEST_DIR="records/by-pr/${PR_NUM}-${SLUG}"
DEST_FILE="${DEST_DIR}/plans.md"

mkdir -p "$DEST_DIR"

timestamp=$(date '+%F %T')
branch=$(git branch --show-current 2>/dev/null || echo "")
commit=$(git rev-parse --short HEAD 2>/dev/null || echo "")

{
  echo "# ${TITLE} (${timestamp})"
  if [[ -n "$branch" || -n "$commit" ]]; then
    echo
    echo "> branch: ${branch}  commit: ${commit}"
  fi
  echo
  echo "---"
  cat "$PLAN_PATH"
} > "$DEST_FILE"

echo "Archived plan to $DEST_FILE"

# Optionally, append link into summary.md if present
SUMMARY_FILE="${DEST_DIR}/summary.md"
if [[ -f "$SUMMARY_FILE" ]]; then
  rel_path="plans.md"
  if ! rg -n "${rel_path}" "$SUMMARY_FILE" >/dev/null 2>&1; then
    printf "\n- Plan Snapshot: %s\n" "$rel_path" >> "$SUMMARY_FILE"
    echo "Updated summary with plan link"
  fi
fi

