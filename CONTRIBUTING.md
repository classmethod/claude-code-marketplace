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
  "version": "1.0.0"
}
```

プラグインには以下を含めることができます：
- `commands/` - スラッシュコマンド
- `agents/` - サブエージェント
- `skills/` - スキル
- `hooks/` - フック

詳細は [PLUGIN_SCHEMA.md](./PLUGIN_SCHEMA.md) を参照。

### 3. Validation

```bash
./scripts/validate-all-plugins.sh your-plugin-name
```

### 4. Pull Request

タイトル: `[Plugin] your-plugin-name`

## 参考

- https://dev.classmethod.jp/articles/claude-code-skills-subagent-plugin-guide/
