# Appendix: Templates

### A1. Test Specification Template

```markdown
# Test Specification: {Component Name}

## Unit Tests

### UT-001: {Test Name}
- **Description**: ...
- **Given**: ...
- **When**: ...
- **Then**: ...
- **Assertions**:
  - ...

### UT-002: {Test Name} (Boundary)
- ...

## Integration Tests

### IT-001: {Test Name}
- **Description**: ...
- **Given**: ...
- **When**: ...
- **Then**: ...
- **Assertions**:
  - ...

## Coverage Target
- Line Coverage: 100%
- Branch Coverage: 100%
- Mutation Score: 80%+
```

### A2. Code Review Checklist

```markdown
# Code Review Checklist

## Functionality
- [ ] すべてのテストがパスしている
- [ ] カバレッジが100%

## ADR Compliance
- [ ] ADR-XXXの制約を守っている
- [ ] ADRで決定した技術を正しく使用している

## Code Quality
- [ ] SOLID原則に従っている
- [ ] 命名が明確（Domain Designと一致）
- [ ] コメントが適切（最小限）
- [ ] エラーハンドリングが適切
- [ ] セキュリティ上の問題がない

## Performance
- [ ] N+1クエリがない
- [ ] 不要なメモリ確保がない
- [ ] キャッシュが適切に使われている

## Maintainability
- [ ] 将来の拡張性が考慮されている
- [ ] 技術的負債が発生していない
```

---

これで**AI主導 × TDD × ドキュメント駆動**の開発プロセス最適化が完了です。
READMEに統合しますか？
