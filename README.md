# Taiga Docker

このリポジトリは [Taiga](https://www.taiga.io/) をDocker環境で簡単に実行するためのセットアップを提供します。

## 必要条件

- Docker
- Docker Compose

## 使い方

1. リポジトリをクローンします:

```bash
git clone https://github.com/yourusername/taiga-docker.git
cd taiga-docker
```

2. Docker Composeでサービスを起動します:

```bash
docker-compose up -d
```

3. ブラウザで `http://localhost:8080` にアクセスしてTaigaを使い始めることができます。

## 環境変数

`docker-compose.yml` ファイル内の環境変数を変更してTaigaの設定を調整できます:

- `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`: PostgreSQLデータベースの設定
- `SECRET_KEY`: Djangoのシークレットキー
- `ADMIN_USERNAME`, `ADMIN_PASSWORD`, `ADMIN_EMAIL`: 管理者アカウントの設定
- `DEBUG`: デバッグモードの有効化/無効化
- `PUBLIC_REGISTER_ENABLED`: 公開登録の有効化/無効化

## カスタマイズ

フロントエンド設定を変更するには、`config/conf.json` を編集してください。
バックエンド設定を変更するには、`config/local.py` を編集してください。

## ライセンス

このプロジェクトは [AGPL-3.0 License](https://www.gnu.org/licenses/agpl-3.0.en.html) の下で提供されています。
