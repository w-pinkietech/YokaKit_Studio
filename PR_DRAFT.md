# [framework] add standardized issue templates

## 概要
- `.github/ISSUE_TEMPLATE/` に `framework_task`, `feature_request`, `bug_report` の3種類のテンプレートを追加し、背景/課題/提案/影響/受け入れ基準/次のアクションを共通化。
- ブランチ運用ガイド（`docs/10-governance/framework/README.md`）とエージェント向けチェックリストを更新し、テンプレート活用と受け入れ基準の明記を反映。
- `docs/20-process/agents/README.md` にテンプレート利用ルールを追加し、AI エージェントが必ず統一フォーマットで起票するよう整備。

## 影響範囲
- `.github/ISSUE_TEMPLATE/*.md`, `.github/ISSUE_TEMPLATE/config.yml`
- `docs/10-governance/framework/README.md`
- `docs/20-process/agents/AGENTS.md`
- `docs/20-process/agents/README.md`

## 検証
```bash
# スモークテスト: テンプレート本文を用いた Issue 起票と即時クローズ
body=$(tail -n +8 .github/ISSUE_TEMPLATE/framework_task.md)
issue_url=$(gh issue create --title "[framework] Template smoke test" --body "$body" \
  --label track::framework --label artifact::process --label status::triage --label impact::low)
issue_number=${issue_url##*/}
gh issue close "$issue_number" --comment "Smoke-test for new issue templates. Verified layout; closing immediately."
```

## 参考
- Exec Plan: `records/by-pr/31-issue-templates/plans.md`
- Records summary: `records/by-pr/31-issue-templates/summary.md`
- Issue: #29
