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
| `INDEX.md` | 人間/AI | `studio/` 全体の目次（索引）。 |
| `10-governance/` | 人間/AI | ガバナンス系カテゴリのハブ（framework）。 |
| `00-foundation/documentation/` | 人間/AI | ドキュメントルールと標準手順（Foundation層）。 |
| `00-foundation/aidlc/` | 人間/AI | AIDLC のルールと標準手順（Foundation層）。 |
| `10-governance/framework/` | 人間/AI | 運用ガバナンス（Issue/PR/ラベル運用、レビュー方針）。 |
| `20-process/` | 人間/AI | 実務手順・SOP のカテゴリ（development / agents）。 |
| `20-process/exec-plan.md` | 人間/AI | Exec Plan 手順と records 連携（Process層）。 |
| `20-process/development/README.md` | 人間/AI | AI-DLC の開発プロセス（TDD/ドキュメント駆動）概要。 |
| `20-process/agents/README.md` | AIエージェント | エージェント運用の詳細ガイド。 |
| `40-reference/` | 人間/AI | 用語集・仕様・コードマッピングなど参照情報。 |
| `40-reference/repos/` | 人間/AI | リポジトリカタログ（横断作業向け）。 |
| `50-tooling/` | 人間/AI | ツールセットアップと運用ガイド（例: Claude）。 |
| `50-tooling/claude/README.md` | 人間/AI | Claude セットアップとスラッシュコマンド運用。 |
| `60-templates/` | 人間/AI | README / AGENTS / INDEX 等のテンプレート集。 |

## 参照ナビゲーション
- プロジェクト概要・アーキテクチャ: ルート `README.md`
- ドキュメントルール・標準手順: [00-foundation/documentation/INDEX.md](00-foundation/documentation/INDEX.md)
- AIDLC ルール・標準手順: [00-foundation/aidlc/INDEX.md](00-foundation/aidlc/INDEX.md)
- フレームワークガバナンス: [10-governance/framework/README.md](10-governance/framework/README.md)
- 開発プロセス詳細: [20-process/development/README.md](20-process/development/README.md)
- Exec Plan 手順: [20-process/exec-plan.md](20-process/exec-plan.md)
- ツールセットアップ: [50-tooling/README.md](50-tooling/README.md)
- Claude 運用手順: [50-tooling/claude/README.md](50-tooling/claude/README.md)
- AIエージェント向けクイックスタート: [../AGENTS.md](../AGENTS.md)
- AIエージェント向け詳細ガイド: [20-process/agents/README.md](20-process/agents/README.md)
- リファレンスハブ: [40-reference/README.md](40-reference/README.md)
 - リポジトリカタログ: [40-reference/repos/README.md](40-reference/repos/README.md)
 - アーキテクチャ/ADR: `.aidlc/contexts/<id>/construction/logical-design/adr/`（本docsには恒久配置しない）

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
2. `studio/` 配下に配置し、この目次表へ項目を追加します。
3. ルート `README.md` から必要な導線を張ることを忘れずに。必要であれば `10-governance/framework/README.md` にも追記してください。

---

より詳細なフレームワーク運用手順は [10-governance/framework/README.md](10-governance/framework/README.md) を参照してください。
