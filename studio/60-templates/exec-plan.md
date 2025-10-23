# Exec Plan: <タイトル>

> 使い方（雛形：Deferred GitHub Ops 推奨）
> - このファイルをブランチ直下 `plans.md` にコピーして編集します。
> - プラン初稿に合意したら、Issue/PR（Draft）を作成し `scripts/records/new_pr_summary.sh` で要約を生成、マージ前に `scripts/records/archive_plan.sh` でスナップショットを保存します。
>
> 推奨コマンド例:
> ```bash
> set -euo pipefail
> ISSUE=<n>; SLUG=<slug>; PR=<pr>; REPO=https://github.com/<org>/<repo>; AUTHOR=@you
> scripts/exec_plan/bootstrap.sh --slug ${SLUG} --filter-label track::framework \
>   --title "[framework] <title>" --labels "track::framework,artifact::<type>,status::triage,lifecycle::draft" \
>   --repo ${REPO}
> cp studio/60-templates/exec-plan.md plans.md
> bash scripts/records/new_pr_summary.sh ${PR} ${SLUG} --issue ${ISSUE} --repo-url ${REPO} --author ${AUTHOR}
> # 作業…
> bash scripts/records/archive_plan.sh ${PR} ${SLUG}
> rm plans.md
> ```

## 目的 / ゴール
- 何を達成するか、完了の定義（Done）を1〜3行で明記。

## 範囲 / 非範囲
- 対象、含めないもの、既知の前提・制約。

## 参照 / コンテキスト
- Issue: #<n>（`scripts/exec_plan/bootstrap.sh --slug <slug> ...` の結果を記載）
- ADR / 設計: `.aidlc/contexts/<id>/construction/logical-design/adr/...`
- 関連Docs: `studio/...`
 - PR: https://github.com/<org>/<repo>/pull/<pr>
 - Records: `records/by-pr/<pr>-<slug>/summary.md`

## 全体像
- 取り組む機能の目的/背景と期待する振る舞い（1〜3段落）。

## 進捗状況（Checklist）
- [ ] スパイク / 調査
- [ ] 実装（コア）
- [ ] テスト追加 / 検証
- [ ] ドキュメント更新 / リンク確認
- [ ] Plan スナップショット保存（`archive_plan.sh` 実行）

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
5. [ ] records/by-pr/<pr>-<slug>/summary.md に作業内容を記述（Summary / Key Points / Decisions / Links を反映）
6. [ ] records への保存後、ブランチ上の `plans.md` を削除（PR 差分から除外）

## Cross-Repository（必要時）
| Repo | Branch | Order | Notes |
|------|--------|-------|-------|
| <name> | <framework/<issue>-<slug>> | <1/2/…> | 依存やゲートのメモ |

## 次アクション
- [ ] ...

---
メモ
- 本ファイルは作業ブランチ（短命文書）。`archive_plan.sh` で保存した後はブランチから削除し、PR（records/by-pr）から参照可能にする。
- records の要約には本ファイル（plans.md）へのリンクを追加する。
