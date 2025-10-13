---
id: pr-21-exec-plan-layering
type: pr # 原則 pr を使用（issue/commit は例外時のみ）
status: open
relates_to:
  issues: ["#<n>"] # 任意
  prs: []            # 任意（関連PRがあれば）
  commits: []        # 任意（PRを通さないHotfix時など）
authors: ["@cycling777"]
dates:
  created: 2025-10-14
  updated: 2025-10-14
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/21
  permalinks: []
repos: []
decisions:
  - summary: "レイヤーディレクトリ（10/20/30/40/50/60）を正式採用し、docs/ を再配置する"
    impacts: ["docs/10-governance/", "docs/20-process/", "docs/30-architecture/", "docs/40-reference/", "docs/50-tooling/", "docs/60-templates/"]
  - summary: "Exec Plan 常設＝Process 層、雛形＝Templates 層"
    impacts: ["docs/20-process/exec-plan.md", "docs/60-templates/exec-plan.md"]
  - summary: "Architecture 層は `.aidlc/.../adr/` を一次情報とする（docs/ には恒久配置しない）"
    impacts: ["docs/30-architecture/README.md"]
  - summary: "旧 `docs/documentation-governance.md` を削除し Foundation に一本化"
    impacts: ["docs/00-foundation/documentation/"]
next_actions:
  - "新レイヤー構成に従って今後のPRでも文書を配置する運用を徹底"
  - "必要に応じて docs/README.md の表を追加更新（新サブドメイン追加時）"
---

## Summary
docs/ 配下をレイヤーモデル（00/10/20/30/40/50/60）に再編し、Hub/Index/Agents を含む導線を新構成へ更新。不要となった重複文書を整理し、Architecture 層は `.aidlc/.../adr/` を一次情報として参照する方針を明記した。テンプレートを除く相対リンクは全てチェックし、切れがないことを確認済み。

## Key Points
- レイヤーディレクトリ採用（10-governance, 20-process, 30-architecture, 40-reference, 50-tooling, 60-templates）
- Hub/Index/AGENTS のリンク・表記ゆれ整合（“Rules / SOP” に統一）
- Process 層に Exec Plan ガイド追加（20-process/exec-plan.md）
- Architecture 層はリンク方針のみ（恒久文書は `.aidlc/.../adr/`）
- 旧 `docs/documentation-governance.md` を削除（Foundation へ一本化済み）
- 相対リンクスイープ（60-templates 除外）で切れ 0 件

## Links
- PR: https://github.com/w-pinkietech/YokaKit_Studio/pull/21
- Plan Snapshot: plans.md

- Working Plan: ../../../plans.md
