# Documentation Index

`docs/` ディレクトリ全体の構成と主要ドキュメントへの導線をまとめる。

## ハイレベルカテゴリ（成果物種別ベース）
- `policy/` — Framework / Documentation など規約系ドキュメント。現状は [framework-governance.md](framework-governance.md) と [documentation-governance/](documentation-governance/README.md) を順次移行中。
- `process-guides/` — AI-DLC 手順、エージェント運用、リリース運用などのガイドライン。[development-process.md](development-process.md) や [AGENTS.md](AGENTS.md) を再配置予定。
- `reference/` — プロジェクト概要、用語集、コードマッピングなど参照資料（今後作成）。
- `tooling/` — Claude や GitHub CLI 等のセットアップ・運用マニュアル。現状は [claude-code.md](claude-code.md) が該当。
- `templates/` — README / AGENTS / INDEX ドキュメントのテンプレート集。既存通り。

## 各ディレクトリのインデックス
- 人間向けインデックス: [README.md](README.md)
- AI 向けインデックス: [AGENTS.md](AGENTS.md) → 移行後は `process-guides/agents/AGENTS.md`
- ドキュメントスタイル索引: [documentation-governance/INDEX.md](documentation-governance/INDEX.md) → 移行後は `policy/documentation/INDEX.md`
- ライフサイクルレイヤ運用: [documentation-governance/directory-structure.md](documentation-governance/directory-structure.md#ライフサイクルレイヤ運用例)
- ※ `AGENTS.md` は AI に対する実務指示、`INDEX.md` はディレクトリ全体の索引として利用する。

## 更新メモ
- 新しいドキュメントやディレクトリを追加したら、この index と `README.md` / `AGENTS.md` を同時に更新する。
- リンク切れがないかを `rg` やプレビューで確認し、必要に応じて Issue に記録する。
- 参照先を削除・移動した場合は、関連する README / AGENTS / INDEX から古いリンクを除去する。
