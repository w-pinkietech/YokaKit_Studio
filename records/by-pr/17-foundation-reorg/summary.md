---
id: pr-17-foundation-reorg
type: pr
status: merged
relates_to:
  issues: ["#16"]
  prs: ["#17"]
  commits: []
authors: []
dates:
  created: 2025-10-13
  updated: 2025-10-13
links:
  thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/17
  permalinks: []
decisions:
  - summary: "Introduce 00-foundation and move documentation/AIDLC Rules & SOP under it; update docs hubs and links"
    impacts: ["docs/00-foundation/*", "docs/INDEX.md", "docs/README.md"]
next_actions:
  - "Follow up on AIDLC details (glossary/samples) after baseline stabilizes"
---

## Summary
ドキュメントの土台レイヤ（00-foundation）を導入し、Documentation Rules/SOP と AIDLC Rules/SOP を配備。docs ハブと索引、関連ディレクトリ（process-guides/reference/tooling）からの導線を更新した。以後のルール変更は foundation 配下を権威とし、プロセス側は軽タッチで導線補強する方針。

## Key Points
- policy/documentation から 00-foundation/documentation へ移設
- 00-foundation/aidlc を追加し、Rules/SOP の骨子を整備
- docs/README.md, docs/INDEX.md を新構成に合わせて更新

## Links
- PR #17 thread: https://github.com/w-pinkietech/YokaKit_Studio/pull/17
- Related Issue #16: https://github.com/w-pinkietech/YokaKit_Studio/issues/16

