# YokaKit_Studio Project Overview

## Purpose
YokaKit_Studioは、YokaKitの文脈統合開発環境（Yokakit文脈統合開発環境）です。
YokaKitはLaravelベースのWebアプリケーションで、本プロジェクトはその開発環境とワークフローを管理します。

## Project Structure
- **Root Project**: YokaKit_Studio - メタプロジェクト、開発ワークフロー管理
- **Submodule**: yokakit - 実際のLaravelアプリケーション（git@github.com:w-pinkietech/YokaKit.git）

## Tech Stack
### YokaKit Application
- **Backend**: PHP (Laravel framework)
- **Database**: MariaDB 10.11.4
- **Web Server**: Apache
- **Message Broker**: MQTT (Eclipse Mosquitto)
- **WebSocket**: Laravel Reverb
- **Container**: Docker / Docker Compose
- **CI/CD**: GitHub Actions

### Development Tools
- **IDE Support**: VS Code Devcontainer, GitHub Codespaces
- **Testing**: PHPUnit, Laravel Dusk (425/425 tests passing)
- **Code Quality**: PHP Pint (formatter), PHPStan (static analysis)
- **Workflow Management**: Claude Code with custom slash commands

## Repository Structure
```
YokaKit_Studio/
├── .claude/          # Claude Code configuration
│   ├── settings.local.json
│   └── commands/     # Custom slash commands (/specify, /plan, /tasks, etc.)
├── .specify/         # Specification and planning workflow
│   ├── scripts/      # Bash scripts for workflow automation
│   ├── templates/    # Templates for spec, plan, tasks, agents
│   └── memory/       # Constitution and project guidelines
├── .serena/          # Serena MCP configuration
├── .mcp.json         # MCP servers configuration
└── yokakit/          # Git submodule - main Laravel application
    ├── app/          # Laravel application code
    ├── docker/       # Docker configuration
    ├── mqtt/         # MQTT broker configuration
    └── compose.yml   # Docker Compose configuration
```