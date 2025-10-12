# Task Completion Checklist

When a coding task is completed, perform these checks in order:

## 1. Code Quality
- [ ] Run PHP Pint to format code
  ```bash
  docker compose exec yokakit-web-app ./vendor/bin/pint
  ```
- [ ] Run PHPStan for static analysis
  ```bash
  docker compose exec yokakit-web-app ./vendor/bin/phpstan analyse
  ```

## 2. Testing
- [ ] Run all tests and ensure they pass
  ```bash
  docker compose exec yokakit-web-app php artisan test
  ```
- [ ] Verify test coverage if new features were added
  ```bash
  docker compose exec yokakit-web-app php artisan test --coverage
  ```
- [ ] All tests should pass (target: 100%)

## 3. Cache Clearing (if configuration or routes changed)
- [ ] Clear application caches
  ```bash
  docker compose exec yokakit-web-app php artisan optimize:clear
  docker compose exec yokakit-web-app php artisan route:cache
  docker compose exec yokakit-web-app php artisan config:cache
  ```

## 4. Documentation
- [ ] Update relevant documentation files
- [ ] Add/update code comments where necessary
- [ ] Update README if user-facing changes were made

## 5. Git Operations
- [ ] Review changes with `git status` and `git diff`
- [ ] Stage relevant files
- [ ] Commit with descriptive message
- [ ] Push to feature branch if applicable

## 6. Integration Verification
- [ ] Verify the application runs correctly
  ```bash
  docker compose up -d
  docker compose logs -f yokakit-web-app
  ```
- [ ] Test in browser at http://localhost:18080 (if UI changes)
- [ ] Check for errors in logs

## 7. Specification Workflow (if using .specify)
- [ ] Update specification if requirements changed
- [ ] Mark tasks as completed in tasks.md
- [ ] Run `/analyze` for consistency check (if applicable)

## Optional: SonarQube Analysis
If SonarQube is configured:
- [ ] Review quality gate status
- [ ] Address any new issues or code smells

## Emergency Cleanup
If unexpected issues occur:
```bash
docker compose down -v --remove-orphans
docker compose up -d --build
docker compose exec yokakit-web-app composer install
docker compose exec yokakit-web-app php artisan migrate
```