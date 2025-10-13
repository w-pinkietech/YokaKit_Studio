# Agents Quickstart

このドキュメントは、AIエージェントが YokaKit Studio で作業を開始する際に最低限押さえておくべきポイントをまとめたものです。さらに詳しいガイドラインは [docs/process-guides/agents/README.md](docs/process-guides/agents/README.md) を参照してください。

## Immediate Checklist
- 対応する Issue が存在し、状況ラベル（`track::framework` など）が整備されているか確認する。
- 現在のブランチ命名規則とPRフローを [docs/policy/framework/README.md](docs/policy/framework/README.md) で確認する。
- 作業対象の文脈（Intent, ADR, Domain Designなど）を `.aidlc/contexts/` から読み込み、変更理由を明確にする。
- 変更後はテストや検証ステップを実行し、結果を記録する。
- `gh auth status` やトークン設定を確認し、GitHub API へのアクセスが可能な状態にする。
- `scripts/setup_labels.sh --dry-run` を実行し、想定外のラベル差異がないか把握する。

## First Session Flow
1. ルート `README.md` を読み、全体のドキュメント配置を把握する。
2. [docs/policy/framework/README.md](docs/policy/framework/README.md) と [docs/process-guides/development/README.md](docs/process-guides/development/README.md) を通読し、運用ポリシーと開発フローを理解する。
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
YokaKit Studio での作業は AI-DLC プロセスを前提としています。案件に取り組む際は、以下を順番に確認してください。詳細は [docs/process-guides/development/README.md](docs/process-guides/development/README.md) を参照。

1. **Domain Design の確認**  
   - `.aidlc/contexts/<id>/construction/domain-design/` の `static-model.md` と `dynamic-model.md` を読み、用語や責務を把握する。  
   - 足りない定義や不整合があれば Issue を通じて更新を依頼。

2. **Logical Design / ADR の確認**  
   - `.aidlc/contexts/<id>/construction/logical-design/adr/` の最新ADRを読み、採用された技術判断と代替案を理解。  
   - 実装方針がADRと矛盾しないかをチェック。

3. **Test Specification の準備**  
  - [docs/process-guides/development/README.md](docs/process-guides/development/README.md) の「Test Specification」セクションに沿って、必要なテストケースが網羅されているか評価。  
   - 足りない場合は先にテストを補完し、人間レビューを依頼する。

4. **Implementation フェーズ**  
   - テストが FAIL の状態からスタートし、AIが生成するコードを繰り返し検証する。  
   - すべてのテストが PASS し、カバレッジ要件（100%）を満たしているか確認。

5. **Documentation Update**  
   - コード公開後に `code-mapping.md` や関連ドキュメントが最新化されているかを確認。必要に応じて更新を実施。  
   - Pull Request の説明では参照した Intent / ADR / Domain Design を明記する。

6. **フォローアップ**  
   - 発見したギャップは Issue/TODO として残す。  
   - 運用・デプロイに関わる場合は [docs/policy/framework/README.md](docs/policy/framework/README.md) のPRフローに従い、必要な承認を取得する。

## Frequently Used References
- フレームワークガバナンス: [docs/policy/framework/README.md](docs/policy/framework/README.md)
- 開発プロセス詳細: [docs/process-guides/development/README.md](docs/process-guides/development/README.md)
- Claude ツールガイド: [docs/tooling/claude/README.md](docs/tooling/claude/README.md)
- スクリプト・自動化: `scripts/`
- ドキュメントハブ: [docs/README.md](docs/README.md)

## Exec Plan × records（必須運用の要点）
- Draft PR を作成したら、PR要約を作成して本文にリンクを追記する。
  - `bash scripts/records/new_pr_summary.sh <pr-number> <slug> --issue <issue-number> --repo-url https://github.com/<org>/<repo> --author @<you>`
- 複雑な作業は作業ブランチ直下に `plans.md` を用意（短命文書）。テンプレ: `docs/templates/exec-plan.md`。
  - 進捗（チェックボックス）と決定ログを作業の前後で必ず更新。
  - records の要約（`records/by-pr/<pr>-<slug>/summary.md`）の Links に `plans.md` を相対リンクで記録。
- レビューは実装とは別コンテキストで実施し、主要スレッドのPermalinkを records に追記。
- 複数リポ横断時は、毎回PR要約に対象リポ/ブランチ/順序を列挙（カタログは任意・恒常更新不要）。
- スクリプトは厳格モード推奨: `set -euo pipefail`（失敗を早期検知し副作用を防止）。

最後に（Planの保存）
- マージ前に `scripts/records/archive_plan.sh <pr-number> <slug>` を実行し、`plans.md` を `records/by-pr/<pr>-<slug>/plans.md` にスナップショット保存する。

参考: 詳細は [docs/process-guides/agents/AGENTS.md](docs/process-guides/agents/AGENTS.md)（Exec Plan 運用 / records 連携）を参照。

## Exec Plan クイックスタート（Step 1→4）
Step 1: 計画を依頼（plans.md 作成）
- 次の要領で `plans.md` を用意し、実行計画を書かせる。
- 参考資料（仕様・ADR・設計）を添付し、統合方法の調査と詳細計画を指示。
- 初期化コマンド例: `cp docs/templates/exec-plan.md plans.md`

Step 2: plans.md の構造（例）
```
# Exec Plan: <タイトル>

## 全体像
取り組む機能の目的/背景と期待する振る舞い（1〜3段落）

## 進捗状況
- [ ] スパイク：XXXライブラリの調査
- [ ] 機能実装：ストリーミングAPI
- [ ] テスト追加
- [ ] ドキュメント更新

## 発見と驚き
- 依存ライブラリの既知バグ / 想定外の挙動 など

## 決定ログ
YYYY-MM-DD: 採用/却下したアプローチと理由

## To-Do
1. [ ] コア機能の実装
2. [ ] エッジケースのテスト
3. [ ] パフォーマンス最適化
```

Step 3: 実装を実行（進捗に応じ更新）
- `plans.md` に基づき実装し、作業の前後でチェックボックス/決定ログを更新。
- Draft PR で開始し、records の要約に `plans.md` と主要スレッドの Permalink を追記。

Step 4: Plan を records に保存（マージ前）
- `bash scripts/records/archive_plan.sh <pr-number> <slug>` を実行し、`records/by-pr/<pr>-<slug>/plans.md` にスナップショットを保存。
- `records/by-pr/<pr>-<slug>/summary.md` の末尾に「Plan Snapshot: plans.md」リンクが追加されていることを確認。

---
詳細なワークフロー、用語集、チェックリストは [docs/process-guides/agents/README.md](docs/process-guides/agents/README.md) を必ず参照してください。
