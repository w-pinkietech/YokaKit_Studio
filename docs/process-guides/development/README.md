# AI-DLC Development Process Hub

AI 主導でコードを生成する際に求められるドキュメント駆動・テスト駆動プロセスを体系化したディレクトリです。役割別に参照できるよう `stable/` 配下に各ステップの詳細資料を分割しています。

## このディレクトリの目的
- プロセス全体像と成果物ごとの期待事項を整理し、人間/AI が迷わず参照できるようにする。
- ステップ別の詳細手順やテンプレートを分割し、必要な情報に最短でアクセスできる構造を維持する。
- ライフサイクル（`stable/`, `iterative/`, `archive/`）に沿ってプロセス資料を管理し、将来の改訂や棚卸しを容易にする。

## コンテンツ構成（`stable/`）
| パス | 読者 | 概要 |
|------|------|------|
| `stable/overview.md` | 人間/AI | プロセスの背景、コア原則、フェーズ概要。 |
| `stable/step-1-domain-design.md` | 人間/AI | ドメイン設計（静的/動的モデル、コミット基準）。 |
| `stable/step-2-logical-design.md` | 人間/AI | 論理設計・ADR の進め方とレビュー観点。 |
| `stable/step-3-test-specification.md` | 人間/AI | テスト仕様策定、テストコード生成、コミット手順。 |
| `stable/step-4-code-generation.md` | 人間/AI | 実装生成、テスト実行、レビューとコミットの流れ。 |
| `stable/step-5-documentation-update.md` | 人間/AI | Code Mapping / API ドキュメント更新とフォローアップ。 |
| `stable/verification-and-gates.md` | 人間/AI | 各ゲートでの検証チェックリストと完了条件。 |
| `stable/ci-cd-pipeline.md` | 人間/AI | Context Studio / Code Output の CI/CD パイプライン。 |
| `stable/quick-command-reference.md` | AI | コマンドとフェーズ別タスクサマリ。 |
| `stable/best-practices.md` | 人間/AI | 推奨事項とアンチパターン。 |
| `stable/appendix-templates.md` | 人間/AI | テンプレート（Test Spec、Code Review など）。 |

## 利用手順
0. **AIDLC 基本**: 先に [AIDLC Rules/SOP](../../00-foundation/aidlc/README.md) を確認する。
1. **全体の理解**: `stable/overview.md` で原則とワークフローを把握する。
2. **ステップの実行**: 該当フェーズの `stable/step-<n>-*.md` を参照し、成果物と検証ポイントを確認する。
3. **品質ゲート**: コミット前後の検証は `stable/verification-and-gates.md` と `stable/ci-cd-pipeline.md` に従う。
4. **AI 指示・テンプレート**: AI への指示や報告には `stable/quick-command-reference.md` と `stable/appendix-templates.md` を活用する。

## ライフサイクル方針
- `stable/`: 現行の確定プロセス。更新時は Issue で合意し、該当ファイルと索引を同時に更新する。
- `iterative/`（未作成）: Bolt ごとに試行している補足資料を置く場合に使用する。
- `archive/`（未作成）: 廃止済みプロセスを保管する。README からはリンクを外す。

## 関連資料
- [Process Guides Hub](../README.md)
- [Agents Operations Guide](../agents/README.md)
- [Policy Framework](../../policy/framework/README.md)
- [Documentation Rules / SOP](../../00-foundation/documentation/README.md)
- [AIDLC Rules/SOP](../../00-foundation/aidlc/README.md)
