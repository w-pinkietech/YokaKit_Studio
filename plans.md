# Exec Plan: docs レイヤーモデル整合（第二版：レイヤーディレクトリ採用）

## 目的 / ゴール
- レイヤーディレクトリ（`10-governance/`, `20-process/`, `30-architecture/`, `40-reference/`, `50-tooling/`, `60-templates/`）を導入し、全ドキュメントを再配置する。
- Hub（README/INDEX/AGENTS）と相互リンクを新構成に合わせて更新、リンク切れを 0 にする。
- 完了定義（Done）：新レイヤーディレクトリ配下に整理済み、主要導線更新済み、リンクスイープで0件。

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

## レイヤー定義（固定）
- 00 Foundation: 不変原則・命名規則・記述ルール（例: Documentation Rules / SOP）
- 10 Governance: 運用ガバナンス（Issue/PR/ラベル/レビュー）
- 20 Process: 実務手順・SOP・Runbook（開発/エージェント運用）
- 30 Architecture: 全体像・図・ADR
- 40 Reference: 用語集・仕様・コードマッピング
- 50 Tooling: ツールセットアップと運用
- 60 Templates: テンプレート群

## レイヤー別マッピング（現状→配置）
- 00 Foundation
  - `docs/00-foundation/documentation/` → OK（Documentation Rules / SOP）
  - `docs/00-foundation/aidlc/` → OK（AIDLC Rules / SOP）
- 10 Governance
  - `docs/policy/framework/` → OK（Issue/PR/ラベル/レビュー）
- 20 Process
  - `docs/process-guides/development/` → OK（AI-DLC手順）
  - `docs/process-guides/agents/` → OK（Agents運用）
  - `docs/process-guides/exec-plan.md` → OK（Exec Plan 手順）
- 30 Architecture
  - 該当ディレクトリ未設置（ADR等は `.aidlc/contexts/...` に存在）→ 本リポdocsでは対象外のまま据え置き（必要なら案内だけ追加）
- 40 Reference
  - `docs/reference/`, `docs/reference/repos/` → OK（任意のカタログ含む）
- 50 Tooling
  - `docs/tooling/`, `docs/tooling/claude/` → OK
- 60 Templates
  - `docs/templates/` → OK

■ 要整理候補（ドラフト）
- `docs/documentation-governance.md` → Foundation側のdocumentationに統合 or 廃止（移設注記）

## 全体像
本リポのドキュメントは増加基調にあり、レイヤー横断の重複・導線不整合が発生しやすい。`docs/README.md` のレイヤーモデルを基準に、各カテゴリの役割（原則＝Foundation、運用＝Governance、手順＝Process、参照＝Reference、ツール＝Tooling、雛形＝Templates）を明確化する。
今回の作業では、既存ファイルを棚卸しし、適切な階層へ再配置・Hubからのリンクを更新する。重複・旧ファイルは削除または統合し、必要に応じてリダイレクト注記（「移設先はこちら」）を冒頭に残す。

## 進捗状況（Checklist）
- [x] スパイク / 調査（docsツリー・ハブ確認、exec-plan追加）
- [x] レイヤー別マッピング表の作成（現状→移設先）
- [x] レイヤーディレクトリへの再配置（git mv）
- [x] Hub/INDEX/AGENTS の導線更新（新パスへ）
- [x] リンクスイープ（テンプレ除外）で切れを0件にする
- [x] 表現ゆれの軽量統一（Rules / SOP 等）
- [x] 最終レビュー（自己チェック）

## 実行計画（Plan）
1. ディレクトリ再配置（完了）
2. ハブ/索引の更新（完了）
3. 相対リンクの一括書換とスイープ（完了・テンプレ除外）
4. 最終レビュー（語句ゆれ/索引の重複/案内の明確化）
5. Plan のスナップショット保存（records/by-pr）

## 決定ログ（Decision Log）
- 2025-10-14: Exec Plan の常設ドキュメントは Process 層（`docs/process-guides/exec-plan.md`）に配置し、雛形は Templates に置く方針を採用。
- 2025-10-14: `docs/documentation-governance.md` は重複のため削除。Foundation 配下の documentation に一本化。
- 2025-10-14: レイヤーディレクトリ（10/20/30/40/50/60）採用で docs 配下の再配置を完了（リンク切れ 0 件確認）。

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
