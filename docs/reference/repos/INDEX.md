# Repository Catalog Index

対象リポジトリの一覧。必要に応じて行を追加し、横断作業前に最新化する。

| Name | URL | Role | Main Branch | Branching | Environments | CI | Contacts |
|------|-----|------|-------------|-----------|--------------|----|----------|
| frontend | https://github.com/<org>/frontend | Web UI | main | `feature/<slug>` | https://staging-frontend.example.com | unit/e2e | @owner |
| backend  | https://github.com/<org>/backend  | API    | main | `feature/<slug>` | https://staging-backend.example.com  | unit/integration | @owner |

備考
- 同一イニシアチブで複数リポを変更する場合、ブランチの slug を統一する（例: `16-aidlc-foundation`）。
- PR タイトルに `[change-pkg:#<issue>]` など共通接頭辞を付ける。

