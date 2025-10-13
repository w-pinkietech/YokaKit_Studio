# Agents Operations Checklist

## 目的
- エージェントが作業を始める前に必要な情報源とガイドを素早く確認できるようにする。
- `docs/20-process/agents/README.md` の要点を抜粋し、タスク遂行時のチェックリストとして利用する。

## 事前確認
- [ ] 対応する Issue に `track::`, `artifact::`, `status::`, `impact::` ラベルが付与されているか。
- [ ] Issue 起票時は `.github/ISSUE_TEMPLATE/` のテンプレート（framework / feature / bug）を利用したか。
- [ ] 作業ブランチが `framework/<issue-number>-<slug>` 等の命名規則に従っているか。
- [ ] `.aidlc/contexts/<id>/` で関連する Intent / Domain Design / ADR を確認したか。
- [ ] `gh auth status` を実行し、GitHub CLI の認証が有効か確認したか。
- [ ] `scripts/setup_labels.sh --dry-run` を実行してラベル差異を把握したか。

## 実行時チェック
- [ ] 作業対象ドキュメントの参照先（Policy / Process Guides）を最新化したか。
- [ ] 必要なテスト・検証ステップを `docs/20-process/development/README.md` で確認したか。
- [ ] 変更後に `code-mapping.md` と関連ドキュメントの同期が必要か判断したか。
- [ ] PR の Related Issues セクションに `Closes #<issue>` を記載し、検証手順結果を共有したか。

## リンク集
- [Process Guide (Full)](README.md)
- [Development Process](../development/README.md)
- [Policy Framework](../../10-governance/framework/README.md)

## Exec Plan 運用（plans.md）
詳説は [../exec-plan.md](../exec-plan.md) を参照。以下はエージェント視点の要点抜粋です。
複雑な機能実装や大規模リファクタでは、ブランチ直下に `plans.md` を置き、計画→実装→検証の進捗を可視化します。マージ後は履歴として PR（records/by-pr）から辿れるため、`plans.md` はブランチ単位のエフェメラル（短命）文書として扱います。

推奨ルール
- 作りどき: 仕様が複数ステップに分かれる、または1時間超の自動作業を任せる場合。
- 配置: 作業ブランチ直下 `plans.md`（リポジトリルート）。
- 構成: 目的/範囲、進捗チェックボックス、決定ログ、リスク、次アクション。
- 更新: 作業の前後で「進捗」「決定ログ」を必ず更新する。
- 終了: `bash scripts/records/archive_plan.sh <pr> <slug>` で記録したら、ブランチ上の `plans.md` は削除する（records にスナップショットが残る）。

テンプレート
- ひな型: `docs/60-templates/exec-plan.md` をコピーして `plans.md` を作成。
- Issue 確認: `scripts/exec_plan/bootstrap.sh --slug <slug> --filter-label track::framework --title "[framework] <title>"` で紐づく Issue を自動検出/作成。
- PR 本文: Draft PR 作成時は `scripts/exec_plan/prepare_pr_body.sh --issue <n> --output PR_DRAFT.md` で Related Issues セクションに `Closes #<n>` を自動挿入し、そのまま `gh pr create --draft --body-file PR_DRAFT.md` を実行する（複数 Issue は `--issue` を追加）。

補助コマンド例
- 継続テスト: `watch -n 1 "npm test"` / `cargo test` 等
- 厳格モードでのスクリプト実行: `set -euo pipefail`（早期失敗で安全性を高める）
- Draft PR の本文生成: `scripts/exec_plan/prepare_pr_body.sh --issue <n> --output PR_DRAFT.md`

## records 連携（PR要約との紐付け）
PR 単位で必ず `records/by-pr/<number>-<slug>/summary.md` を作成し、以下を記録します。
- Links に `plans.md`（ブランチ上）の相対リンクを追記
- 主要スレッド（レビュー/議論）のパーマリンク
- 決定事項（Decisions）と docs への反映先（impacts）

ワークフロー
1) Draft PR 作成 → records 要約を生成して PR 本文にパスを追記  
2) 実装しつつ `plans.md` を更新（進捗/決定ログ）  
3) レビューは別コンテキストで実行し、合意後に records 要約へ Permalink を追記  
4) マージ前に Plan をスナップショット保存: `bash scripts/records/archive_plan.sh <pr-number> <slug>`  
5) マージ後、Issue は自動クローズ（`Closes #<n>`）。`records/by-pr/<pr>-<slug>/plans.md` から参照可能。
