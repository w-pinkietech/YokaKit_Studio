# YokaKit Studio Documentation Hub

人間がプロジェクトの背景・運用ポリシーを把握しやすくするためのエントリーポイントです。ドキュメントは役割ごとに整理され、AIエージェント向け資料とは分離しています。

## このディレクトリの目的
- ドキュメントの配置先を統一し、参照導線を明確化する。
- フレームワーク整備期に増加するガイド類を集約し、ルートディレクトリの煩雑化を防ぐ。
- 人間読者に必要な情報（プロセス、ガバナンス、セットアップなど）を1カ所で辿れるようにする。

## コンテンツ概要
| ファイル | 対象読者 | 概要 |
|-----------|-----------|------|
| `README.md` | 人間 | このファイル。全体像と主要ドキュメントへの案内を提供。 |
| `AGENTS.md` | AIエージェント | 詳細ガイド。索引付きで稼働ルールや参照パスを整理。 |
| `framework-governance.md` | 人間 | フレームワーク整備期のガバナンス、ラベル運用、PRフロー。 |
| `development-process.md` | 人間/AI | AI-DLCにおけるTDD/ドキュメント駆動プロセス詳細。 |

## 参照ナビゲーション
- プロジェクト概要・アーキテクチャ: ルート `README.md`
- フレームワークガバナンス: [framework-governance.md](framework-governance.md)
- 開発プロセス詳細: [development-process.md](development-process.md)
- AIエージェント向けクイックスタート: [../AGENTS.md](../AGENTS.md)
- AIエージェント向け詳細ガイド: [AGENTS.md](AGENTS.md)

## コントリビューションのヒント
1. 新しいドキュメントを追加する場合は、まず Issue で目的と読者を明確化してください。
2. `docs/` 配下に配置し、この目次表へ項目を追加します。
3. ルート `README.md` から必要な導線を張ることを忘れずに。必要であれば `framework-governance.md` にも追記してください。

---

より詳細なフレームワーク運用手順は [framework-governance.md](framework-governance.md) を参照してください。
