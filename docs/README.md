# YokaKit Studio Documentation Hub

人間がプロジェクトの背景・運用ポリシーを把握しやすくするためのエントリーポイントです。ドキュメントは役割ごとに整理され、AIエージェント向け資料とは分離しています。

## このディレクトリの目的
- ドキュメントの配置先を統一し、参照導線を明確化する。
- フレームワーク整備期に増加するガイド類を集約し、ルートディレクトリの煩雑化を防ぐ。
- 人間読者に必要な情報（プロセス、ガバナンス、セットアップなど）を1カ所で辿れるようにする。

## コンテンツ概要
| パス | 対象読者 | 概要 |
|------|-----------|------|
| `README.md` | 人間 | このファイル。全体像と主要ドキュメントへの案内。 |
| `AGENTS.md` | AIエージェント | AI向けの作業導線。 |
| `INDEX.md` | 人間/AI | `docs/` 全体の目次（索引）。 |
| `policy/` | 人間/AI | ガバナンス系カテゴリのハブ（framework / documentation）。 |
| `00-foundation/documentation/` | 人間/AI | ドキュメントルールと標準手順（Foundation層）。 |
| `00-foundation/aidlc/` | 人間/AI | AIDLC のルールと標準手順（Foundation層）。 |
| `policy/framework/` | 人間/AI | 運用ガバナンス（Issue/PR/ラベル運用、レビュー方針）。 |
| `process-guides/` | 人間/AI | 実務手順・SOP のカテゴリ（development / agents）。 |
| `process-guides/development/README.md` | 人間/AI | AI-DLC の開発プロセス（TDD/ドキュメント駆動）概要。 |
| `process-guides/agents/README.md` | AIエージェント | エージェント運用の詳細ガイド。 |
| `reference/` | 人間/AI | 用語集・仕様・コードマッピングなど参照情報。 |
| `tooling/` | 人間/AI | ツールセットアップと運用ガイド（例: Claude）。 |
| `tooling/claude/README.md` | 人間/AI | Claude セットアップとスラッシュコマンド運用。 |
| `templates/` | 人間/AI | README / AGENTS / INDEX 等のテンプレート集。 |

## 参照ナビゲーション
- プロジェクト概要・アーキテクチャ: ルート `README.md`
- ドキュメントルール・標準手順: [00-foundation/documentation/INDEX.md](00-foundation/documentation/INDEX.md)
- AIDLC ルール・標準手順: [00-foundation/aidlc/INDEX.md](00-foundation/aidlc/INDEX.md)
- フレームワークガバナンス: [policy/framework/README.md](policy/framework/README.md)
- 開発プロセス詳細: [process-guides/development/README.md](process-guides/development/README.md)
- ツールセットアップ: [tooling/README.md](tooling/README.md)
- Claude 運用手順: [tooling/claude/README.md](tooling/claude/README.md)
- AIエージェント向けクイックスタート: [../AGENTS.md](../AGENTS.md)
- AIエージェント向け詳細ガイド: [process-guides/agents/README.md](process-guides/agents/README.md)
- リファレンスハブ: [reference/README.md](reference/README.md)

## ドキュメントのレイヤー（編集方針）
本リポジトリのドキュメントは、以下のレイヤーモデルに準拠して整理・編集します（Issue #16）。
- 00 Foundation: 不変原則・命名規則・記述ルール（例: Documentation Rules / SOP）
- 10 Governance: 運用ガバナンス（Issue/PR/ラベル/レビュー）
- 20 Process: 実務手順・SOP・Runbook（開発/エージェント運用）
- 30 Architecture: 全体像・図・ADR
- 40 Reference: 用語集・仕様・コードマッピング
- 50 Tooling: ツールセットアップと運用
- 60 Templates: テンプレート群

各カテゴリでは `README.md` / `AGENTS.md` / `INDEX.md` の三点セットを整備し、導線を一貫化します。

## コントリビューションのヒント
1. 新しいドキュメントを追加する場合は、まず Issue で目的と読者を明確化してください。
2. `docs/` 配下に配置し、この目次表へ項目を追加します。
3. ルート `README.md` から必要な導線を張ることを忘れずに。必要であれば `policy/framework/README.md` にも追記してください。

---

より詳細なフレームワーク運用手順は [policy/framework/README.md](policy/framework/README.md) を参照してください。
