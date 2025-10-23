# Tooling Operations Guide

## 目的
- ツール関連ドキュメント（Claude、GitHub CLI、スクリプトなど）への導線をまとめ、セットアップやメンテナンス時に参照すべき項目を整理する。

## 索引
- [ディレクトリマップ](#ディレクトリマップ)
- [作業プロトコル](#作業プロトコル)
- [関連リンク](#関連リンク)

## ディレクトリマップ
```
/studio/50-tooling/
├── README.md                # カテゴリ概要
├── AGENTS.md                # このファイル
├── INDEX.md                 # 詳細目次
└── claude/                  # Claude 関連セットアップ・運用ガイド
```

## 作業プロトコル
1. 取り扱うツールが最新ガイドに従っているか確認する。
2. Issue を起点に変更意図を明文化し、`status::ready` を確認する。
3. 更新後は `studio/README.md` や `studio/INDEX.md` のリンクを同期させる。

## 関連リンク
- [Tooling Index](INDEX.md)
- [Claude Toolkit](claude/README.md)
- [Policy Framework](../10-governance/framework/README.md)
