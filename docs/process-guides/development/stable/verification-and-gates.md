# Verification & Quality Gates

### Gate 1: Domain Design Review

```yaml
Reviewers: Architect
Approval Required: 1
Checks:
  - Markdown lint
  - Mermaid diagram validation
  - Domain terminology consistency
```

### Gate 2: ADR Review

```yaml
Reviewers: Architect + Tech Lead
Approval Required: 2
Checks:
  - ADR format validation
  - Alternatives documented
  - Consequences documented
```

### Gate 3: Test Review

```yaml
Reviewers: Developer (2+)
Approval Required: 2
Checks:
  - Test specification coverage
  - Test code quality
  - Given-When-Then clarity
```

### Gate 4: Implementation Review

```yaml
Reviewers: Developer (2+)
Approval Required: 2
CI/CD Checks:
  - ✅ All tests pass
  - ✅ Coverage >= 100%
  - ✅ Lint pass
  - ✅ Security scan pass
  - ✅ ADR compliance check
  - ✅ Context reference exists
```

---
