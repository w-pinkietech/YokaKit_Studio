## AIDLC Rules（不変原則）

### 目的と対象
- 目的: AI を主体とした開発ライフサイクル（AIDLC）の前提・用語・成果物の責務を定義し、再現性のある実務を可能にする。
- 対象: 本リポジトリで AIDLC に従って作業・レビューを行うメンバー（人間/AI）。

### フェーズ（高レベル）
- Inception: 意図・要求の明確化、用語/境界の定義、初期方針策定
- Construction: 仕様→テスト→実装→検証の反復、成果物の基準合格
- Operations: 運用・保守・レビューサイクル、改善フィードバックの取り込み

### 主要アーティファクト（責務の要約）
- Domain Design（静的/動的モデル）: 用語・責務・振る舞いの合意
- Logical Design / ADR: 技術判断と代替案、採用理由の記録
- Test Specification: 合格基準、カバレッジ、ケース網羅性
- Code / Assets: 実装と成果物、テストにより検証済み
- Documentation: ルール/手順/参照の整備（本ディレクトリ）

### 原則
1) Documentation-First: ルール/意図/合意を先に明文化する
2) Test-Driven: FAIL から START、PASS まで最短で回す（TDD の実践）
3) Single Source: 重複禁止、唯一の出典にリンク集約
4) Three-File Entry: README/AGENTS/INDEX の三点セットを徹底
5) Traceability: 変更理由・影響範囲・参照関係を追跡可能に

> **参考**: Test-Driven Development (TDD) は Kent Beck によって体系化された開発手法です。詳細は [Test Driven Development: By Example](https://www.amazon.com/Test-Driven-Development-Kent-Beck/dp/0321146530) を参照してください。

### 命名/構造
- ブランチ: `framework/<issue-number>-<slug>`
- PR: レイヤ接頭辞 `[]` を推奨（例: `[foundation]`）
- ファイル分割: ~1000行 or 6セクション超で分割、`INDEX.md` に集約

### チェックリスト
- [ ] 目的/対象/範囲が冒頭に明記されている
- [ ] 用語・責務の定義が重複していない（唯一の出典へリンク）
- [ ] 三点セットが整備され導線が機能している
- [ ] 参照リンクが最新で、プレビューで切れていない
- [ ] 変更理由・影響範囲・検証結果が Issue/PR に記録されている

### 用語集（Glossary）
- Intent（意図）: 取り組む目的・達成したい価値の明示。
- Domain Design: 静的/動的モデルで用語・責務・振る舞いを定義した資料。
- ADR（Architecture Decision Record）: 技術判断の記録（採用理由・代替案・影響）。Michael Nygard が提唱したパターン（[Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)）。
- Context: ひとまとまりの目的/要件/成果物で切られた単位。
- Artifact: AIDLC で生成・更新される成果物（設計/仕様/テスト/コード/ドキュメント）。
- Test Specification: 合格基準を含むテストの仕様（ケース網羅とトレーサビリティ）。
- Acceptance Criteria: 完了/合格の判断条件（明確な観測可能性が必要）。
- Code Mapping: コンテキストと実装の対応表（追跡性の確保）。
- Runbook: 定常/障害対応の手順書（具体的な手順と判断基準）。
- Reference: 参照系資料（用語集/仕様/API/マッピング等）。
- Template: 繰り返し利用する雛形（README/AGENTS/INDEX など）。
- Governance: 運用ガバナンス（Issue/PR/ラベル/レビュー方針）。
- SOP（Standard Operating Procedures）: 標準手順書（本番のやり方）。

### アーティファクト責務表（型）
| アーティファクト | 入力 | 出力 | 合格基準 | 出典/参照 |
|---|---|---|---|---|
| Domain Design | Intent, 既存用語 | 静的/動的モデル | 用語の一意性、責務の明確化 | rules.md, reference/ |
| ADR | 要件, 制約, 代替案 | 採用判断の記録 | 採用理由と影響が明確 | decisions/ or stable docs |
| Test Spec | 要件, モデル | テストケース, 合格基準 | カバレッジ達成, トレース可 | stable/verification |
| Code | Test Spec | 実装/資産 | テストPASS, 静的解析合格 | repo/code |
| Documentation | 実装/設計の差分 | 更新済みドキュメント | 三点セット同期, リンク正常 | studio/ |

