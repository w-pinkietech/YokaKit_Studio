# Agents Quickstart

このドキュメントは、AIエージェントが YokaKit Studio で作業を開始する際に最低限押さえておくべきポイントをまとめたものです。さらに詳しいガイドラインは [docs/AGENTS.md](docs/AGENTS.md) を参照してください。

## Immediate Checklist
- 対応する Issue が存在し、状況ラベル（`track::framework` など）が整備されているか確認する。
- 現在のブランチ命名規則とPRフローを [docs/framework-governance.md](docs/framework-governance.md) で確認する。
- 作業対象の文脈（Intent, ADR, Domain Designなど）を `.aidlc/contexts/` から読み込み、変更理由を明確にする。
- 変更後はテストや検証ステップを実行し、結果を記録する。
- `gh auth status` やトークン設定を確認し、GitHub API へのアクセスが可能な状態にする。
- `scripts/setup_labels.sh --dry-run` を実行し、想定外のラベル差異がないか把握する。

## First Session Flow
1. ルート `README.md` を読み、全体のドキュメント配置を把握する。
2. [docs/framework-governance.md](docs/framework-governance.md) と [docs/development-process.md](docs/development-process.md) を通読し、運用ポリシーと開発フローを理解する。
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
YokaKit Studio での作業は AI-DLC プロセスを前提としています。案件に取り組む際は、以下を順番に確認してください。詳細は [docs/development-process.md](docs/development-process.md) を参照。

1. **Domain Design の確認**  
   - `.aidlc/contexts/<id>/construction/domain-design/` の `static-model.md` と `dynamic-model.md` を読み、用語や責務を把握する。  
   - 足りない定義や不整合があれば Issue を通じて更新を依頼。

2. **Logical Design / ADR の確認**  
   - `.aidlc/contexts/<id>/construction/logical-design/adr/` の最新ADRを読み、採用された技術判断と代替案を理解。  
   - 実装方針がADRと矛盾しないかをチェック。

3. **Test Specification の準備**  
   - [docs/development-process.md](docs/development-process.md) の「Test Specification」セクションに沿って、必要なテストケースが網羅されているか評価。  
   - 足りない場合は先にテストを補完し、人間レビューを依頼する。

4. **Implementation フェーズ**  
   - テストが FAIL の状態からスタートし、AIが生成するコードを繰り返し検証する。  
   - すべてのテストが PASS し、カバレッジ要件（100%）を満たしているか確認。

5. **Documentation Update**  
   - コード公開後に `code-mapping.md` や関連ドキュメントが最新化されているかを確認。必要に応じて更新を実施。  
   - Pull Request の説明では参照した Intent / ADR / Domain Design を明記する。

6. **フォローアップ**  
   - 発見したギャップは Issue/TODO として残す。  
   - 運用・デプロイに関わる場合は [docs/framework-governance.md](docs/framework-governance.md) のPRフローに従い、必要な承認を取得する。

## Frequently Used References
- フレームワークガバナンス: [docs/framework-governance.md](docs/framework-governance.md)
- 開発プロセス詳細: [docs/development-process.md](docs/development-process.md)
- スクリプト・自動化: `scripts/`
- ドキュメントハブ: [docs/README.md](docs/README.md)

---
詳細なワークフロー、用語集、チェックリストは [docs/AGENTS.md](docs/AGENTS.md) を必ず参照してください。
