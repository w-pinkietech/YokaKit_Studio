# Quick Command Reference

### Development Workflow

```bash
# === Step 1: Domain Design ===
git checkout -b construction/001-multi-account/domain-design
# AI: Domain Design生成 → 人間: 検証
git add .aidlc/contexts/001-*/construction/domain-design/
git commit -m "feat(domain): Add Domain Design for Account Entity"
git push && gh pr create

# === Step 2: ADR ===
git checkout -b construction/001-multi-account/logical-design
# AI: ADR生成 → 人間: トレードオフ検証
git add .aidlc/contexts/001-*/construction/logical-design/adr/
git commit -m "feat(adr): ADR-001 Redis session management"
git push && gh pr create

# === Step 3: Tests ===
cd submodules/code-output/yokakit
git checkout -b feature/001-account-entity-tests
# AI: Test Cases生成 → 人間: 検証 → AI: Test Code生成
git add tests/
git commit -m "test: Add test suite for Account Entity (TDD)"
git push && gh pr create --draft

# === Step 4: Implementation ===
# AI: Code生成 → Tests実行 → 失敗 → AI修正 → 成功
composer test  # すべてパスするまで繰り返し
git add app/
git commit -m "feat: Implement Account Entity"
git push
gh pr ready  # draft → ready for review

# === Step 5: Documentation ===
cd /path/to/context-studio
git checkout construction/001-multi-account
# AI: Code Mapping更新
git add .aidlc/contexts/001-*/construction/code-mapping.md
git commit -m "docs: Update code mapping"
git push
```

---
