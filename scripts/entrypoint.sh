#!/bin/bash
set -e

# バックエンド設定
cd /app/taiga-back

# マイグレーションの実行
echo "Running migrations..."
python manage.py migrate --noinput

# スタティックファイルの収集
echo "Collecting static files..."
python manage.py collectstatic --noinput

# スーパーユーザーの作成
if [ -n "${ADMIN_USERNAME}" ] && [ -n "${ADMIN_PASSWORD}" ] && [ -n "${ADMIN_EMAIL}" ]; then
  echo "Creating admin user..."
  python manage.py createsuperuser --username $ADMIN_USERNAME --email $ADMIN_EMAIL --noinput || true
  python -c "
import django
django.setup()
from django.contrib.auth.models import User
user = User.objects.get(username='$ADMIN_USERNAME')
user.set_password('$ADMIN_PASSWORD')
user.save()
"
fi

# コマンドの実行
exec "$@"
