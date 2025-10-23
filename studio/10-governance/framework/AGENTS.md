# Framework Policy Guide

## 目的
- Issue/PR/ラベル運用など、フレームワーク整備期のポリシーを即座に参照する。
- 変更時に必要なチェック（ラベル同期、レビュー手順など）を漏れなく実行する。

## 索引
- [必読ドキュメント](#必読ドキュメント)
- [主要チェックリスト](#主要チェックリスト)
- [関連スクリプト](#関連スクリプト)

## 必読ドキュメント
- [README.md](README.md) — ラベル体系、Issue/PR フロー、サブモジュール運用などの詳細
- [../README.md](../README.md) — Policy カテゴリ全体の概要
- [../../README.md](../../README.md) — `studio/` ルートのハブ

## 主要チェックリスト
- [ ] Issue は `track::`, `artifact::`, `status::`, `impact::` ラベルが設定されているか。
- [ ] `framework/<issue-number>-<slug>` ブランチ命名を守っているか。
- [ ] PR タイトル先頭に `[framework]` を付与し、`Closes #<issue>` を記載したか。
- [ ] `scripts/setup_labels.sh --dry-run` を実行し、差分を確認したか。
- [ ] サブモジュール更新時は `scripts/verify_submodules.sh` の結果を共有したか。

## 関連スクリプト
- `scripts/setup_labels.sh` — ラベル同期ユーティリティ
- `scripts/verify_submodules.sh` — サブモジュール検証スクリプト
