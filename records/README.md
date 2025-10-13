# Discussion Records Hub

意思決定や議論の履歴を、文脈が失われない形で索引・要約として残すための場所です。本文の一次情報（Issue/PR/レビュー/コミットのスレッド）は GitHub を真とし、リポジトリ側には“索引と要約”のみを収容します。

## 目的
- コミットやPRに紐づく議論の位置情報（Permalink）を整理し、追跡性を高める。
- 合意事項は docs 側（Rules/SOP/ADR 等）へ昇華しつつ、経緯の要約をここから辿れるようにする。
- docs/ と混在させず、履歴・メタの置き場として分離する。

## 運用方針（簡素運用）
- 基本は「PR単位のみ」を記録対象にする（by-pr のみ必須）。
  - Issue/Commit は front matter の `relates_to` に番号/SHAs を列挙するだけで十分。
- 複数リポ横断は「Change Package（packages）」を親にして、配下の PR 要約へリンク。
- 例外運用：
  - 長期化する合意待ちの議論のみ、一時的に by-issue を作成（PR化後は PR 要約が真、Issue 要約は参照/廃止）。
  - PRを伴わない緊急 Hotfix のみ、by-commit を作成。
- 正: GitHub 上のスレッド（Issue/PR/Review/Commit）
- 補: 本ディレクトリの summary.md（要約 + メタデータ + Permalink）
- 決定: 重要な結論は docs/ の該当箇所（Rules/SOP/Process/ADR など）へ反映し、本ディレクトリからリンクする。

## ディレクトリ構成
```
records/
├─ README.md                 # このファイル
├─ INDEX.md                  # 横断索引（Issue/PR/Commit別）
├─ templates/
│  └─ summary.md             # 要約テンプレート
├─ by-issue/                 # 原則作らない（長期議論の例外時のみ）
│  └─ .gitkeep
├─ by-pr/
│  └─ 17-foundation-reorg/
│     └─ summary.md          # 例: 今回のPRの要約
└─ by-commit/                # 原則作らない（PRを伴わないHotfix時のみ）
   └─ .gitkeep

## 使い方の基本
1) PR を作成したら、テンプレートをコピーして `records/by-pr/<number>-<slug>/summary.md` を作成。
   - コマンド例: `bash scripts/records/new_pr_summary.sh <pr-number> <slug> --issue <issue-number> --repo-url https://github.com/<org>/<repo> --author @<you>`
2) YAML front matter を埋める：`relates_to`（Issue/PR/Commit）、`links.thread`、主要スレッドの `permalinks`、必要なら `repos`。
3) Summary/Key Points/Links を 3〜10行で要約（全文は貼らず Permalink で誘導）。
4) 合意事項は docs（Rules/SOP/ADR 等）に反映し、`decisions.impacts` に該当ファイルを列挙。
5) 複数リポ横断の場合は `records/packages/` に親を作り、各 PR 要約へリンク。
   - コマンド例: `bash scripts/records/new_package.sh <issue-number> <slug>`
```

## メタデータ（YAML）
- id, type(issue/pr/commit), status(open/merged/closed), relates_to(issues/prs/commits)
- authors, dates(created/updated), links(permalinks), decisions, next_actions

## 注意
- 機密情報は記載しない。
- 長文の全文貼付は避け、Permalink を使って GitHub の一次情報に誘導する。
- プライバシーと公開範囲に配慮し、必要に応じて要約を省略・編集する。
