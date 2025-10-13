# Step 3: Test Specification（テスト仕様）

### 3.1 Test Cases Generation（AI）

**AI Prompt Template**:
```
Context: {Domain Design, ADR}

Task: 以下のDomain Componentsのテストケースを網羅的に生成してください。

Components:
- Account Entity
- SwitchAccountService

Test Types:
- Unit Tests
- Integration Tests
- Boundary Tests
- Error Cases

Output Format:
# Test Specification: Account Entity

## Unit Tests

### Test Case: UT-001
- Description: アカウント作成が成功する
- Given: 有効なアカウント情報
- When: Account::create()を実行
- Then: Accountインスタンスが生成される
- Assertions:
  - account.id is not null
  - account.name equals input
  - account.createdAt is set

### Test Case: UT-002 (Boundary)
- Description: 名前が空の場合にエラー
- Given: name = ""
- When: Account::create()を実行
- Then: ValidationException がスローされる
- Assertions:
  - exception.message contains "name"

## Integration Tests

### Test Case: IT-001
- Description: アカウント切り替えフロー
- Given: 2つのアカウントが存在
- When: SwitchAccountService::switch(accountId)を実行
- Then: セッションが切り替わる
- Assertions:
  - session.currentAccountId equals accountId
  - Redis contains session data
  - previous account session is preserved

## Coverage Target
- Line Coverage: 100%
- Branch Coverage: 100%
```

**Output**: `.aidlc/contexts/001-*/construction/tests/test-specification.md`

---

### 3.2 Human Verification of Test Cases

**Verification Checklist**:
```markdown
## Test Coverage Verification
- [ ] すべてのUser Storyがカバーされているか
- [ ] 正常系・異常系が網羅されているか
- [ ] Boundary Cases（境界値）がカバーされているか
- [ ] Concurrency（並行処理）が考慮されているか
- [ ] Security（セキュリティ）が考慮されているか

## ADR Compliance
- [ ] ADR-001（Redis）の制約がテストされているか
- [ ] NFRs（性能・可用性）がテストされているか

## Test Quality
- [ ] Given-When-Then形式で明確か
- [ ] Assertionsが具体的か
- [ ] テストが独立しているか（テスト間依存なし）
- [ ] テストデータが明確か
```

**Manual Addition** (if needed):
```markdown
## Additional Test Cases (Human Added)

### Test Case: UT-010 (Security)
- Description: 不正なトークンでアカウント切り替えを試みる
- Given: 無効なセッショントークン
- When: SwitchAccountService::switch(accountId)を実行
- Then: UnauthorizedException がスローされる
```

---

### 3.3 Test Code Generation（AI）

**AI Prompt Template**:
```
Context: {Test Specification, Domain Design, Tech Stack}

Task: 以下のTest SpecificationをPHPUnit形式のテストコードに変換してください。

Test Specification: test-specification.md
Tech Stack: Laravel 10, PHPUnit 10

Output Format (PHPUnit):
```php
<?php

namespace Tests\Unit\Models;

use Tests\TestCase;
use App\Models\Account;
use App\Exceptions\ValidationException;

class AccountTest extends TestCase
{
    /** @test */
    public function it_creates_account_successfully(): void
    {
        // Given: 有効なアカウント情報
        $data = [
            'name' => 'Test User',
            'email' => 'test@example.com',
        ];

        // When: Account::create()を実行
        $account = Account::create($data);

        // Then: Accountインスタンスが生成される
        $this->assertNotNull($account->id);
        $this->assertEquals('Test User', $account->name);
        $this->assertNotNull($account->createdAt);
    }

    /** @test */
    public function it_throws_exception_when_name_is_empty(): void
    {
        // Given: name = ""
        $data = ['name' => '', 'email' => 'test@example.com'];

        // Then: ValidationException がスローされる
        $this->expectException(ValidationException::class);
        $this->expectExceptionMessage('name');

        // When: Account::create()を実行
        Account::create($data);
    }
}
```
```

**Output**: `submodules/code-output/yokakit/tests/Unit/Models/AccountTest.php`

---

### 3.4 Human Review of Test Code

**Review Checklist**:
```markdown
- [ ] Test Specificationと一致しているか
- [ ] Given-When-Then構造が明確か
- [ ] Assertionsが適切か
- [ ] テストデータが適切か
- [ ] セットアップ/ティアダウンが適切か
- [ ] テストが独立しているか
```

---

### 3.5 Commit: Tests Only（実装前）

```bash
cd submodules/code-output/yokakit
git checkout -b feature/001-account-entity-tests

# テストコードのみコミット（実装はまだない）
git add tests/Unit/Models/AccountTest.php
git add tests/Unit/Services/SwitchAccountServiceTest.php
git add tests/Integration/AccountSwitchFlowTest.php

git commit -m "test: Add test suite for Account Entity (TDD)

Test Cases:
- UT-001 ~ UT-010: Account Entity unit tests
- IT-001 ~ IT-005: Account switching integration tests

Based on:
- Context Studio: Domain Design
- Test Specification: .aidlc/contexts/001-*/construction/tests/

Note: Implementation not yet added (TDD approach)
All tests currently FAIL (expected)"

git push origin feature/001-account-entity-tests
```

**GitHub PR**:
- Title: `[TDD] Test Suite: Account Entity`
- Labels: `type::tests`, `context::001`, `status::draft`
- Body:
  ```markdown
  ## Context Studio Reference
  - Domain Design: context-studio#5
  - Test Specification: .aidlc/contexts/001-*/construction/tests/
  
  ## Test Coverage
  - Unit Tests: 10 cases
  - Integration Tests: 5 cases
  - Target Coverage: 100%
  
  ## Status
  - [ ] All tests currently FAIL (expected - no implementation yet)
  - [ ] Ready for implementation phase
  
  ## Next Step
  After this PR merges, AI will generate implementation to make tests pass.
  ```

---
