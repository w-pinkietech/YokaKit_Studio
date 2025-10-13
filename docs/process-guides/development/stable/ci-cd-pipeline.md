# CI/CD Pipeline

### Context Studio Pipeline

```yaml
# .github/workflows/context-validation.yml
name: Context Validation

on:
  pull_request:
    paths:
      - '.aidlc/contexts/**'

jobs:
  domain-design-validation:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Validate Markdown
        run: markdownlint .aidlc/contexts/
      
      - name: Validate Mermaid Diagrams
        uses: mermaid-js/mermaid-cli@v9
        with:
          files: '.aidlc/contexts/**/domain-design/*.md'
      
      - name: Check Domain Terminology
        run: |
          # User Story用語とDomain Design用語の一貫性チェック
          python scripts/check-domain-terminology.py

  adr-validation:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Validate ADR Format
        run: |
          # ADRテンプレート準拠チェック
          python scripts/validate-adr-format.py
      
      - name: Check ADR Completeness
        run: |
          # Alternatives, Consequences存在チェック
          python scripts/check-adr-completeness.py
```

---

### Code Output Pipeline

```yaml
# .github/workflows/ci.yml
name: CI

on:
  pull_request:
    branches: [main]

jobs:
  context-reference-check:
    runs-on: ubuntu-latest
    steps:
      - name: Validate Context Reference
        run: |
          # PR BodyにContext参照があるか
          if ! grep -q "Context Studio Reference" <<< "${{ github.event.pull_request.body }}"; then
            echo "❌ Context Studio Reference required"
            exit 1
          fi

  tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: 8.2
      
      - name: Install Dependencies
        run: composer install
      
      - name: Run Tests
        run: composer test
      
      - name: Check Coverage
        run: |
          COVERAGE=$(php artisan test --coverage-text | grep "Lines:" | awk '{print $2}' | tr -d '%')
          if [ $COVERAGE -lt 100 ]; then
            echo "❌ Coverage is $COVERAGE% (required: 100%)"
            exit 1
          fi

  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: composer install
      - run: ./vendor/bin/phpstan analyse --level=8
      - run: ./vendor/bin/php-cs-fixer fix --dry-run --diff

  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: composer install
      - run: composer audit
      - uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: '.'

  adr-compliance:
    runs-on: ubuntu-latest
    steps:
      - name: Check ADR Compliance
        run: |
          # ADR-001: Redis使用確認
          if grep -q "ADR-001" <<< "${{ github.event.pull_request.body }}"; then
            if ! grep -rq "use Illuminate\\Support\\Facades\\Redis" app/; then
              echo "❌ ADR-001 requires Redis usage"
              exit 1
            fi
          fi
```

---
