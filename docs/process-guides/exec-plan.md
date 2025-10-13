# Exec Plan ガイド（Process レイヤー）

Exec Plan は、複雑な作業を「計画→実装→検証→記録」で進めるための軽量な運用フレームです。本ガイドはレイヤーモデルに基づく配置・役割を明確化し、テンプレート/スクリプト/records との連携を一箇所に集約します。

## レイヤー対応
- Process（本書）: 手順・ワークフロー・実施基準
- Templates: `docs/templates/exec-plan.md`（雛形）
- Foundation: `docs/00-foundation/documentation/`（記述ルール/SOPの原則）
- Records: `records/by-pr/<pr>-<slug>/`（PR単位の履歴保存先）

## いつ使うか（適用基準）
- ステップが複数に分かれ、1時間以上の作業が見込まれる場合
- 複数リポジトリ（Cross-Repo）やレビュー論点が多い場合
- 設計判断（採用/却下）を記録して後方参照したい場合

## 手順（標準フロー）
1) 雛形の設置（作業ブランチ直下）
```
cp docs/templates/exec-plan.md plans.md
```
2) Draft PR を作成し、records の PR 要約を生成
```
bash scripts/records/new_pr_summary.sh <pr> <slug> --issue <n> \
  --repo-url https://github.com/<org>/<repo> --author @<you>
```
3) 実装しながら `plans.md` を随時更新（進捗/決定ログ/リスク）
4) マージ前に `plans.md` をスナップショットとして保存
```
bash scripts/records/archive_plan.sh <pr> <slug>
```
→ `records/by-pr/<pr>-<slug>/plans.md` が作成され、`summary.md` にリンクが追記されます。

## plans.md の構成（必須要素）
- 目的/ゴール（Doneの定義）
- 範囲/非範囲・前提
- 参照（Issue, ADR, 関連Docs）
- 全体像（背景/期待する振る舞い）
- 進捗チェックリスト（Spike/実装/テスト/Docs）
- 実行計画（Planの段階的タスク）
- 決定ログ（採用/却下と理由）
- 発見と驚き（Findings）
- リスク/代替案
- To-Do と 次アクション

雛形は `docs/templates/exec-plan.md` を使用してください。

## Cross-Repo の注意点
- PR要約（records）に対象リポジトリ/ブランチ/依存順序を列挙
- マージ順序やゲート（CI/レビュー承認）を `plans.md` に明記
- 変更対象が多い場合は親Issueで「パッケージ」を定義し、子PRを紐付け

## 役割分担（レイヤー再確認）
- ルール/原則は Foundation に集約（普遍的な書き方/命名/SOP原則）
- 実務の運び方は Process（本書）に集約
- 雛形そのものは Templates に配置
- 実行結果の保存・紐付けは Records（by-pr）で管理

## よくある質問
- Q: `plans.md` はどこに置く？
  - A: 作業ブランチ直下（短命文書）。マージ後は records/by-pr から参照。
- Q: 既存PRにもテンプレは適用できる？
  - A: 可能。`plans.md` を追加して以降の進捗を記録し、マージ前にスナップショットします。

