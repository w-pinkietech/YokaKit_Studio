# Documentation Index

`studio/` ディレクトリ全体の構成と主要ドキュメントへの導線をまとめる。

> 編集方針: ドキュメントはレイヤーモデル（Foundation→Governance→Process→…）で整理します。詳細は `studio/README.md` の「ドキュメントのレイヤー（編集方針）」を参照してください（Issue #16）。

## ハイレベルカテゴリ
- [10-governance/](10-governance/README.md) — ポリシー集約（フレームワーク運用）。
- [10-governance/framework/](10-governance/framework/README.md) — Issue / PR ガバナンス、ラベル運用。
- [00-foundation/](00-foundation/README.md) — レイヤー00: 不変原則・SOP（documentation など）。
- [00-foundation/documentation/](00-foundation/documentation/README.md) — ドキュメントルールと標準手順。
- [00-foundation/aidlc/](00-foundation/aidlc/README.md) — AIDLC のルールと標準手順。
- [20-process/](20-process/README.md) — 開発プロセスやエージェント運用ガイド。
- [20-process/development/](20-process/development/README.md) — AI-DLC の開発プロセス詳細。
- [20-process/agents/](20-process/agents/README.md) — エージェント向け運用ガイド。
- [20-process/exec-plan.md](20-process/exec-plan.md) — Exec Plan の手順と records 連携。
- [50-tooling/](50-tooling/README.md) — ツールセットアップと運用ガイド。
- [50-tooling/claude/](50-tooling/claude/README.md) — Claude セットアップとスラッシュコマンド運用。
- [40-reference/](40-reference/README.md) — 恒久的リファレンス資料のハブ。
- [60-templates/](60-templates/) — README / AGENTS / INDEX ドキュメントのテンプレート集。

## 補足（Architecture 層の所在）
- ADRやアーキテクチャの詳細は `.aidlc/contexts/<id>/construction/logical-design/adr/` を参照（本 `studio/` 配下には恒久配置しない方針）。

## 各ディレクトリのインデックス
- 人間向けインデックス: [README.md](README.md)
- AI 向けインデックス: [AGENTS.md](AGENTS.md)
- ドキュメントルール・SOP索引: [00-foundation/documentation/INDEX.md](00-foundation/documentation/INDEX.md)
- ※ `AGENTS.md` は AI に対する実務指示、`INDEX.md` はディレクトリ全体の索引として利用する。

## 更新メモ
- 新しいドキュメントやディレクトリを追加したら、この index と `README.md` / `AGENTS.md` を同時に更新する。
- リンク切れがないかを `rg` やプレビューで確認し、必要に応じて Issue に記録する。
- 参照先を削除・移動した場合は、関連する README / AGENTS / INDEX から古いリンクを除去する。
