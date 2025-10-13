# Policy Index

ポリシー関連ドキュメントの索引用リストです。成果物種別とライフサイクルの観点で整理し、必要な規約へ素早くアクセスできるようにします。

## カテゴリ別
- **Framework**: `framework/`
  - `framework/README.md` — Issue/PR/ラベル運用のガイドライン
  - `framework/AGENTS.md` — AIエージェント向けチェックリスト
  - `framework/INDEX.md` — フレームワーク関連ポリシーの索引

## ライフサイクルレイヤ
- `stable/`: 現行の必須ポリシー（初期セットは `framework/` が対象）
- `iterative/`: ボルト単位で検証・更新が必要な補足（必要になり次第追加）
- `archive/`: 廃止済みポリシーの保管場所（追加時は README からリンクを外す）

## 更新時チェック
- [ ] 該当ポリシー領域の README/AGENTS/INDEX を更新したか。
- [ ] `docs/README.md` と `docs/INDEX.md` に新しい導線を追加したか。
- [ ] ルート `README.md` や Issue テンプレートの記述と矛盾しないか。
- [ ] ライフサイクル区分（stable/iterative/archive）が最新状況を反映しているか。
