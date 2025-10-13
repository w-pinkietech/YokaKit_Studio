# Exec Plan Snapshot (2025-10-14 06:52:49)

> branch: framework/28-git-worktree  commit: 49d78b8

---
# Exec Plan: Multi-agent worktrees

> 使い方（雛形：Deferred GitHub Ops 推奨）
> - このファイルをブランチ直下 `plans.md` にコピーして編集します。
> - プラン初稿に合意したら、Issue/PR（Draft）を作成し `scripts/records/new_pr_summary.sh` で要約を生成、マージ前に `scripts/records/archive_plan.sh` でスナップショットを保存します。
>
> 推奨コマンド例:
> ```bash
> set -euo pipefail
> ISSUE=<n>; SLUG=<slug>; PR=<pr>; REPO=https://github.com/<org>/<repo>; AUTHOR=@you
> scripts/exec_plan/bootstrap.sh --slug ${SLUG} --filter-label track::framework \
>   --title "[framework] <title>" --labels "track::framework,artifact::<type>,status::triage,lifecycle::draft" \
>   --repo ${REPO}
> cp docs/60-templates/exec-plan.md plans.md
> bash scripts/records/new_pr_summary.sh ${PR} ${SLUG} --issue ${ISSUE} --repo-url ${REPO} --author ${AUTHOR}
> # 作業…
> bash scripts/records/archive_plan.sh ${PR} ${SLUG}
> rm plans.md
> ```

## 目的 / ゴール
- 複数エージェントが干渉せずに作業できるよう、Git worktree 運用ガイドと補助スクリプトを整備する。
- worktree 上でも既存の Exec Plan / records フローがそのまま動作することを確認し、必要な改善を反映する。
- 受け入れ基準に沿った文書・スクリプト・検証手順を更新して Issue #28 をクローズ可能な状態にする。

## 範囲 / 非範囲
- 範囲: エージェント向けドキュメント（`AGENTS.md`, `docs/20-process/agents/README.md`, `docs/20-process/exec-plan.md`）の更新、worktree 作成支援スクリプト追加、Git worktree 環境での Exec Plan コマンド検証。
- 非範囲: Code Output サブモジュールや他リポジトリのセットアップ、自動化スクリプトの削除/大規模リファクタ、GUI ツールを伴う変更。
- 前提: `.aidlc/` 配下に該当コンテキストは存在しないため、背景はIssue本文と既存ガイドから補完する。

## 参照 / コンテキスト
- Issue: #28（[framework] Enable multi-agent work via git worktree）
- ADR / 設計: 該当 ADR なし（Issue 文脈と現行プロセスドキュメントを参照）
- 関連Docs: `docs/20-process/agents/README.md`, `docs/20-process/exec-plan.md`, `AGENTS.md`
- PR: https://github.com/w-pinkietech/YokaKit_Studio/pull/39
- Records: `records/by-pr/39-git-worktree/summary.md`

## 全体像
- 現状は単一ワークツリーを前提としており、複数エージェントが並列で動くと未コミット差分やブランチ切り替えが干渉する。Git worktree を標準フローに取り込むことで、作業者ごとに独立したディレクトリを確保しつつ、既存の Exec Plan / records ワークフローを維持する。
- worktree 設定手順のドキュメント化、補助スクリプトの提供、Exec Plan コマンドの互換性検証を行い、エージェントが迷わずセットアップできる Quickstart / Process ガイドを整備する。

## 進捗状況（Checklist）
- [x] スパイク / 調査
- [x] 実装（コア）
- [x] テスト追加 / 検証
- [x] ドキュメント更新 / リンク確認
- [ ] Plan スナップショット保存（`archive_plan.sh` 実行）

## 実行計画（Plan）
1. worktree 運用要件を整理し、ドキュメント更新範囲と必要なスクリプト仕様を確定する。
2. `plans.md` を起点にドキュメント草案を作成し、`AGENTS.md` / `docs/20-process/agents/README.md` / `docs/20-process/exec-plan.md` に worktree 手順を追記する。
3. `scripts/worktree/create.sh`（仮称）と `scripts/exec_plan/bootstrap.sh` の slug 正規化改善を実装し、標準的な worktree 作成フローを自動化する。
4. worktree 環境で `scripts/exec_plan/bootstrap.sh` を含む Exec Plan コマンドを実行して挙動を確認し、結果を決定ログ・Findings に反映する。
5. 変更内容をレビューし、Records / PR 用の情報を整理する。

## 決定ログ（Decision Log）
- 2025-10-14: Git worktree の標準パスを `${REPO_DIRNAME}.worktrees/<branch>` とし、ディレクトリ衝突を避けるスクリプトを実装する（検証済み）。
- 2025-10-14: Quickstart（`AGENTS.md`）と詳細ガイド（`docs/20-process/agents/README.md` / `docs/20-process/exec-plan.md`）に「Multi-Agent Worktree Flow」セクションを追加し、スクリプト活用と手動 fallback を併記する方針とする。
- 2025-10-14: `scripts/exec_plan/bootstrap.sh` の slug 判定を正規化して worktree slug（ハイフン区切り）でも既存 Issue を自動検出できるよう改修する。

## 発見と驚き（Findings）
- `.aidlc/` 配下に該当コンテキストは存在しないため、Issue と既存ドキュメントが唯一の情報源。
- 既存の `scripts/exec_plan/bootstrap.sh` は here-doc とヒアストリングの組み合わせで Python スクリプトが実行されず、slug マッチングが常に失敗していた。JSONを環境変数に渡す形式へ改修して解消。
- `scripts/worktree/create.sh` で `framework/28-git-worktree-validation` を生成→`git worktree remove` で片付ける流れを確認し、デフォルトルート（`../YokaKit_Studio.worktrees/`）が期待どおり作成されることを検証。
- 改修後の `scripts/exec_plan/bootstrap.sh --slug git-worktree --filter-label track::framework` は元ワークツリーおよび新規 worktree 双方で Issue #28 を検出できることを確認。
- `gh issue create` が `--json` 非対応な環境でも Issue 作成を継続できるよう、フォールバック処理（HTML出力から番号/URL抽出）を追加した。

## リスク / 代替案
- リスク: worktree 生成パスの衝突や削除漏れで混乱する可能性。回避策としてスクリプトで存在チェックとヒントを提供する。
- 代替案: 手動で `git worktree add` を都度実行する。→ 操作手順が煩雑でナレッジが共有されないため不採用。

## To-Do
1. [x] worktree 運用要件の整理メモを確定し、決定ログへ反映
2. [x] ドキュメント更新（AGENTS.md, docs/20-process/agents/README.md, docs/20-process/exec-plan.md）
3. [x] `scripts/worktree/create.sh` と `scripts/exec_plan/bootstrap.sh` の改善を実装し、使い方をドキュメントへ記載
4. [x] worktree 上で Exec Plan コマンドを検証し、結果を Findings/Docs に反映
5. [ ] records に plans.md を保存（`bash scripts/records/archive_plan.sh <pr-number> <slug>` を実行し、`records/by-pr/<pr>-git-worktree/plans.md` と `summary.md` のリンクを確認）
6. [x] records/by-pr/39-git-worktree/summary.md に作業内容を記述（Summary / Key Points / Decisions / Links を反映）
7. [ ] records への保存後、ブランチ上の `plans.md` を削除（PR 差分から除外）

## Cross-Repository（必要時）
| Repo | Branch | Order | Notes |
|------|--------|-------|-------|
| なし | - | - | 現時点で Cross-Repo 作業は発生しない前提 |

## 次アクション
- [ ] `plans.md` を `bash scripts/records/archive_plan.sh 39 git-worktree` で保存し、ブランチから削除する。
- [ ] PR ready 化に向けてレビュー指摘や追加フィードバックを反映する。

---
メモ
- 本ファイルは作業ブランチ（短命文書）。`archive_plan.sh` で保存した後はブランチから削除し、PR（records/by-pr）から参照可能にする。
- records の要約には本ファイル（plans.md）へのリンクを追加する。
