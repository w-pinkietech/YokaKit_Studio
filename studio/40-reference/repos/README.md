# Repository Catalog（任意）

このカタログは「参考情報（任意）」です。実運用では毎回の横断作業時に対象リポジトリを確認し、PR 要約（records/by-pr）に列挙する方針とします。ここはテンプレートと確認観点のみを保持します。

## 使い方（最小）
- Cross-Repo 作業を開始する際に、下記チェックを PR 要約に記録する。
  - 対象リポ名と URL（必要数のみ）
  - ブランチ命名（例: `framework/<issue>-<slug>` / `feature/<slug>`）
  - 変更順序（例: backend → frontend）
  - 主要 CI の可否（最低限テスト/ビルド）
- 本カタログ（studio/40-reference/repos）は更新必須ではありません。継続的な保守は不要です。

## カタログ項目（テンプレート）
| 項目 | 説明 |
|------|------|
| Name | リポ名（例: `frontend`, `backend`） |
| URL | リポジトリ URL |
| Role | 役割（例: Web UI, API, Infra） |
| Branching | 命名ルール（例: `framework/<issue>-<slug>` / `feature/<slug>`） |
| Notes | 依存や順序、CI 可否などのメモ |

## 参照
- 索引: `INDEX.md`
- AIDLC Rules / SOP: `../../00-foundation/aidlc/README.md`
