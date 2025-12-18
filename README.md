# Classmethod Claude Code Marketplace

Claude Code用のコマンドとプラグインのマーケットプレイスです。

## Setup

### 1. マーケットプレイスを追加

```
/plugin marketplace add classmethod/claude-code-marketplace
```

### 2. プラグインをインストール

```
/plugin install <plugin-name>@classmethod-marketplace
```

例：
```
/plugin install hello-world@classmethod-marketplace
```

## Plugins

| プラグイン | 説明 |
|-----------|------|
| [hello-world](./plugins/hello-world) | シンプルなHello Worldプラグインのサンプル |

## Plugin Management

```bash
# プラグインを無効化
/plugin disable <plugin-name>@classmethod-marketplace

# プラグインを有効化
/plugin enable <plugin-name>@classmethod-marketplace

# プラグインをアンインストール
/plugin uninstall <plugin-name>@classmethod-marketplace
```

## Contribution

プラグインを追加したい場合は [CONTRIBUTING.md](./CONTRIBUTING.md) を参照してください。

## License

MIT License
