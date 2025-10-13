# YokaKit Policy Hub

ドキュメントガバナンスで定義された「Policy」カテゴリの中核として、恒久的な運用規約や意思決定ルールを集約するディレクトリです。ラベル戦略やドキュメント統制といった変更頻度の低い規約をここに整理し、プロジェクト全体で一貫した判断ができるようにします。

## 目的
- 運用に関わるポリシー（Issue/PR/レビュー、ドキュメント統制など）を成果物種別に基づいて体系化する。
- `docs/README.md` や `docs/INDEX.md` から参照される先として、ポリシー関連情報の集約ポイントを提供する。
- `stable/` と `iterative/` などライフサイクルの切り方を適切に使い分け、改訂履歴を追いやすくする。

## ディレクトリ構成（初期セット）
| パス | 役割 | 備考 |
|------|------|------|
| `framework/` | フレームワーク運用ポリシー（Issue/PR/ラベル運用など） | 旧 `docs/framework-governance.md` を移管。 |

> 追加のポリシー領域が生じた場合は、本 README に追記し、`README/AGENTS/INDEX` の三点セットを整備してください。

## 関連資料
- [ドキュメント ルール集（Foundation）](../00-foundation/documentation/rules.md)
- [ドキュメント標準手順書（Foundation）](../00-foundation/documentation/standard-procedures.md)
- [docs/README.md](../README.md)
- [docs/INDEX.md](../INDEX.md)
