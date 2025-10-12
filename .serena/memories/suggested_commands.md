# Suggested Commands for YokaKit_Studio

## Docker Operations
### Initial Setup
```bash
cd yokakit
chmod +x setup.sh
./setup.sh  # Generate .env and configure settings
```

### Container Management
```bash
# First time or after Dockerfile changes
docker compose up -d --build

# Normal startup (subsequent runs)
docker compose up -d

# Stop containers
docker compose down

# Complete cleanup (volumes + orphans)
docker compose down -v --remove-orphans
```

### Application Setup
```bash
# Install dependencies
docker compose exec yokakit-web-app composer install

# Run migrations
docker compose exec yokakit-web-app php artisan migrate

# Seed test data (optional)
docker compose exec yokakit-web-app php artisan db:seed

# Create admin user (optional)
docker compose exec yokakit-web-app php artisan make:user admin admin@example.com 'StrongP@ssw0rd!'
```

## Development Commands
### Testing
```bash
# Run all tests
docker compose exec yokakit-web-app php artisan test

# Run tests in parallel
docker compose exec yokakit-web-app php artisan test --parallel --processes=4

# Run tests with coverage
docker compose exec yokakit-web-app php artisan test --coverage
```

### Code Quality
```bash
# Format code
docker compose exec yokakit-web-app ./vendor/bin/pint

# Static analysis
docker compose exec yokakit-web-app ./vendor/bin/phpstan analyse
```

### Monitoring
```bash
# Watch application logs
docker compose logs -f yokakit-web-app

# Real-time resource monitoring
docker compose stats

# Monitor MQTT messages
docker compose exec mqtt mosquitto_sub -h mqtt -p 1883 -t 'production/#'
```

### Cache Management
```bash
# Clear all caches
docker compose exec yokakit-web-app php artisan optimize:clear

# Cache routes
docker compose exec yokakit-web-app php artisan route:cache

# Cache config
docker compose exec yokakit-web-app php artisan config:cache
```

## Git Operations
```bash
# Initialize/update submodules
git submodule update --init --recursive

# Pull latest changes including submodules
git pull --recurse-submodules
```

## Custom Slash Commands (Claude Code)
These commands are defined in `.claude/commands/`:
- `/specify` - Create or update feature specification
- `/plan` - Execute implementation planning workflow
- `/tasks` - Generate actionable tasks.md
- `/implement` - Execute implementation plan
- `/clarify` - Identify underspecified areas
- `/analyze` - Cross-artifact consistency analysis
- `/constitution` - Create or update project constitution

## Access URLs
- Local: http://localhost:18080
- Remote: http://<server-ip>:18080
- WebSocket: Port 8081

## Multi-stage Docker Build
```bash
# Build for production
docker build --target production .

# Build for development
docker build --target development .
```