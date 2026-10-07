# Contribution Guide

## プラグインの追加方法

### 1. Create Branch

```bash
git checkout -b feature/your-plugin-name
```

### 2. Create Plugin

```bash
mkdir -p plugins/your-plugin-name/.claude-plugin
```

`plugins/your-plugin-name/.claude-plugin/plugin.json` を作成：

```json
{
  "name": "your-plugin-name",
  "description": "プラグインの説明",
  "version": "1.0.0",
  "author": {
    "name": "Classmethod"
  }
}
```

`name`・`description`・`version`・`author.name` は、検証スクリプトで必須として検査されます。

プラグインには以下を含めることができます：
- `skills/` - スキル（新しく作るならこちらを推奨）
- `commands/` - スラッシュコマンド（従来の形式）
- `agents/` - サブエージェント
- `hooks/` - フック（関数でフックを書く mods もここ）
- `.mcp.json` - MCP サーバー

詳細は [PLUGIN_SCHEMA.md](./PLUGIN_SCHEMA.md) を参照。

### 3. Register

マーケットプレイスの一覧に追加します。

- `.claude-plugin/marketplace.json` の `plugins` に、`{ "name": "your-plugin-name", "source": "./plugins/your-plugin-name", "description": "…" }` を追加
- `README.md` の Plugins の表に1行追加

`version` は `plugin.json` にだけ書き、一覧には書かないでください。

### 4. Validation

```bash
./scripts/validate-all-plugins.sh your-plugin-name
claude plugin validate plugins/your-plugin-name
claude plugin validate .
```

mods の場合は `claude plugin test plugins/your-plugin-name` も走らせてください。

### 5. Pull Request

タイトル: `[Plugin] your-plugin-name`

## 参考

- https://dev.classmethod.jp/articles/claude-code-skills-subagent-plugin-guide/
- https://code.claude.com/docs/en/plugins
- https://code.claude.com/docs/en/plugins/mods/overview
