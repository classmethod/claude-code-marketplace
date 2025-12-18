# Plugin Schema

## ディレクトリ構造

各プラグインは以下の構造に従う必要があります：

```
plugins/your-plugin-name/
├── .claude-plugin/
│   └── plugin.json          # 必須: プラグインメタデータ
├── commands/                # オプション: スラッシュコマンド
│   └── your-command.md
├── agents/                  # オプション: エージェント定義
│   └── your-agent.md
├── skills/                  # オプション: スキル定義
│   └── your-skill/
│       └── SKILL.md
├── hooks/                   # オプション: フック定義
└── README.md                # 推奨: プラグイン説明
```

## plugin.json の仕様

### フィールド

description、version、author.nameは必須ではありませんが、
なるべく記述してください。

```json
{
  "name": "your-plugin-name",
  "description": "プラグインの簡潔な説明",
  "version": "1.0.0",
  "author": {
    "name": "Your Name"
  }
}
```

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `name` | string | プラグイン識別子（kebab-case推奨） |
| `description` | string | 簡潔な説明 |
| `version` | string | セマンティックバージョニング（例: 1.0.0） |
| `author.name` | string | 作成者名 |

### オプションフィールド

```json
{
  "author": {
    "url": "https://github.com/yourusername"
  },
  "homepage": "https://example.com/your-plugin",
  "repository": "https://github.com/yourusername/your-plugin",
  "license": "MIT",
  "keywords": ["keyword1", "keyword2"]
}
```

## コマンドファイル形式

`commands/` ディレクトリ内の `.md` ファイルは、スラッシュコマンドとして登録されます。

### 例: commands/hello.md

```markdown
---
description: ユーザーにフレンドリーな挨拶をする
---

ユーザーにフレンドリーな挨拶をしてください。

手順:
1. 時間に応じた挨拶をする
2. 何かお手伝いできることがあるか尋ねる
```

**注意**: YAMLフロントマター（`---`で囲まれた部分）の `description` はコマンド一覧で表示されます。

## バリデーション

プラグインを提出する前に、以下を確認してください：

1. `plugin.json` が有効なJSONである
2. 必須フィールドがすべて含まれている
3. バージョンがセマンティックバージョニングに従っている
4. `name` がkebab-caseである

検証スクリプト：

```bash
./scripts/validate-all-plugins.sh your-plugin-name
```

## ベストプラクティス

- 説明は簡潔で明確に
- キーワードは検索性を高めるために適切に設定
- READMEにはインストール方法と使用例を記載
- セマンティックバージョニングを使用
