# YokaKit Studio Documentation Hub

人間がプロジェクトの背景・運用ポリシーを把握しやすくするためのエントリーポイントです。ドキュメントは役割ごとに整理され、AIエージェント向け資料とは分離しています。

## このディレクトリの目的
- ドキュメントの配置先を統一し、参照導線を明確化する。
- フレームワーク整備期に増加するガイド類を集約し、ルートディレクトリの煩雑化を防ぐ。
- 人間読者に必要な情報（プロセス、ガバナンス、セットアップなど）を1カ所で辿れるようにする。

## コンテンツ概要
成果物種別を基軸とし、必要に応じてライフサイクル（`stable/`, `iterative/`, `archive/` など）で階層化する新ディレクトリ体系へ段階的に移行中です。移行完了までの暫定配置は下表を参照してください。

| パス | 成果物種別 | 主な読者（参考情報） | 概要 / 今後の配置 |
|------|------------|----------------------|-------------------|
| `README.md` | Reference | 人間 | このファイル。全体像と主要ドキュメントへの案内。 |
| `AGENTS.md` | Process Guide | AI | 索引付きで稼働ルールや参照パスを整理。最終的には `process-guides/agents/AGENTS.md` へ移行予定。 |
| `INDEX.md` | Reference | 人間/AI 共通 | `docs/` 全体の目次。主要カテゴリへの導線。 |
| `documentation-governance/` | Policy | 人間/AI 共通 | ドキュメント運用ルールとスタイルガイド。移行後は `policy/documentation/` 配下となる。 |
| `framework-governance.md` | Policy | 人間 | ラベル運用や PR フロー。順次 `policy/framework/` に再配置する。 |
| `development-process.md` | Process Guide | 人間/AI 共通 | AI-DLC における TDD/ドキュメント駆動プロセス詳細。`process-guides/development/` へ移行予定。 |
| `claude-code.md` | Tooling | 人間/AI 共通 | Claude Code のセットアップとスラッシュコマンド運用ガイド。`tooling/claude/` に再編予定。 |
| `templates/` | Template | 人間/AI 共通 | README / AGENTS / INDEX などドキュメント用テンプレート。 |

> ライフサイクルの切り方（`stable/`, `iterative/`, `archive/` 等）や具体的なディレクトリ設計ルールは [documentation-governance/directory-structure.md](documentation-governance/directory-structure.md#ライフサイクルレイヤ運用例) を参照。

## 参照ナビゲーション
- プロジェクト概要・アーキテクチャ: ルート `README.md`（将来は `docs/reference/overview/`）
- フレームワークポリシー（Issue/PR/Lifecycle）: [framework-governance.md](framework-governance.md) → 今後 `policy/framework/README.md`
- ドキュメントポリシー・スタイルガイド: [documentation-governance/INDEX.md](documentation-governance/INDEX.md) → 今後 `policy/documentation/INDEX.md`
- AI-DLC 開発プロセス詳細: [development-process.md](development-process.md) → 今後 `process-guides/development/README.md`
- AIエージェント向けクイックスタート: [../AGENTS.md](../AGENTS.md)
- AIエージェント向け詳細ガイド: [AGENTS.md](AGENTS.md) → 今後 `process-guides/agents/AGENTS.md`
- ツールセットアップ（Claude 等）: [claude-code.md](claude-code.md) → 今後 `tooling/claude/README.md`
- テンプレート類: [templates/](templates/)
- ※ `AGENTS.md` は AI への行動指示、`INDEX.md` はディレクトリ全体の索引として機能する。
- ライフサイクル階層の運用: [documentation-governance/directory-structure.md](documentation-governance/directory-structure.md#ライフサイクルレイヤ運用例)

## コントリビューションのヒント
1. 新しいドキュメントを追加する場合は、まず Issue で目的と読者を明確化してください。
2. `docs/<成果物種別>/` 配下に配置し、この目次表へ項目を追加します（移行期間中は暫定パスも併記してください）。
3. ルート `README.md` から必要な導線を張ることを忘れずに。必要であれば `framework-governance.md` にも追記してください。

---

より詳細なフレームワーク運用手順は [framework-governance.md](framework-governance.md) を参照してください。
