# Agents Quickstart

このドキュメントは、AIエージェントが YokaKit Studio で作業を開始する際に最低限押さえておくべきポイントをまとめたものです。さらに詳しいガイドラインは [studio/20-process/agents/README.md](studio/20-process/agents/README.md) を参照してください。

## Start Here: Exec Plan 実行手順（最優先）
最初に以下の手順で「計画→実装→記録」を動かしてください。詳細は [studio/20-process/exec-plan.md](studio/20-process/exec-plan.md) と [studio/20-process/agents/AGENTS.md](studio/20-process/agents/AGENTS.md) を参照。

- 0) 前提（推奨）: `set -euo pipefail` を使い失敗時に即中断。
- 0.5) Issue チェック: `scripts/exec_plan/bootstrap.sh --slug <slug> --filter-label track::framework --title "[framework] <title>"` で既存 Issue を検出/必要なら生成。
- 1) 計画作成: `cp studio/60-templates/exec-plan.md plans.md`（ブランチ直下に配置）
- 2) プラン初稿を作成し、必要なら人間レビューで合意
- 3) Issue/PR（Draft）作成 → PR番号 `<n>` と `slug` を決め、records 要約を生成して PR 本文にリンク
  - `bash scripts/records/new_pr_summary.sh <n> <slug> --issue <issue> --repo-url https://github.com/<org>/<repo> --author @<you>`
  - `scripts/exec_plan/prepare_pr_body.sh --issue ${ISSUE} --output PR_DRAFT.md` でPR本文を生成し、`gh pr create --draft --body-file PR_DRAFT.md` で Draft PR を起票（ready の場合は `--draft` を外す）
- 4) 実装しながら `plans.md` の進捗/決定ログを更新
- 5) マージ前: `bash scripts/records/archive_plan.sh <n> <slug>` で `records/by-pr/<n>-<slug>/plans.md` にスナップショットを保存（summary にリンクも追記）
  - `records/by-pr/<n>-<slug>/summary.md` に作業内容（Summary / Key Points / Decisions / Links）を記述し、PR本文と整合を取る
- 6) アーカイブ後の後片付け: ブランチ上の `plans.md` を削除し、PR を ready → merge。

Quick commands（雛形・変数化）
```
# 変数（例）
ISSUE=123
SLUG=layered-docs
PR=21
REPO=https://github.com/<org>/<repo>
AUTHOR=@you

# Issue検出/自動作成
scripts/exec_plan/bootstrap.sh --slug ${SLUG} --filter-label track::framework \
  --title "[framework] <title>" --labels "track::framework,artifact::process,status::triage,lifecycle::draft" \
  --repo ${REPO}

# ブランチ作成（例）
git checkout -b framework/${ISSUE}-${SLUG}

# 計画の雛形
cp studio/60-templates/exec-plan.md plans.md

# PR要約の作成（再実行可: idempotent）
bash scripts/records/new_pr_summary.sh ${PR} ${SLUG} --issue ${ISSUE} \
  --repo-url ${REPO} --author ${AUTHOR}
# PR本文の自動生成と Draft PR 起票（ready の場合は --draft を外す）
scripts/exec_plan/prepare_pr_body.sh --issue ${ISSUE} --output PR_DRAFT.md
gh pr create --draft --body-file PR_DRAFT.md --title "[framework] <title>"

# Plan の保存（マージ前に1回実行）
bash scripts/records/archive_plan.sh ${PR} ${SLUG}

# 後片付け（記録済みの plans.md を削除）
rm plans.md
```

To-Do（Exec Plan）
- [ ] 計画の雛形をコピー（plans.md 作成）
- [ ] プラン初稿を作成・合意（レビュー）
- [ ] Issue/PR（Draft）を作成し、PR 要約を生成（records/by-pr/<pr>-<slug>/summary.md）
- [ ] `scripts/exec_plan/prepare_pr_body.sh` で `PR_DRAFT.md` を生成し、Related Issues セクションに `Closes #<n>` を挿入
- [ ] 実装しながら plans.md を更新（進捗/決定/リスク）
- [ ] マージ前に Plan を保存（archive_plan.sh で plans.md をスナップショット）
- [ ] summary.md に作業内容を記述（Summary / Key Points / Decisions / Links を反映）
- [ ] 記録完了後、ブランチ上の `plans.md` を削除（PRに残らないよう整備）

## Immediate Checklist
- 対応する Issue が存在し、状況ラベル（`track::framework` など）が整備されているか確認する。
- 現在のブランチ命名規則とPRフローを [studio/10-governance/framework/README.md](studio/10-governance/framework/README.md) で確認する。
- Draft PR を作成する前に `scripts/exec_plan/prepare_pr_body.sh` で Related Issues セクションに `Closes #<n>` が入っていることを確認する。
- 作業対象の文脈（Intent, ADR, Domain Designなど）を `.aidlc/contexts/` から読み込み、変更理由を明確にする。
- 変更後はテストや検証ステップを実行し、結果を記録する。
- `gh auth status` やトークン設定を確認し、GitHub API へのアクセスが可能な状態にする。
- `scripts/setup_labels.sh --dry-run` を実行し、想定外のラベル差異がないか把握する。

## First Session Flow
1. ルート `README.md` を読み、全体のドキュメント配置を把握する。
2. [studio/10-governance/framework/README.md](studio/10-governance/framework/README.md) と [studio/20-process/development/README.md](studio/20-process/development/README.md) を通読し、運用ポリシーと開発フローを理解する。
3. GitHub Issue を `track::` ラベルでフィルタし、担当予定の Issue が `status::ready` かを確認する。
4. `.aidlc/constitution` および該当する context ディレクトリ（例: `.aidlc/contexts/<id>-<feature>/`）を読み、背景情報を吸収する。
5. 必要に応じて Submodule (`submodules/`) の現在のコミットを `git submodule status` で確認する。
6. 作業開始前に Draft PR テンプレートやコードオーナーの期待値を再確認する（存在する場合）。

## Context Retrieval Tips
- Intent/Units/Stories などは `.aidlc/contexts/<id>/inception/` 配下に整理されています。
- Domain & Logical Design は `.aidlc/contexts/<id>/construction/` 配下を参照。
- コードとの対応は `code-mapping.md`（同階層）で特定できます。
- 参照リポジトリは `submodules/references/`、出力コードは `submodules/code-output/` にあります。

## AI-DLC Execution Checklist
YokaKit Studio での作業は AI-DLC プロセスを前提としています。案件に取り組む際は、以下を順番に確認してください。詳細は [studio/20-process/development/README.md](studio/20-process/development/README.md) を参照。

1. **Domain Design の確認**  
   - `.aidlc/contexts/<id>/construction/domain-design/` の `static-model.md` と `dynamic-model.md` を読み、用語や責務を把握する。  
   - 足りない定義や不整合があれば Issue を通じて更新を依頼。

2. **Logical Design / ADR の確認**  
   - `.aidlc/contexts/<id>/construction/logical-design/adr/` の最新ADRを読み、採用された技術判断と代替案を理解。  
   - 実装方針がADRと矛盾しないかをチェック。

3. **Test Specification の準備**  
  - [studio/20-process/development/README.md](studio/20-process/development/README.md) の「Test Specification」セクションに沿って、必要なテストケースが網羅されているか評価。  
   - 足りない場合は先にテストを補完し、人間レビューを依頼する。

4. **Implementation フェーズ**  
   - テストが FAIL の状態からスタートし、AIが生成するコードを繰り返し検証する。  
   - すべてのテストが PASS し、カバレッジ要件（100%）を満たしているか確認。

5. **Documentation Update**  
   - コード公開後に `code-mapping.md` や関連ドキュメントが最新化されているかを確認。必要に応じて更新を実施。  
   - Pull Request の説明では参照した Intent / ADR / Domain Design を明記する。

6. **フォローアップ**  
   - 発見したギャップは Issue/TODO として残す。  
   - 運用・デプロイに関わる場合は [studio/10-governance/framework/README.md](studio/10-governance/framework/README.md) のPRフローに従い、必要な承認を取得する。

## Frequently Used References
- フレームワークガバナンス: [studio/10-governance/framework/README.md](studio/10-governance/framework/README.md)
- 開発プロセス詳細: [studio/20-process/development/README.md](studio/20-process/development/README.md)
- Claude ツールガイド: [studio/50-tooling/claude/README.md](studio/50-tooling/claude/README.md)
- スクリプト・自動化: `scripts/`
- ドキュメントハブ: [studio/README.md](studio/README.md)

## 実務メモ（最小要点）
- Draft PR 後に records の要約を作成し、PR本文へリンク。
  - `bash scripts/records/new_pr_summary.sh <pr-number> <slug> --issue <issue-number> --repo-url https://github.com/<org>/<repo> --author @<you>`
- 複雑な作業は `plans.md`（テンプレ: `studio/60-templates/exec-plan.md`）を作業ブランチ直下に置く。
- レビューは別コンテキストで実行し、主要スレッドの Permalink を records に追記。
- Cross-Repo は毎回 PR 要約に対象リポ/ブランチ/順序を列挙（カタログは任意）。
- スクリプトは厳格モード推奨: `set -euo pipefail`。

## Exec Plan（詳細ガイド）
詳細な手順・サンプル構造は、以下を参照してください。
- Exec Plan 手順（Process層）: `studio/20-process/exec-plan.md`
- 運用詳細とワークフロー: `studio/20-process/agents/AGENTS.md`
- ひな型（Templates層）: `studio/60-templates/exec-plan.md`

---
詳細なワークフロー、用語集、チェックリストは [studio/20-process/agents/README.md](studio/20-process/agents/README.md) を必ず参照してください。
