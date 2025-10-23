# Step 2: Logical Design（論理設計・ADR）

### 2.1 Architecture Decision

**AI Prompt Template**:
```
Context: {Domain Design, NFRs}

Task: 以下のNFRsを満たすアーキテクチャを提案し、ADRを作成してください。

NFRs:
- マルチデバイス対応
- セッション共有
- 99.9% Availability

Domain Components:
- Account Entity
- SwitchAccountService

Output Format (ADR Template):
# ADR-001: {決定事項}

## Status
Proposed / Accepted / Deprecated

## Context
<!-- 背景・課題 -->

## Decision
<!-- 採用する技術・パターン -->

## Consequences
### Pros
- ...

### Cons
- ...

## Alternatives Considered
### Option 1: {不採用案}
- Pros: ...
- Cons: ...
- なぜ不採用: ...

### Option 2: ...

## Implementation Notes
<!-- 実装時の注意点 -->

## Related
- Domain Design: static-model.md
- NFRs: ../../../inception/nfrs.md
```

**Human Verification Checklist**:
```markdown
- [ ] 決定事項が明確か
- [ ] トレードオフが網羅されているか
- [ ] 不採用理由が説得力があるか
- [ ] 実装可能性が考慮されているか
- [ ] NFRsを満たしているか
- [ ] コスト・運用負荷が妥当か
```

**Output**: `.aidlc/contexts/001-*/construction/logical-design/adr/001-*.md`

---

### 2.2 Commit: ADR

```bash
git checkout -b construction/001-multi-account/logical-design
git add .aidlc/contexts/001-*/construction/logical-design/adr/001-*.md
git commit -m "feat(adr): ADR-001 Redis-based session management

Decision: Redis Cluster for session storage
Alternatives: JWT (rejected), Database session (rejected)

Pros:
- Multi-device support
- Fast read/write
- Horizontal scalability

Cons:
- Additional infrastructure
- Network latency

Reviewed-by: @architect @tech-lead"

git push origin construction/001-multi-account/logical-design
```

**GitHub PR**:
- Title: `[ADR-001] Redis-based session management`
- Labels: `artifact::logical-design`, `phase::construction`, `context::001`
- Reviewers: Architect + Tech Lead（必須）

---
