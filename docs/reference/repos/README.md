# Repository Catalog

複数リポジトリでの変更を扱うためのカタログ。各リポの役割・主要ブランチ・デプロイ先・CI 概要・連絡先など、横断作業に必要な最小情報をまとめる。

## 目的
- 変更対象リポジトリを素早く把握し、横断の依存・順序・責任境界を明確化する。
- Cross-Repo の作業時に参照する共通情報（ブランチ命名、PR 接頭辞、CI の要点）を提供する。

## カタログ項目（推奨）
| 項目 | 説明 |
|------|------|
| Name | リポ名（例: `frontend`, `backend`） |
| URL | リポジトリ URL |
| Role | 役割（例: Web UI, API, Infra） |
| Main Branch | 既定のデフォルトブランチ（例: `main`） |
| Branching | 命名ルール（例: `framework/<issue>-<slug>` / `feature/<slug>`） |
| Environments | デプロイ/動作環境（例: Staging/Prod の URL 等） |
| CI | 主要ジョブ（テスト/ビルド/リリース） |
| Contacts | オーナー/メンテナのハンドル |

## 参照
- 索引: `INDEX.md`
- AIDLC Rules/SOP: `../../00-foundation/aidlc/README.md`

