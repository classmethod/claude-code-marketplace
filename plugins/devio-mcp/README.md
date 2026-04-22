# devio-mcp (Claude Code plugin)

DevIO (Contentful) 記事執筆者向けの Model Context Protocol サーバ。Claude Code から記事検索・取得・ネタ被りチェック・ローカル下書き作成/更新を行えます。

## インストール

```
/plugin marketplace add classmethod/claude-code-marketplace
/plugin install devio-mcp
```

## 環境変数の設定

Claude Code の `settings.json`（`~/.claude/settings.json` または プロジェクト `.claude/settings.json`）の `env` ブロックに:

```json
{
  "env": {
    "CONTENTFUL_ACCESS_TOKEN": "CFPAT-xxxxx",
    "CONTENTFUL_SPACE_ID": "ct0aopd36mqt",
    "CONTENTFUL_AUTHOR_ID": "<自分の Author Entry ID>",
    "ARTICLES_DIR": "/Users/you/path/to/articles"
  }
}
```

設定後、Claude Code 再起動または `/mcp reload` で反映。

## 提供ツール

| ツール | 用途 |
|---|---|
| `search_my_articles` | 自分の記事検索（Contentful + ローカルマージ） |
| `list_my_articles` | 自分の記事一覧 |
| `search_all_articles` | 全社記事検索（ネタ被りチェック） |
| `get_article` | articleId から記事詳細取得 |
| `create_local_draft` | 新規下書き Markdown ローカル作成（Contentful 非介入） |
| `update_local_article` | 既存ローカル記事本文の更新（Contentful 非介入） |

**Contentful への書き込みは行いません**。公開・同期は既存の DevIO VSCode 拡張で実施してください。

## 詳細ドキュメント

[nakamura-shuta/devio-mcp README](https://github.com/nakamura-shuta/devio-mcp) を参照。

## ライセンス

MIT
