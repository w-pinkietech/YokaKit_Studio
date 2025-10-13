# Discussion Records Hub

意思決定や議論の履歴を、文脈が失われない形で索引・要約として残すための場所です。本文の一次情報（Issue/PR/レビュー/コミットのスレッド）は GitHub を真とし、リポジトリ側には“索引と要約”のみを収容します。

## 目的
- コミットやPRに紐づく議論の位置情報（Permalink）を整理し、追跡性を高める。
- 合意事項は docs 側（Rules/SOP/ADR 等）へ昇華しつつ、経緯の要約をここから辿れるようにする。
- docs/ と混在させず、履歴・メタの置き場として分離する。

## 運用方針
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
├─ by-issue/
│  └─ .gitkeep
├─ by-pr/
│  └─ 17-foundation-reorg/
│     └─ summary.md          # 例: 今回のPRの要約
└─ by-commit/
   └─ .gitkeep
```

## メタデータ（YAML）
- id, type(issue/pr/commit), status(open/merged/closed), relates_to(issues/prs/commits)
- authors, dates(created/updated), links(permalinks), decisions, next_actions

## 注意
- 機密情報は記載しない。
- 長文の全文貼付は避け、Permalink を使って GitHub の一次情報に誘導する。
- プライバシーと公開範囲に配慮し、必要に応じて要約を省略・編集する。

