# Exec Plan: Issue ステータスラベル再設計

> 使い方（雛形：Deferred GitHub Ops 推奨）
> - このファイルをブランチ直下 `plans.md` にコピーして編集します。
> - プラン初稿に合意したら、Issue/PR（Draft）を作成し `scripts/records/new_pr_summary.sh` で要約を生成、マージ前に `scripts/records/archive_plan.sh` でスナップショットを保存します。
>
> 推奨コマンド例:
> ```bash
> set -euo pipefail
> ISSUE=<n>; SLUG=<slug>; PR=<pr>; REPO=https://github.com/<org>/<repo>; AUTHOR=@you
> cp docs/60-templates/exec-plan.md plans.md
> bash scripts/records/new_pr_summary.sh ${PR} ${SLUG} --issue ${ISSUE} --repo-url ${REPO} --author ${AUTHOR}
> # 作業…
> bash scripts/records/archive_plan.sh ${PR} ${SLUG}
> ```

## 目的 / ゴール
- Issue の `status::` ラベル体系を簡素化しつつ、担当の重複を防げる運用フローを設計する。
- `docs/10-governance/framework/README.md` と `scripts/setup_labels.sh` を同期させた状態で更新する。
- 新運用を周知するための次アクション（Exec Plan の更新方針）を整理する。

## 範囲 / 非範囲
- 対象: `status::` 系ラベルの設計、関連ドキュメント/スクリプト更新。
- 非範囲: `track::` や `artifact::` など他軸の改定、GitHub 上での実ラベル同期実行。
- 前提: フレームワーク整備フェーズで運用する前提、他プロセス文書との整合は既存記述に従う。

## 参照 / コンテキスト
- Issue: （未紐付け／後続で起票予定）
- ADR / 設計: `.aidlc/contexts/`（該当なしを確認予定）
- 関連Docs: `docs/10-governance/framework/README.md`, `docs/20-process/agents/README.md`
 - PR: https://github.com/w-pinkietech/YokaKit_Studio/pull/22
 - Records: `records/by-pr/22-status-label-flow/summary.md`

## 全体像
- 現状の `status::` ラベルは `needs-decision` / `blocked` / `ready` の3種しかなく、同時並行で複数メンバーが同じ Issue に着手してしまうリスクが高い。
- 過剰に細分化せず、準備→担当→作業中→レビュー→完了を明確に切り替えられるミニマムなステップを定義する。
- ドキュメントとスクリプトを更新し、ラベルの意味と付け替えタイミングを明記することで統一された運用を実現する。

## 進捗状況（Checklist）
- [x] スパイク / 調査
- [x] 実装（コア）
- [x] テスト追加 / 検証
- [x] ドキュメント更新 / リンク確認
- [x] Plan スナップショット保存（`archive_plan.sh` 実行）

## 実行計画（Plan）
1. 現在の `status::` ラベル運用を整理し、シンプルなフェーズ案（4〜5段階）を確定する。
2. `docs/10-governance/framework/README.md` に新しいフェーズと運用ルールを反映し、文脈を更新する。
3. `scripts/setup_labels.sh` に新ラベルセットを実装し、既存ラベルの削除/説明更新も反映する。
4. `plans.md` の進捗・決定ログをアップデートし、Draft PR 作成・要約生成の条件を整える。
5. 実ラベル同期や周知に向けたフォローアップ手順を To-Do として整理する。

## 決定ログ（Decision Log）
- 2025-01-13: 細分化しすぎた `status` ではなく「準備→担当→作業中→レビュー→完了」の5段階（`triage` → `ready` → `in-progress` → `in-review` → `done`）で運用する方針を選定。

## 発見と驚き（Findings）
- 変更前は `status::needs-decision/blocked/ready` の3種のみで運用されており、担当状況をラベルで管理できていなかった。
- `docs/20-process/agents/README.md` に詳細な `status::` 記述は無く、今回の変更はフレームワークガバナンス文書側で完結できた。
- `GITHUB_TOKEN=dummy ./scripts/setup_labels.sh example/example --dry-run` / `GITHUB_TOKEN=$(gh auth token) scripts/setup_labels.sh w-pinkietech/YokaKit_Studio` を実行し、ラベル定義のDry-run確認と本番同期を完了。
- Issue #1 のステータスラベルを `status::triage` へ更新し、旧 `status::needs-decision` ラベルを削除した。
- Draft PR 素案 `PR_DRAFT.md` と records summary (`records/by-pr/22-status-label-flow/summary.md`) を準備し、残タスクを明確化できた。

## リスク / 代替案
- リスク: ラベル名称変更に伴う既存 Issue の再分類作業が発生する / 回避策: チーム告知と移行ガイドをまとめ、移行期間を設定。
- 代替案: 既存3種を維持しコメント運用で補う → 手動管理が増え、二重担当防止に失敗するため採用しない。

## To-Do
1. [x] `docs/10-governance/framework/README.md` の `status::` セクションを改訂
2. [x] `scripts/setup_labels.sh` のラベル定義を更新
3. [x] Draft PR / records 要約の作成（`PR_DRAFT.md`, `records/by-pr/22-status-label-flow/summary.md`）
4. [x] records に plans.md を保存（`bash scripts/records/archive_plan.sh 22 status-label-flow` 実行済み）
5. [x] records/by-pr/<pr>-<slug>/summary.md に作業内容を記述（Summary / Key Points / Decisions / Links を反映）

## Cross-Repository（必要時）
| Repo | Branch | Order | Notes |
|------|--------|-------|-------|
| <name> | <framework/<issue>-<slug>> | <1/2/…> | 依存やゲートのメモ |

## 次アクション
- [ ] 変更案のレビュー共有（人間確認が必要な場合に備える）

---
メモ
- 本ファイルは作業ブランチ（短命文書）。マージ後は PR（records/by-pr）から参照可能にする。
- records の要約には本ファイル（plans.md）へのリンクを追加する。
