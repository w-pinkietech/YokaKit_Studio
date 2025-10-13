# Step 4: Code Generation（実装生成）

### 4.1 Implementation Code Generation（AI）

**AI Prompt Template**:
```
Context: {Domain Design, ADR, Tests}

Task: 以下のテストがすべてパスする実装を生成してください。

Tests: tests/Unit/Models/AccountTest.php
Domain Design: .aidlc/contexts/001-*/construction/domain-design/
ADR: ADR-001 (Redis-based session)

Constraints:
- すべてのテストをパスすること
- ADR-001の制約を守ること
- Laravel Best Practicesに従うこと
- SOLID原則に従うこと

Output Format (Laravel Model):
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Exceptions\ValidationException;

/**
 * Account Entity
 * 
 * Responsibility: ユーザーアカウントの管理
 * 
 * Domain Design: .aidlc/contexts/001-multi-account/construction/domain-design/static-model.md
 * ADR: ADR-001
 */
class Account extends Model
{
    protected $fillable = ['name', 'email'];

    /**
     * アカウント作成
     * 
     * @throws ValidationException
     */
    public static function create(array $data): self
    {
        self::validate($data);
        
        return parent::create($data);
    }

    private static function validate(array $data): void
    {
        if (empty($data['name'])) {
            throw new ValidationException('name is required');
        }
        
        // ... other validations
    }
}
```
```

**Output**: `submodules/code-output/yokakit/app/Models/Account.php`

---

### 4.2 Run Tests（自動）

```bash
cd submodules/code-output/yokakit

# テスト実行
composer test

# 結果例
PHPUnit 10.0.0

...F..                                                              6 / 6 (100%)

Time: 00:00.123, Memory: 20.00 MB

There was 1 failure:

1) Tests\Unit\Models\AccountTest::it_validates_email_format
Failed asserting that exception message contains 'email format'
```

---

### 4.3 AI Fixes（テスト失敗時）

**AI Prompt Template**:
```
Context: {Test Failure Output}

Task: 以下のテスト失敗を修正してください。

Test Failure:
{failure output}

Current Implementation:
{code}

Output: 修正後のコード
```

**Iteration**:
```
Code生成 → Tests実行 → 失敗 → AI修正 → Tests実行 → 成功
```

---

### 4.4 Human Code Review（テスト成功後）

**Review Checklist**:
```markdown
## Functionality
- [ ] すべてのテストがパスしているか
- [ ] テストカバレッジが100%か

## ADR Compliance
- [ ] ADR-001（Redis）の制約を守っているか
- [ ] ADRで決定した技術を正しく使用しているか

## Code Quality
- [ ] SOLID原則に従っているか
- [ ] 命名が明確か（Domain Designと一致）
- [ ] コメントが適切か（最小限）
- [ ] エラーハンドリングが適切か
- [ ] セキュリティ上の問題がないか

## Performance
- [ ] N+1クエリがないか
- [ ] 不要なメモリ確保がないか
- [ ] キャッシュが適切に使われているか

## Maintainability
- [ ] 将来の拡張性が考慮されているか
- [ ] 技術的負債が発生していないか
```

---

### 4.5 Commit: Implementation

```bash
cd submodules/code-output/yokakit
git checkout feature/001-account-entity-tests

# 実装追加
git add app/Models/Account.php
git add app/Services/SwitchAccountService.php
git add app/Repositories/AccountRepository.php

git commit -m "feat: Implement Account Entity

Implementation:
- Account Entity with validation
- SwitchAccountService with Redis session
- AccountRepository interface

Test Results:
- All tests PASS (15/15)
- Coverage: 100%

Based on:
- Domain Design: context-studio#5
- ADR-001: Redis session management
- Test Specification: context-studio#8

Reviewed-by: @developer1 @developer2"

git push origin feature/001-account-entity-tests
```

**GitHub PR Update**:
- Status: `status::draft` → `status::review`
- Body更新:
  ```markdown
  ## Implementation Added
  - ✅ All tests PASS (15/15)
  - ✅ Coverage: 100%
  - ✅ ADR-001 compliant
  
  ## Ready for Review
  - [ ] Code review (2+ developers)
  - [ ] Architect approval (ADR compliance)
  ```

---
