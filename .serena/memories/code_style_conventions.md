# Code Style and Conventions

## PHP/Laravel Code Style
### Formatting
- **Tool**: PHP Pint (Laravel's official code style fixer)
- **Command**: `docker compose exec yokakit-web-app ./vendor/bin/pint`
- Follows PSR-12 coding standards with Laravel-specific adjustments

### Static Analysis
- **Tool**: PHPStan
- **Command**: `docker compose exec yokakit-web-app ./vendor/bin/phpstan analyse`
- Ensures type safety and catches potential bugs

## Testing Standards
### Test Coverage
- **Current Status**: 425/425 tests passing (100%)
- **Types**: Unit Tests, Feature Tests, Browser Tests (Laravel Dusk)
- **Coverage**: Model layer and HTTP/Controller layer fully covered

### Testing Philosophy
- TDD (Test-Driven Development) approach
- Write tests before implementation
- All new features must include tests
- Maintain 100% passing test rate

### Running Tests
```bash
# All tests
php artisan test

# With coverage
php artisan test --coverage

# Parallel execution
php artisan test --parallel --processes=4
```

## File Organization
### Laravel Structure
- **app/**: Application code (Models, Controllers, Services)
- **resources/**: Views, language files
- **routes/**: Route definitions
- **database/**: Migrations, seeders
- **tests/**: Test suites

## Docker Conventions
### Environment Files
- `.env.example`: Template for environment variables
- `.env`: Actual configuration (not committed)
- DB passwords: Minimum 12 characters (alphanumeric + symbols recommended)

### Multi-stage Builds
- **development**: For local development with volume mounts
- **production**: Optimized for production deployment

## Git Workflow
### Branching
- Feature branches created via `.specify/scripts/bash/create-new-feature.sh`
- Branch naming convention managed by specification workflow

### Commits
- Descriptive commit messages
- Atomic commits (one logical change per commit)

## CI/CD Standards
### GitHub Actions Workflows
- **docker-build.yml**: Multi-architecture build (AMD64, ARM64)
- **docker-publish.yml**: Container registry publishing
- **test.yml**: Automated testing
- **sonarqube.yml**: Code quality analysis
- **cache-cleanup.yml**: 7-day cache retention

### Quality Gates
- All tests must pass
- Code style checks via Pint
- Static analysis via PHPStan
- SonarQube quality gate (if configured)