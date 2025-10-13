#!/usr/bin/env bash
set -euo pipefail

# new_package.sh <issue-number> <slug>

if [[ ${1:-} == "" || ${2:-} == "" ]]; then
  echo "Usage: $0 <issue-number> <slug>" >&2
  exit 1
fi

ISSUE="$1"; shift
SLUG="$1"; shift

DEST_FILE="records/packages/pkg-${ISSUE}-${SLUG}.md"
TEMPLATE="records/templates/change-package.md"

mkdir -p "$(dirname "$DEST_FILE")"
if [[ ! -f "$TEMPLATE" ]]; then
  echo "Template not found: $TEMPLATE" >&2
  exit 1
fi

cp "$TEMPLATE" "$DEST_FILE"

created_date=$(date +%F)

tmpfile=$(mktemp)
awk -v issue="$ISSUE" -v slug="$SLUG" -v date="$created_date" '
{
  if ($0 ~ /^id:/) { print "id: pkg-" issue "-" slug; next }
  if ($0 ~ /^status:/) { print "status: active # active | paused | done | dropped"; next }
  if ($0 ~ /^  issue:/) { print "  issue: \"#" issue "\""; next }
  if ($0 ~ /^  started:/) { print "  started: " date; next }
  print
}
' "$DEST_FILE" > "$tmpfile"
mv "$tmpfile" "$DEST_FILE"

echo "Created $DEST_FILE"

