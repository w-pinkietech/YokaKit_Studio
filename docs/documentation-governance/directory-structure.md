# Documentation Governance: 推奨ディレクトリ構成

YokaKit Studio では文脈（Context）とコード（Code Output）を分離して管理するため、ドキュメント配置の判断基準を明確にしておくことが重要である。本ガイドは `docs/` 配下だけでなく、`.aidlc/contexts/` やサブモジュールに広がるドキュメント構造を俯瞰し、新しいディレクトリを追加・再編する際の共通言語を提供する。

## 分類軸
新設・再編の可否は「成果物種別」「ライフサイクル」の 2 軸で評価する。ドキュメントの主な読者は補助情報として明示するが、ディレクトリ構造の軸には含めない。

### 成果物種別
- **Policy**: Issue/PR 運用やドキュメント管理に関する規約（Framework / Documentation の双方を含む）。
- **Process Guide**: AI-DLC 実行手順、テスト仕様策定、スプリント/ボルト運用。
- **Reference**: 用語集、コードマッピング、外部仕様、API 契約。
- **Tooling**: CLI やスラッシュコマンド、セットアップ手順。
- **Template**: README/AGENTS/INDEX などの雛形。生成物の一貫性を担保。

### ライフサイクル
- **Stable**: 頻繁には変えない基礎ルール。ディレクトリ単位で体系化し、変更は Issue を通じて合意する。
- **Iterative**: Bolt/リリースごとに検証・更新する成果物。変更履歴を追いやすいようコンテキスト別に分割。
- **Archive**: 役目を終えた文書を保管する領域。GitHub のコミット履歴だけに頼らず、人間/AI がすぐ参照できる形で残す。参照元からリンクを外し、必要に応じて復元できるよう補足を残す（コミットごとに移動する必要はない）。
- **Ephemeral**: 一時的な調査やスパイク結果。原則として Issue や PR ノートに留め、常設ディレクトリ化は避ける。

## 推奨カテゴリと用途
成果物種別を主軸としてディレクトリを構成し、ライフサイクルの違いはサブディレクトリで表現する。

| ディレクトリ | 成果物種別 | 主なライフサイクル運用 | 代表的な内容 |
|--------------|-------------|--------------------------|----------------|
| `docs/policy/` | Policy | Stable。必要に応じて `iterative/` や `archive/` を分岐。 | `policy/framework/`（GitHub 設定、ラベル運用、権限フロー）、`policy/documentation/`（文書運用・スタイル）、`policy/security/` など。 |
| `docs/process-guides/` | Process Guide | Stable な原則 + `iterative/` で Bolt 補足。 | `process-guides/development/`, `process-guides/agents/`, `process-guides/release/`。 |
| `docs/reference/` | Reference | Stable を基本とし、非推奨化した資料は `archive/` へ。 | `reference/overview/`, `reference/glossary/`, `reference/code-mapping/`, `reference/api/`。 |
| `docs/tooling/` | Tooling | Iterative。ツール更新履歴を `changelog/` 等で管理。 | `tooling/claude/`, `tooling/github/`, `tooling/scripts/`。 |
| `docs/templates/` | Template | Stable。改定時は版管理や `archive/` を利用。 | `templates/readme/`, `templates/adr/`, `templates/index/` など成果物別テンプレート。 |

> 既存ファイル（例: `framework-governance.md`, `docs/AGENTS.md`, `docs/README.md`）は順次上記のカテゴリへ移行し、各カテゴリで `README` / `AGENTS` / `INDEX` の三点セットを整備する。

> 新カテゴリを追加する場合は、表で示した成果物種別とライフサイクルの整理方針を満たしたうえで `docs/README.md` / `docs/INDEX.md` / `docs/AGENTS.md` に導線を必ず追加する。

`Policy` カテゴリは対象領域によって責務が分かれる点に注意する。AI-DLC の運用規約（Issue/PR フローやラベル運用など）は `docs/policy/framework/` に整理し、ドキュメントそのものの構造・更新・スタイルを統制するルールは `docs/policy/documentation/` へ配置する。ライフサイクルに応じて `stable/`, `iterative/`, `archive/` を使い分け、更新履歴を追いやすくする。

### ライフサイクルレイヤ運用例
- `stable/`: 原則として不変のルールや確定済み仕様を配置する。  
- `iterative/`: Bolt やリリースごとに更新される補足ノートを時系列で格納する。  
- `archive/`: 廃止・置き換え済み文書を保持し、参照元からはリンクを外す。コミット毎ではなく、廃止判断が下ったタイミングで移動する。  
- `ephemeral/`: 調査メモや短命な補足情報を一時的に置く。一定期間を過ぎたら削除または正式なディレクトリへ昇格させる。  
- 条件付き情報や作業メモが必要な場合は `meta/` や日付サブディレクトリを活用する。

> ライフサイクルレイヤは必要な場合のみ追加し、過剰な入れ子構造を避ける。

## 新規ディレクトリ判断フロー
```
Start
  |
  v
目的・読者・成果物種別を Issue で定義（Context / Problem / Proposal を明文化）
  |
  v
既存カテゴリのページまたは節で表現できるか？
  ├─ Yes → 既存ディレクトリに統合し、該当 README/INDEX を更新
  └─ No
      |
      v
ライフサイクルは Stable / Iterative のどちらか？
      ├─ Stable → `docs/<成果物種別>/` 配下に常設ディレクトリを新設
      └─ Iterative → `.aidlc/contexts/<id>/` などコンテキスト単位の構造に追加
            |
            v
README / AGENTS / INDEX の三点セットを準備し、参照リンクを更新
  |
  v
関連リポジトリ（Code Output / References）の README 等にも導線が必要かを確認
```

## ディレクトリ追加チェックリスト
- [ ] Issue に目的・読者・成果物種別・ライフサイクルを明記した。
- [ ] 既存カテゴリへ統合できない理由を記録した（`docs/README.md` または `docs/INDEX.md` の該当節にメモ）。
- [ ] 新設ディレクトリに `README.md`（人間向け）、`AGENTS.md`（AI 向け）、`INDEX.md`（索引用）を準備した。
- [ ] ルート `README.md`・`docs/README.md`・`docs/INDEX.md`・`docs/AGENTS.md` に導線を追加した。
- [ ] `.aidlc/contexts/<id>/code-mapping.md` など文脈文書との対応を確認した。
- [ ] サブモジュール（`submodules/code-output/` や `submodules/references/`）の README/INDEX にも必要なリンクを追加した。
- [ ] ラベルや PR テンプレートに追記が必要かレビューし、必要なら併せて更新した。

## 命名と補助ドキュメント
- ディレクトリ名は `<成果物種別>/<トピック>` を基本とし、複数語の場合はハイフンで連結する（例: `docs/process-guides/release-governance/`、`docs/policy/framework/branch-protection/`）。
- 各ディレクトリの `README.md` は「人間が最初に読むガイド」、`AGENTS.md` は「AI が即座に参照できる手順書」として役割を分ける。
- `.aidlc/contexts/` では `inception/`（Intent/Units/Stories）と `construction/`（Domain/Logical Design）を既定とし、追加が必要な場合は `construction/<domain>/` など責務が明確な単位で分岐させる。
- サブモジュール側で README/AGENTS/INDEX を展開する際も、このガイドと同じ三点セット・命名規則を適用する。

## 維持管理のヒント
- Bolt ごとにディレクトリ構成の棚卸しを行い、役割が重複している場合は統合を検討する。
- Issue/PR で参照したディレクトリが未整備の場合は、このガイドへリンクを追加し対応方針を記録する。
- `scripts/setup_labels.sh --dry-run` や `gh project` を活用し、ドキュメント整備タスクの優先度を定期的に見直す。
