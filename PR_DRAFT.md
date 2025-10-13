# [framework] status:: ラベル運用の簡素化

## 概要
- `status::` 軸のラベルを `triage` / `ready` / `in-progress` / `in-review` / `done` / `blocked` に再編成し、作業ステータスを明瞭化。
- 運用ルールを `docs/10-governance/framework/README.md` および関連ガイドに反映。
- `scripts/setup_labels.sh` の同期対象を更新し、Dry-run / 本番同期を実施。
- Exec Plan 着手時に Issue を自動検出/作成する `scripts/exec_plan/bootstrap.sh` を追加。
- 既存 Issue (#1) のステータスラベルを新体系に合わせて更新し、旧 `status::needs-decision` を削除。

## 影響範囲
- ガバナンスドキュメント（`docs/10-governance/framework/README.md`）
- エージェントガイド（`docs/20-process/agents/README.md`）
- ドキュメント SOP（`docs/00-foundation/documentation/standard-procedures.md`）
- ラベル同期スクリプト（`scripts/setup_labels.sh`）
- Exec Plan ブートストラップ（`scripts/exec_plan/bootstrap.sh`）
- Exec Plan（`records/by-pr/22-status-label-flow/plans.md`）

## 検証
```bash
# ラベル定義のDry-run検証
GITHUB_TOKEN=dummy ./scripts/setup_labels.sh example/example --dry-run

# 本番リポジトリへのラベル同期
GITHUB_TOKEN=$(gh auth token) scripts/setup_labels.sh w-pinkietech/YokaKit_Studio

# Issue #1 のステータスラベル更新
gh issue edit 1 --remove-label "status::needs-decision" --add-label "status::triage"

# Exec Plan ブートストラップ（Dry-run）
scripts/exec_plan/bootstrap.sh --slug <slug> --filter-label track::framework --title "[framework] <title>" --dry-run
```

## 参考
- Exec Plan: `records/by-pr/22-status-label-flow/plans.md`
- Records summary: `records/by-pr/22-status-label-flow/summary.md`
