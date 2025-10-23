---
id: pr-22-status-label-flow
type: pr # 原則 pr を使用（issue/commit は例外時のみ）
status: open
relates_to:
  issues: []
  prs: []
  commits: []        # 任意（PRを通さないHotfix時など）
authors: ["@codex-agent"]
dates:
  created: 2025-01-13
  updated: 2025-01-13
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/22
  permalinks:
    - studio/10-governance/framework/README.md
    - studio/20-process/agents/README.md
    - studio/00-foundation/documentation/standard-procedures.md
    - studio/20-process/exec-plan.md
    - studio/20-process/agents/AGENTS.md
    - studio/60-templates/exec-plan.md
    - AGENTS.md
    - scripts/setup_labels.sh
    - scripts/exec_plan/bootstrap.sh
repos: []
decisions:
  - summary: "`status::` ラベルを triage→ready→in-progress→in-review→done（+ blocked）に再編し、対応する運用ルールとスクリプトを更新する。"
    impacts: [studio/10-governance/framework/README.md, studio/20-process/agents/README.md, studio/20-process/exec-plan.md, studio/20-process/agents/AGENTS.md, studio/00-foundation/documentation/standard-procedures.md, studio/60-templates/exec-plan.md, AGENTS.md, scripts/setup_labels.sh, scripts/exec_plan/bootstrap.sh]
next_actions: []
---

## Summary
現行の `status::` ラベルが `needs-decision` / `blocked` / `ready` の3種のみで担当状況が不透明だったため、準備から完了までを追跡できる最小限の5段階（`triage`→`ready`→`in-progress`→`in-review`→`done`）へ再編した。  
フレームワークガバナンス文書、エージェントガイド、ドキュメントSOPを新ラベルに合わせて更新し、自動同期スクリプトの定義も刷新してDry-runで挙動を確認した。  
Exec Plan と Draft PR 素案を records 配下に保存し、実際の Draft PR #22 作成とラベル同期・Issue ラベルの更新まで完了した。  
さらに、Exec Plan 着手時に Issue を自動検出/生成できる `scripts/exec_plan/bootstrap.sh` を追加し、テンプレート/ガイドへ導線を整備した。

## Key Points
- `status::` ラベルを 5 段階 + `blocked` へ簡素化し、重複担当を防ぐ運用を定義。
- `studio/10-governance/framework/README.md` ほか関連ドキュメントを同一コミットで更新し、Exec Plan 手順やテンプレートにも導線を追加。
- `scripts/setup_labels.sh` を更新し Dry-run / 本番同期を実行。
- `scripts/exec_plan/bootstrap.sh` を新設し、Issue 検出と自動作成フローをドキュメント化。
- Issue #1 のステータスラベルを `status::triage` へ入れ替え、旧 `status::needs-decision` ラベルを削除。
- `plans.md` と `PR_DRAFT.md` を基に Draft PR を作成し、records テンプレートを整備。

## Links
- Plan Snapshot: records/by-pr/22-status-label-flow/plans.md
- Draft PR: PR_DRAFT.md
