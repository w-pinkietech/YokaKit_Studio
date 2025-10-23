# Exec Plan Snapshot (2025-01-13 04:45:20)

> branch: framework/29-issue-templates  commit: cd0f7fc

---
# Exec Plan: Issue テンプレート整備

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
> cp studio/60-templates/exec-plan.md plans.md
> bash scripts/records/new_pr_summary.sh ${PR} ${SLUG} --issue ${ISSUE} --repo-url ${REPO} --author ${AUTHOR}
> # 作業…
> bash scripts/records/archive_plan.sh ${PR} ${SLUG}
> rm plans.md
> ```

## 目的 / ゴール
- `.github/ISSUE_TEMPLATE/` に Context Studio 向けの Issue テンプレートを追加し、起票フローを標準化する。
- README / docs に記載されたテンプレート要件と整合を取り、AI エージェントが利用しやすい形にする。
- PR 差分はテンプレート追加とドキュメント整備のみに留め、テスト・検証結果を記録する。

## 範囲 / 非範囲
- 対象: `.github/ISSUE_TEMPLATE/` ディレクトリ新設、Issue テンプレート Markdown 作成、README/doc 更新（必要時）、PR テンプレートとの整合確認。
- 非範囲: GitHub の Issue フォーム（YAML）導入、既存 PR テンプレートの全面改修、他リポジトリへの横展開。
- 前提: docs で定義済みの Issue 項目（背景 / 課題 / 提案 / 影響 / 次のアクション）に準拠する。

## 参照 / コンテキスト
- Issue: #29（`scripts/exec_plan/bootstrap.sh --slug issue-templates --filter-label track::framework`）
- ADR / 設計: （該当なし）
- 関連Docs: `studio/20-process/agents/AGENTS.md`, `studio/20-process/exec-plan.md`, `studio/00-foundation/documentation/standard-procedures.md`
- PR: https://github.com/w-pinkietech/YokaKit_Studio/pull/31
- Records: `records/by-pr/31-issue-templates/summary.md`

## 全体像
- 現状 Issue 起票時の雛形が存在せず、背景や課題、提案など必要項目が人によりばらついている。
- Context Studio に合わせたテンプレート（例: framework task / bug report / feature request）を追加し、AI も利用できるよう YAML front matter を整備する。
- README / docs にテンプレート利用方法を明記し、Exec Plan や records と矛盾しないよう確認する。

## 進捗状況（Checklist）
- [x] スパイク / 調査
- [x] 実装（コア）
- [x] テスト追加 / 検証
- [x] ドキュメント更新 / リンク確認
- [x] Plan スナップショット保存（`archive_plan.sh` 実行）

## 実行計画（Plan）
1. 既存ドキュメントを確認し、Issue に要求される必須項目と分類を整理する（framework task / feature / bug など）。
2. `.github/ISSUE_TEMPLATE/` ディレクトリを新設し、テンプレート Markdown（YAML フロントマター）を作成する。
3. README などでテンプレートへの導線が必要か確認し、必要時に追記・修正する。
4. PR 作成前にテンプレート動作（`gh issue create --template` 等）を Dry-run で確認する。
5. records（summary / plans スナップショット）を更新し、Plan 後片付けを行う。

## 決定ログ（Decision Log）
- 2025-01-13: Issue テンプレートは Markdown + YAML front matter で実装し、AI エージェントも利用可能な構造にする方針。

## 発見と驚き（Findings）
- GitHub Markdown テンプレートは YAML フロントマター内 `labels` をカンマ区切りで指定する必要があるため、カスタムラベルを正確に記載した。
- テンプレートに `受け入れ基準` ブロックを追加することで Issue の完了定義が揃うことを再確認。
- `gh issue create` でテンプレート本文を流用したスモークテスト（Issue #30）を実施し、想定どおりのレイアウトになることを確認、即時クローズ。

## リスク / 代替案
- リスク: テンプレートが冗長になり利用を避けられる / 回避策: 必須項目は最小構成にし、補足セクションは任意で記載。
- 代替案: GitHub Issue フォーム（YAML）での実装 → 設定が複雑になり、当面の必要性が低いため採用しない。

## 受け入れ基準 / Acceptance Criteria
- Issue テンプレートが `.github/ISSUE_TEMPLATE/` に追加され、`gh issue create --template` 等で利用可能。
- テンプレートには背景 / 課題 / 提案 / 影響 / 次のアクションを含む枠組みが用意されている。
- README / docs にテンプレート利用方法と導線が整備されている（必要時）。
- PR ではテンプレート追加とドキュメント更新、動作確認結果が記録されている。

## To-Do
1. [x] `.github/ISSUE_TEMPLATE/` に framework / feature / bug テンプレートを追加
2. [x] ガバナンス & エージェントドキュメントをテンプレート運用に合わせて更新
3. [x] `gh issue create` を用いたスモークテスト（Issue #30）でレイアウト確認
4. [x] records に plans.md を保存（`bash scripts/records/archive_plan.sh <pr-number> <slug>` を実行し、`records/by-pr/<pr>-<slug>/plans.md` と `summary.md` のリンクを確認）
5. [x] records/by-pr/<pr>-<slug>/summary.md に作業内容を記述（Summary / Key Points / Decisions / Links を反映）
6. [x] records への保存後、ブランチ上の `plans.md` を削除（PR 差分から除外）

## Cross-Repository（必要時）
| Repo | Branch | Order | Notes |
|------|--------|-------|-------|
| <name> | <framework/<issue>-<slug>> | <1/2/…> | 依存やゲートのメモ |

## 次アクション
- [x] Draft PR を作成し、records スナップショットを更新する。

---
メモ
- 本ファイルは作業ブランチ（短命文書）。`archive_plan.sh` で保存した後はブランチから削除し、PR（records/by-pr）から参照可能にする。
- records の要約には本ファイル（plans.md）へのリンクを追加する。
