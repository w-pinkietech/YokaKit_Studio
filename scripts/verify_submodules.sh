#!/usr/bin/env bash

set -euo pipefail

if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
  echo "Error: not inside a git repository." >&2
  exit 2
fi

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

status_output="$(git submodule status || true)"

if [[ -z "${status_output// }" ]]; then
  echo "No submodules configured."
  exit 0
fi

has_issue=0

while IFS= read -r line; do
  [[ -z "${line// }" ]] && continue
  indicator="${line:0:1}"
  path="$(printf "%s" "$line" | awk '{print $2}')"
  case "$indicator" in
    '-')
      echo "[warn] Submodule '${path}' is not initialized. Run 'git submodule update --init --recursive' first."
      has_issue=1
      ;;
    '+')
      echo "[warn] Submodule '${path}' points to a commit that is not recorded in the index."
      echo "    Run the governed update flow (Code Output PR -> Context Studio follow-up PR) before committing."
      has_issue=1
      ;;
    'U')
      echo "[warn] Submodule '${path}' has merge conflicts. Resolve them before proceeding."
      has_issue=1
      ;;
    *)
      ;;
  esac
done <<< "$status_output"

if [[ "$has_issue" -eq 1 ]]; then
  exit 1
fi

echo "All submodules are synchronized with recorded commits."
