# Exec Plan: <タイトル>

## 目的 / ゴール
- 何を達成するか、完了の定義（Done）を1〜3行で明記。

## 範囲 / 非範囲
- 対象、含めないもの、既知の前提・制約。

## 参照 / コンテキスト
- Issue: #<n>
- ADR / 設計: `.aidlc/contexts/<id>/construction/logical-design/adr/...`
- 関連Docs: `docs/...`

## 全体像
- 取り組む機能の目的/背景と期待する振る舞い（1〜3段落）。

## 進捗状況（Checklist）
- [ ] スパイク / 調査
- [ ] 実装（コア）
- [ ] テスト追加 / 検証
- [ ] ドキュメント更新 / リンク確認

## 実行計画（Plan）
1. ...
2. ...
3. ...

## 決定ログ（Decision Log）
- YYYY-MM-DD: どのアプローチを採用/却下したか、理由。

## 発見と驚き（Findings）
- 調査や実装で判明した事実/想定外の挙動/依存の課題。

## リスク / 代替案
- リスク: ... / 回避策: ...
- 代替案: ...（採用しない理由）

## To-Do
1. [ ] ...
2. [ ] ...
3. [ ] ...
4. [ ] records に plans.md を保存（`bash scripts/records/archive_plan.sh <pr-number> <slug>` を実行し、`records/by-pr/<pr>-<slug>/plans.md` と `summary.md` のリンクを確認）

## 次アクション
- [ ] ...

---
メモ
- 本ファイルは作業ブランチ（短命文書）。マージ後は PR（records/by-pr）から参照可能にする。
- records の要約には本ファイル（plans.md）へのリンクを追加する。
