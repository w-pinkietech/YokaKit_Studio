# Process Guides Playbook

## 目的
- プロセス関連ドキュメント（開発フロー、エージェント運用ガイドなど）への導線をまとめ、作業前に必要事項を確認する。
- `docs/process-guides/` 配下を更新する際のチェックリストを提供する。

## 索引
- [ディレクトリマップ](#ディレクトリマップ)
- [作業プロトコル](#作業プロトコル)
- [参考リンク](#参考リンク)

## ディレクトリマップ
```
/docs/process-guides/
├── README.md                # カテゴリ概要
├── AGENTS.md                # このファイル
├── INDEX.md                 # 詳細目次
├── development/             # AI-DLC 開発プロセス
└── agents/                  # AI エージェント向け実務手順
```

## 作業プロトコル
1. 対象となるプロセス領域（development / agents / 追加予定カテゴリなど）を確認する。
2. Issue を起点に目的と成果物種別を明記し、`status::ready` であることを確認する。
3. 必要なテストや検証ステップが定義されているかをチェックし、ドキュメント改訂後は最新化されたリンクを `docs/README.md` と `docs/INDEX.md` に反映する。

## 参考リンク
- [Development Process Guide](development/README.md)
- [Agents Operations Guide](agents/README.md)
- [Policy Framework](../policy/framework/README.md)
