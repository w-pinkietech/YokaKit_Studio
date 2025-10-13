# Exec Plan: docs レイヤーモデル整合（Foundation→Governance→Process→…）

## 目的 / ゴール
- `docs/README.md` に定義されたレイヤー（00 Foundation / 10 Governance / 20 Process / 30 Architecture / 40 Reference / 50 Tooling / 60 Templates）に沿って、既存ドキュメントを再配置・整理する。
- Hub（README/INDEX/AGENTS）と各サブカテゴリの導線を一貫化し、リンク切れをゼロにする。
- 完了定義（Done）：レイヤーの過不足がない状態で全主要リンクが有効、重複・旧来ファイルは削除または移設とリダイレクト注記済み。

## 範囲 / 非範囲
- 対象：`docs/` 配下の構造・文書リンクの整合、Hub/INDEX/AGENTSの更新、不要ドキュメントの整理。
- 含めない：コード実装・CI設定の変更、外部リポの更新。Issue/PRの正式運用整備は本Plan完了後に実施。
- 前提：`docs/README.md` のレイヤー定義が基準。既存の `docs/00-foundation/` と `docs/process-guides/` は軸として活かす。

## 参照 / コンテキスト
- Issue: （後で付与）
- レイヤー定義: `docs/README.md`
- 既存ハブ: `docs/INDEX.md`, `docs/process-guides/README.md`
- Foundation: `docs/00-foundation/documentation/`, `docs/00-foundation/aidlc/`
- Governance: `docs/policy/framework/`
- Process: `docs/process-guides/`（本ブランチで `exec-plan.md` を追加済み）
- Reference: `docs/reference/`
- Tooling: `docs/tooling/`, `docs/tooling/claude/`
- Templates: `docs/templates/`

## 全体像
本リポのドキュメントは増加基調にあり、レイヤー横断の重複・導線不整合が発生しやすい。`docs/README.md` のレイヤーモデルを基準に、各カテゴリの役割（原則＝Foundation、運用＝Governance、手順＝Process、参照＝Reference、ツール＝Tooling、雛形＝Templates）を明確化する。
今回の作業では、既存ファイルを棚卸しし、適切な階層へ再配置・Hubからのリンクを更新する。重複・旧ファイルは削除または統合し、必要に応じてリダイレクト注記（「移設先はこちら」）を冒頭に残す。

## 進捗状況（Checklist）
- [x] スパイク / 調査（docsツリー・ハブ確認、exec-plan追加）
- [ ] レイヤー別マッピング表の作成（現状→移設先）
- [ ] ファイル移設・不要ファイル整理（削除/統合/注記）
- [ ] Hub/INDEX/AGENTS の導線更新（相互リンク統一）
- [ ] リンクスイープ（rg）で切れを0件にする
- [ ] 最終レビュー（自己チェック）

## 実行計画（Plan）
1. 現状棚卸し（完了ファイル含む）
   - docs配下のディレクトリ・ファイル一覧を取得し、レイヤー案内（docs/README.md）と差分を洗い出す。
   - 重複or旧版候補を抽出（例：`docs/documentation-governance.md` など）。
2. レイヤー別マッピング表の作成
   - Foundation（00-foundation/...）: documentation/aidlc のルール＆SOPに統合。重複は移設・注記。
   - Governance（policy/framework/）: 方針文書以外の紛れ（古いoverview等）がないか確認。
   - Process（process-guides/）: agents/development/exec-plan の3本柱に導線統一。
   - Reference / Tooling / Templates: ハブと相互リンク確認。
3. 実施（移設・統合・削除）
   - ファイル移動時は、移動元に1～2行の移設注記を追記するか、リンク更新で完全置換（選択基準はDisposability）。
   - ハブ（docs/README.md, docs/INDEX.md, 各README/INDEX/AGENTS）からのリンクを更新。
4. 検証
   - `rg --pcre2 "\]\([^)]*\)" docs` 等でリンク先の存在を確認（スタブ不可）。
   - 主要エントリ（ルートREADME, AGENTS, docs/README.md）からの導線を手動チェック。
5. 仕上げ
   - TODO/残件のIssue化は本Plan完了後に行う（本Plan内には残件を箇条書き）。

## 決定ログ（Decision Log）
- 2025-10-14: Exec Plan の常設ドキュメントは Process 層（`docs/process-guides/exec-plan.md`）に配置し、雛形は Templates に置く方針を採用。

## 発見と驚き（Findings）
- `docs/documentation-governance.md` が残存している。Foundation配下へ統合または削除の検討が必要。
- `records` ワークフローはPR中心で整備済み。`plans.md`/`plan.md` の二重化に注意（本Planは`plan.md`）。

## リスク / 代替案
- リスク: リンク切れの混入 / 回避策: リンクスイープとハブからの手動導線確認、移設注記を暫定で残す。
- リスク: 移設の履歴追跡が難化 / 回避策: 移設コミットを分け、PR概要に移設方針と対象一覧を明記。
- 代替案: 旧構造を維持し索引のみ強化 → 採用しない（将来的なスケールで複雑性が増す）。

## To-Do
1. [ ] レイヤー別マッピング表を作成（現状→移設先）
2. [ ] 旧/重複ドキュメントの扱い方針を決定（削除/統合/注記）
3. [ ] ハブと各README/AGENTS/INDEXの導線更新
4. [ ] リンクスイープのスクリプト化（ローカル検証）
5. [ ] 仕上げレビューと残件メモ
6. [ ] records に Plan を保存（`bash scripts/records/archive_plan.sh 21 exec-plan-layering --plan-path plan.md` 実行で `records/by-pr/21-exec-plan-layering/plans.md` を生成し、summaryにリンク追記）

## 次アクション
- [ ] レイヤー別マッピング表のドラフトを plan.md に追記
- [ ] 候補ファイルの具体一覧（パス）を洗い出し
- [ ] 1回目の移設パッチを作成（Foundation / Process から）

---
メモ
- 本ファイルは作業ブランチ（短命文書）。マージ後は PR（records/by-pr）から参照可能にする。
- records の要約には本ファイル（plan.md）へのリンクを追加する（現在の要約には `plans.md` リンクがあるため後で置換）。
