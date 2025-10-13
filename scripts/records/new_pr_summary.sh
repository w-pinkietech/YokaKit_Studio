#!/usr/bin/env bash
set -euo pipefail

# new_pr_summary.sh <pr-number> <slug> [--issue <issue-number>] [--repo-url <url>] [--author <handle>]

if [[ ${1:-} == "" || ${2:-} == "" ]]; then
  echo "Usage: $0 <pr-number> <slug> [--issue <issue-number>] [--repo-url <url>] [--author <handle>]" >&2
  exit 1
fi

PR_NUM="$1"; shift
SLUG="$1"; shift

ISSUE_NUM=""
REPO_URL="https://github.com/<org>/<repo>"
AUTHOR="@you"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --issue)
      ISSUE_NUM="$2"; shift 2 ;;
    --repo-url)
      REPO_URL="$2"; shift 2 ;;
    --author)
      AUTHOR="$2"; shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 1;;
  esac
done

DEST_DIR="records/by-pr/${PR_NUM}-${SLUG}"
DEST_FILE="${DEST_DIR}/summary.md"
TEMPLATE="records/templates/summary.md"

if [[ ! -f "$TEMPLATE" ]]; then
  echo "Template not found: $TEMPLATE" >&2
  exit 1
fi

mkdir -p "$DEST_DIR"
cp "$TEMPLATE" "$DEST_FILE"

created_date=$(date +%F)

# In-place edit (portable)
tmpfile=$(mktemp)
awk -v pr="$PR_NUM" -v slug="$SLUG" -v issue="${ISSUE_NUM}" -v repo="$REPO_URL" -v author="$AUTHOR" -v date="$created_date" '
BEGIN { infront=0 }
{
  if ($0 ~ /^id:/) { print "id: pr-" pr "-" slug; next }
  if ($0 ~ /^type:/) { print "type: pr # 原則 pr を使用（issue/commit は例外時のみ）"; next }
  if ($0 ~ /^status:/) { print "status: open"; next }
  if ($0 ~ /^authors:/) { print "authors: [\"" author "\"]"; next }
  if ($0 ~ /^  created:/) { print "  created: " date; next }
  if ($0 ~ /^  updated:/) { print "  updated: " date; next }
  if ($0 ~ /^  thread:/) { print "  thread: " repo "/pull/" pr; next }
  if (issue != "" && $0 ~ /^  issues:/) { print "  issues: [\"#" issue "\"]"; next }
  print
}
' "$DEST_FILE" > "$tmpfile"
mv "$tmpfile" "$DEST_FILE"

echo "Created $DEST_FILE"
echo "Update permalinks after review comments are posted."

