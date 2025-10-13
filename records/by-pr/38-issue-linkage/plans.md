# Exec Plan Snapshot (2025-10-14 05:40:22)

> branch: framework/35-issue-linkage  commit: 02b7a86

---
# Exec Plan: framework issue linkage automation

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
- PR/Exec Plan 周辺の運用を更新し、全 PR が関連 Issue を明示する（Closes #<n>）フローをテンプレートと自動化で強制できる状態にする。
- docs（agents/exec-plan 系）とテンプレ類の指示が整合し、実務チェックリストから漏れなく参照できるようにする。

## 範囲 / 非範囲
- 対象: #35 / #36 / #37 に記載された framework 運用の更新（PR テンプレ調整、PR 作成支援スクリプト、Exec Plan ドキュメント）。
- 非範囲: GitHub Actions 等の CI 設定変更、records 既存データの一括修正。必要ならフォローアップ Issue を提案。

## 参照 / コンテキスト
- Issue: #35 enforce related-issue section in PR templates / #36 auto-inject closes reference when creating PR / #37 update exec plan workflow for mandatory issue linkage
- ADR / 設計: （該当なし、プロセス運用ドキュメントのみ）
- 関連Docs: `docs/10-governance/framework/README.md`, `docs/20-process/agents/AGENTS.md`, `docs/20-process/agents/README.md`, `docs/20-process/exec-plan.md`
 - PR: https://github.com/<org>/<repo>/pull/<pr> （draft 作成時に更新）
 - Records: `records/by-pr/<pr>-issue-linkage/summary.md` （作成後に記載）

## 全体像
- 既存 PR テンプレートでは checklist で Closes #<n> を確認しているのみで、関連 Issue セクションが明示されていない。また PR 作成補助コマンドでは Closes 行を自動挿入せず、手作業での記述漏れが発生し得る。
- Exec Plan ドキュメントと Agents ガイドにおいても、Issue 連携が必須である旨が散在しており、フローの中で「必ず Closes を入れる」ことが十分に強調されていない。
- 3 つの Issue をまとめて対応し、テンプレート/スクリプト/docs の整合性を取りつつ、今後の作業者が迷わないようチェックリストと運用ガイドを更新する。

## 進捗状況（Checklist）
- [x] スパイク / 調査
- [x] 実装（コア）
- [x] テスト追加 / 検証
- [x] ドキュメント更新 / リンク確認
- [ ] Plan スナップショット保存（`archive_plan.sh` 実行）

## 実行計画（Plan）
1. 現状把握: PR テンプレ / PR 作成コマンド / agents & exec-plan docs の Issue 連携記述を棚卸しし、ギャップを洗い出す。
2. 実装: (#35 #36) PR テンプレに「Related Issues」セクションを追加し、PR 作成補助フローで `Closes #<n>` を自動差し込み（再実行 idempotent）できるよう更新する。
3. ドキュメント: (#37) Agents/Exec Plan ドキュメントのチェックリストや手順を更新し、Issue 連携が必須であることと自動化手順を明記。必要に応じて INDEX/README の導線も整える。
4. 検証/記録: 変更差分を確認し、必要なテスト（lint/シェルスクリプト shellcheck? 手動確認）を実施。Plans/records 更新手順は PR 作成フェーズで対応。

## 決定ログ（Decision Log）
- 2025-10-14: PR 本文の Related Issues を確実に維持するため、`scripts/exec_plan/prepare_pr_body.sh` で PR テンプレートの自動生成を行う方針を採用。

## 発見と驚き（Findings）
- PR テンプレートに Related Issues セクションが存在しなかったため、自動スクリプト用のマーカーコメントを設けることでテンプレート側とスクリプト側の両立が可能になった。
- `shellcheck` が環境に無いため、`scripts/exec_plan/prepare_pr_body.sh` は手動レビューとサンプル実行（`--issue 35 --issue 36`）で確認した。
- 実際の Draft PR 用に `scripts/exec_plan/prepare_pr_body.sh --issue 35 --issue 36 --issue 37 --output PR_DRAFT.md` を実行し、`PR_DRAFT.md` をリポジトリ直下に生成した。

## リスク / 代替案
- リスク: GitHub UI 上で直接 PR を編集するとスクリプトを経由せず `Closes #<n>` を書き忘れる可能性 / 回避策: PR テンプレートにプレースホルダを残し、ドキュメント・チェックリストで必須化。
- 代替案: GitHub Actions で Closes 行を検証する → 短期ではオーバーヘッドが大きいため今回は採用しない（将来のフォローアップ候補）。

## To-Do
1. [x] PR テンプレートに Related Issues セクションを追加しチェックボックス要件を整備
2. [x] PR 作成補助スクリプト（or docs）で `Closes #<n>` の自動挿入を実装し、利用方法を記載
3. [x] Agents / Exec Plan / Framework docs に Issue 連携必須手順を反映
4. [x] records に plans.md を保存（`bash scripts/records/archive_plan.sh <pr-number> <slug>` を実行し、`records/by-pr/<pr>-issue-linkage>/plans.md` と `summary.md` のリンクを確認）
5. [x] records/by-pr/<pr>-issue-linkage/summary.md に作業内容を記述（Summary / Key Points / Decisions / Links を反映）
6. [x] records への保存後、ブランチ上の `plans.md` を削除（PR 差分から除外）

## Cross-Repository（必要時）
| Repo | Branch | Order | Notes |
|------|--------|-------|-------|
| <name> | <framework/<issue>-<slug>> | <1/2/…> | 依存やゲートのメモ |

## 次アクション
- [ ] `shellcheck` が利用可能になったら `scripts/exec_plan/prepare_pr_body.sh` を lint する。

---
メモ
- 本ファイルは作業ブランチ（短命文書）。`archive_plan.sh` で保存した後はブランチから削除し、PR（records/by-pr）から参照可能にする。
- records の要約には本ファイル（plans.md）へのリンクを追加する。
