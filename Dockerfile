FROM python:3.9-slim

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    postgresql-client \
    libpq-dev \
    nginx \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /app

# Taiga バックエンドのクローン
RUN git clone https://github.com/taigaio/taiga-back.git /app/taiga-back

# Taiga フロントエンドのクローン
RUN git clone https://github.com/taigaio/taiga-front.git /app/taiga-front

# バックエンドの依存関係をインストール
WORKDIR /app/taiga-back
RUN pip install -r requirements.txt

# フロントエンドのセットアップ
WORKDIR /app/taiga-front
RUN apt-get update && apt-get install -y nodejs npm \
    && npm install \
    && npm run build \
    && apt-get remove -y nodejs npm \
    && apt-get autoremove -y

# コンフィグファイルをコピー
COPY config/local.py /app/taiga-back/settings/local.py
COPY config/conf.json /app/taiga-front/dist/conf.json
COPY config/nginx.conf /etc/nginx/sites-available/taiga
COPY config/supervisord.conf /etc/supervisor/conf.d/taiga.conf

# Nginx 設定の有効化
RUN ln -s /etc/nginx/sites-available/taiga /etc/nginx/sites-enabled/taiga \
    && rm /etc/nginx/sites-enabled/default

# ポートを公開
EXPOSE 80 8000

# 起動スクリプトをコピー
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# エントリーポイントを設定
ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
