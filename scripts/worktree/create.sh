#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  scripts/worktree/create.sh [--branch <name>] [--path <path>] [--base <ref>] [--no-fetch] [--force]
                              [--help]
  scripts/worktree/create.sh <name> [<path>]

概要:
  - Git worktree を安全に作成し、エージェントごとに独立した作業ディレクトリを確保します。
  - ブランチが未作成の場合は `--base` で指定したリファレンス（既定: origin/main → main）から新規作成します。
  - 既存 worktree とパスの衝突を検出し、誤操作を防止します。

オプション:
  -b, --branch <name>   生成するブランチ名（位置引数でも指定可能）
  -p, --path <path>     作成先ディレクトリ（既定: <repo>.worktrees/<branch>）
  -B, --base <ref>      新規ブランチ作成時のベースリファレンス（既定: origin/main → main）
      --no-fetch        `git fetch origin` をスキップ
  -f, --force           既存パスが空でない場合でも再利用（注意: 上書きされる可能性）
  -h, --help            このヘルプを表示

例:
  scripts/worktree/create.sh framework/28-git-worktree
  scripts/worktree/create.sh --branch feature/login --base origin/develop
  scripts/worktree/create.sh framework/42-docs ../alt-root/framework-42
EOF
}

if ! command -v git >/dev/null 2>&1; then
  echo "error: git is required" >&2
  exit 1
fi

branch=""
worktree_path=""
base_ref=""
do_fetch=true
force=false

positional_index=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -b|--branch)
      branch="${2:-}"
      shift 2
      ;;
    -p|--path)
      worktree_path="${2:-}"
      shift 2
      ;;
    -B|--base)
      base_ref="${2:-}"
      shift 2
      ;;
    --no-fetch)
      do_fetch=false
      shift
      ;;
    -f|--force)
      force=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "error: unknown option '$1'" >&2
      usage >&2
      exit 1
      ;;
    *)
      if (( positional_index == 0 )); then
        branch="$1"
      elif (( positional_index == 1 )); then
        worktree_path="$1"
      else
        echo "error: unexpected argument '$1'" >&2
        usage >&2
        exit 1
      fi
      positional_index=$((positional_index + 1))
      shift
      ;;
  esac
done

if [[ -z "${branch}" ]]; then
  echo "error: branch name is required" >&2
  usage >&2
  exit 1
fi

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || true)
if [[ -z "${repo_root}" ]]; then
  echo "error: run this script inside a git repository" >&2
  exit 1
fi

repo_parent=$(dirname "${repo_root}")
repo_basename=$(basename "${repo_root}")
default_root="${repo_parent}/${repo_basename}.worktrees"

if [[ -z "${worktree_path}" ]]; then
  worktree_path="${default_root}/${branch}"
fi

if command -v python3 >/dev/null 2>&1; then
  worktree_path=$(python3 - "${worktree_path}" <<'PY'
import os
import sys

print(os.path.abspath(sys.argv[1]))
PY
)
else
  worktree_path=$(cd "$(dirname "${worktree_path}")" 2>/dev/null && pwd)/"$(basename "${worktree_path}")"
fi

parent_dir=$(dirname "${worktree_path}")

if [[ -e "${worktree_path}" ]] && [[ "${force}" != true ]]; then
  echo "error: worktree path already exists: ${worktree_path}" >&2
  echo "hint: use --force if you intend to reuse the directory." >&2
  exit 1
fi

mkdir -p "${parent_dir}"

if [[ "${do_fetch}" == true ]]; then
  if git remote get-url origin >/dev/null 2>&1; then
    git fetch origin
  else
    echo "info: skipped fetch because remote 'origin' is not configured" >&2
  fi
fi

if [[ -z "${base_ref}" ]]; then
  if git show-ref --verify --quiet "refs/remotes/origin/main"; then
    base_ref="origin/main"
  elif git show-ref --verify --quiet "refs/remotes/origin/master"; then
    base_ref="origin/master"
  else
    base_ref="main"
  fi
fi

branch_ref="refs/heads/${branch}"
branch_exists=false
if git show-ref --verify --quiet "${branch_ref}"; then
  branch_exists=true
fi

branch_checked_out=""
current_path=""
while read -r key value; do
  case "${key}" in
    worktree)
      current_path="${value}"
      ;;
    branch)
      if [[ "${value}" == "refs/heads/${branch}" ]]; then
        branch_checked_out="${current_path}"
      fi
      ;;
  esac
done < <(git worktree list --porcelain)

if [[ -n "${branch_checked_out}" ]] && [[ "${force}" != true ]]; then
  echo "error: branch '${branch}' is already checked out at ${branch_checked_out}" >&2
  echo "hint: (a) choose a different branch, (b) remove the existing worktree, or (c) re-run with --force after ensuring it is safe." >&2
  exit 1
fi

cmd=(git worktree add)

if [[ "${branch_exists}" == true ]]; then
  cmd+=("${worktree_path}" "${branch}")
else
  if ! git rev-parse --verify --quiet "${base_ref}" >/dev/null 2>&1; then
    echo "error: base ref not found: ${base_ref}" >&2
    exit 1
  fi
  cmd+=(-b "${branch}" "${worktree_path}" "${base_ref}")
fi

if [[ "${force}" == true ]]; then
  cmd+=(--force)
fi

echo "info: executing ${cmd[*]}" >&2
"${cmd[@]}"

cat <<EOF
✅ Worktree created
  Path   : ${worktree_path}
  Branch : ${branch}
  Base   : ${base_ref}

Next steps:
  cd "${worktree_path}"
  git status
  # Continue with Exec Plan setup (cp docs/60-templates/exec-plan.md plans.md など)
EOF
