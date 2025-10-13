# Documentation Index

`docs/` ディレクトリ全体の構成と主要ドキュメントへの導線をまとめる。

> 編集方針: ドキュメントはレイヤーモデル（Foundation→Governance→Process→…）で整理します。詳細は `docs/README.md` の「ドキュメントのレイヤー（編集方針）」を参照してください（Issue #16）。

## ハイレベルカテゴリ
- [policy/](policy/README.md) — ポリシー集約（フレームワーク運用・ドキュメント統制など）。
- [00-foundation/](00-foundation/README.md) — レイヤー00: 不変原則・SOP（documentation など）。
- [policy/framework/](policy/framework/README.md) — Issue / PR ガバナンス、ラベル運用。
- [00-foundation/documentation/](00-foundation/documentation/README.md) — ドキュメントルールと標準手順。
- [00-foundation/aidlc/](00-foundation/aidlc/README.md) — AIDLC のルールと標準手順。
- [process-guides/](process-guides/README.md) — 開発プロセスやエージェント運用ガイド。
- [process-guides/development/](process-guides/development/README.md) — AI-DLC の開発プロセス詳細。
- [process-guides/agents/](process-guides/agents/README.md) — エージェント向け運用ガイド。
- [tooling/](tooling/README.md) — ツールセットアップと運用ガイド。
- [tooling/claude/](tooling/claude/README.md) — Claude セットアップとスラッシュコマンド運用。
- [reference/](reference/README.md) — 恒久的リファレンス資料のハブ。
- [templates/](templates/) — README / AGENTS / INDEX ドキュメントのテンプレート集。

## 各ディレクトリのインデックス
- 人間向けインデックス: [README.md](README.md)
- AI 向けインデックス: [AGENTS.md](AGENTS.md)
- ドキュメントルール・SOP索引: [00-foundation/documentation/INDEX.md](00-foundation/documentation/INDEX.md)
- ※ `AGENTS.md` は AI に対する実務指示、`INDEX.md` はディレクトリ全体の索引として利用する。

## 更新メモ
- 新しいドキュメントやディレクトリを追加したら、この index と `README.md` / `AGENTS.md` を同時に更新する。
- リンク切れがないかを `rg` やプレビューで確認し、必要に応じて Issue に記録する。
- 参照先を削除・移動した場合は、関連する README / AGENTS / INDEX から古いリンクを除去する。
