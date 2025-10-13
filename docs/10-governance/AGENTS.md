# Policy Operations Guide

## 目的
- ポリシー関連ドキュメント（フレームワーク運用、ドキュメント統制など）を一貫した場所から参照する。
- Issue 起点での合意形成やレビュー手順を確認し、逸脱がないようにする。

## 索引
- [ディレクトリマップ](#ディレクトリマップ)
- [作業プロトコル](#作業プロトコル)
- [リンク集](#リンク集)

## ディレクトリマップ
```
/docs/10-governance/
├── README.md                # ポリシーカテゴリの目的と構成
├── AGENTS.md                # このファイル
├── INDEX.md                 # 詳細な目次
└── framework/               # Issue/PR/ラベル運用ポリシー
```

## 作業プロトコル
1. 対象となるポリシー領域（framework / 追加予定カテゴリなど）を特定する。
2. フレームワーク関連変更は、[Issue #12](https://github.com/w-pinkietech/YokaKit_Studio/issues/12) で定義された再編方針に沿って Issue → ブランチ → PR の順で進める。
3. ライフサイクルが `stable` とされているファイルは、必ず Issue で合意形成してから更新する。
4. 参照リンクを追加・更新したら、`docs/README.md` と `docs/INDEX.md` を忘れずに同期する。

## リンク集
- [Framework Policy Docs](framework/README.md)
- [Documentation Rules（Foundation）](../00-foundation/documentation/rules.md)
- [Documentation Standard Procedures（Foundation）](../00-foundation/documentation/standard-procedures.md)
- [Repository README](../../README.md)
