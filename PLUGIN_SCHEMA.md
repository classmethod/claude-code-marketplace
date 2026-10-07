# Plugin Schema

## ディレクトリ構造

各プラグインは以下の構造に従う必要があります：

```
plugins/your-plugin-name/
├── .claude-plugin/
│   └── plugin.json          # 必須: プラグインメタデータ
├── skills/                  # オプション: スキル定義（新しく作るならこちらを推奨）
│   └── your-skill/
│       └── SKILL.md
├── commands/                # オプション: スラッシュコマンド（従来の形式）
│   └── your-command.md
├── agents/                  # オプション: エージェント定義
│   └── your-agent.md
├── hooks/
│   └── hooks.json           # オプション: フック定義（mods の場合は hooks module を指す。後述）
├── .mcp.json                # オプション: MCP サーバー定義
└── README.md                # 推奨: プラグイン説明
```

- 公式ドキュメントでは、新しく作るプラグインは `commands/` より `skills/` を推奨しています（`commands/` も引き続き使えます）
- 出力スタイル・LSP サーバーなど、ほかの既定の置き場所は [Plugins reference](https://code.claude.com/docs/en/plugins-reference) を参照してください

## plugin.json の仕様

### フィールド

公式の仕様で必須なのは `name` だけですが、このリポジトリの検証スクリプト（`scripts/validate-all-plugins.sh`）は `description`・`version`・`author.name` も必須として検査します。

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

### パスの書き方

- `commands` などのパスは、プラグインのフォルダからの相対パスで、`./` から始めます（`commands/foo.md` は検査で弾かれます）
- `commands` を指定すると、既定の `commands/` フォルダは読まれなくなります（指定したパスだけを読む）

## mods（hooks module）

mods は、TypeScript / JavaScript の関数でフックを書くプラグインです。パネルやコマンドを足したり、ツールの呼び出しを止めたりできます。Claude Code 2.1.287 以降で標準で有効です。

```
plugins/your-mod-name/
├── .claude-plugin/
│   └── plugin.json
├── hooks/
│   ├── hooks.json           # { "modules": ["./register.ts"] }（1つのパス）
│   └── register.ts          # register(on, options) を export する
├── tests/                   # 推奨: *.test.ts（claude plugin test で実行）
└── README.md
```

- mod は入れた人の権限で動きます（ファイルの読み書き・コマンドの実行・ネットワーク）。README に「何を読み書き・実行するか」を書き、PR の説明には `claude plugin validate` が出す `hooks:` と `calls:` の行を貼ってください
- Claude Code が mod を読み込むと `.claude-plugin/types/` に型定義を書き出します。これはコミットしないでください（プラグインの `.gitignore` に入れる）
- 組織の管理設定（`allowManagedModsOnly` など）で、利用者が入れた mods が止められている環境では動きません
- 詳しくは [Mods overview](https://code.claude.com/docs/en/plugins/mods/overview)・[Mods reference](https://code.claude.com/docs/en/plugins/mods/reference) を参照してください

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

Claude Code に組み込みの検査（プラグインとマーケットプレイスの一覧）：

```bash
claude plugin validate plugins/your-plugin-name
claude plugin validate .
```

mods の場合は、テストも走らせてください：

```bash
claude plugin test plugins/your-plugin-name
```

## 更新するとき

- プラグインを直したら `plugin.json` の `version` を上げてください。`version` が同じままだと、すでに入れている人には届きません
- `version` は `plugin.json` とマーケットプレイスの一覧（`marketplace.json`）の両方には書かないでください（`plugin.json` の値が使われます）
- 詳しくは [Host and maintain a marketplace](https://code.claude.com/docs/en/plugins/host-marketplace) を参照してください

## ベストプラクティス

- 説明は簡潔で明確に
- キーワードは検索性を高めるために適切に設定
- READMEにはインストール方法と使用例を記載
- セマンティックバージョニングを使用

## 参考

- [Plugins overview](https://code.claude.com/docs/en/plugins)
- [Plugin manifest reference](https://code.claude.com/docs/en/plugins-reference)
- [Create a marketplace](https://code.claude.com/docs/en/plugin-marketplaces)
- [Mods overview](https://code.claude.com/docs/en/plugins/mods/overview)
