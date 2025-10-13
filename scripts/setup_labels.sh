#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/setup_labels.sh <owner/repo> [--dry-run]

Synchronise the canonical label set for this project onto the target GitHub repository.
Requires curl and python3, and expects a GitHub personal access token with "repo" scope in $GITHUB_TOKEN.

Examples:
  GITHUB_TOKEN=ghp_xxx scripts/setup_labels.sh w-pinkietech/YokaKit_Studio
  GITHUB_TOKEN=ghp_xxx scripts/setup_labels.sh w-pinkietech/YokaKit_Studio --dry-run
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "error: curl is required" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "error: python3 is required" >&2
  exit 1
fi

REPO="$1"
shift || true

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi

if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  echo "error: please export GITHUB_TOKEN with a token that can manage repository labels" >&2
  exit 1
fi

API_ROOT="https://api.github.com/repos/${REPO}"

urlencode() {
  python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1], safe=''))" "$1"
}

declare -a LABELS=(
  "track::framework|5319e7|Framework and governance work"
  "track::delivery|2563eb|Feature delivery work"
  "track::operations|0f766e|Run and operate work"

  "artifact::process|0ea5e9|Workflow and process definitions"
  "artifact::documentation|10b981|Project documentation updates"
  "artifact::tooling|f472b6|Tooling or automation assets"

  "lifecycle::draft|f59e0b|Draft needing initial review"
  "lifecycle::in-review|f97316|Under active review"
  "lifecycle::approved|16a34a|Approved and ready to close"

  "status::triage|6b7280|Collecting context and scoping the issue"
  "status::ready|14b8a6|Clear scope and available to pick up"
  "status::in-progress|2563eb|Active implementation in progress"
  "status::in-review|f97316|Implementation complete and under review"
  "status::done|22c55e|Verified complete and ready to close"
  "status::blocked|b91c1c|Blocked by external dependency or decision"

  "impact::high|fb7185|High impact or urgency"
  "impact::medium|facc15|Moderate impact"
  "impact::low|84cc16|Low impact or housekeeping"
)

ensure_label() {
  local name="$1"
  local color="$2"
  local description="$3"
  local payload
  payload=$(python3 - <<'PY' "$name" "$color" "$description"
import json
import sys

name, color, desc = sys.argv[1:]
print(json.dumps({"name": name, "color": color, "description": desc}))
PY
)

  if $DRY_RUN; then
    echo "[dry-run] would ensure label '${name}' (${color})"
    return
  fi

  local encoded
  encoded=$(urlencode "$name")

  local status
  status=$(curl -sS -o /dev/null -w "%{http_code}" \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    -X PATCH \
    "${API_ROOT}/labels/${encoded}" \
    -d "${payload}")

  if [[ "${status}" == "200" ]]; then
    echo "updated label '${name}'"
    return
  fi

  if [[ "${status}" != "404" ]]; then
    echo "error: failed to update label '${name}' (status ${status})" >&2
    return 1
  fi

  status=$(curl -sS -o /dev/null -w "%{http_code}" \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    -X POST \
    "${API_ROOT}/labels" \
    -d "${payload}")

  if [[ "${status}" == "201" ]]; then
    echo "created label '${name}'"
  else
    echo "error: failed to create label '${name}' (status ${status})" >&2
    return 1
  fi
}

main() {
  local entry
  for entry in "${LABELS[@]}"; do
    IFS="|" read -r name color description <<<"${entry}"
    ensure_label "${name}" "${color}" "${description}"
  done
}

main
