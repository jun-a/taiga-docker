from .common import *

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.getenv('POSTGRES_DB', 'taiga'),
        'USER': os.getenv('POSTGRES_USER', 'taiga'),
        'PASSWORD': os.getenv('POSTGRES_PASSWORD', 'taiga'),
        'HOST': os.getenv('POSTGRES_HOST', 'postgres'),
        'PORT': os.getenv('POSTGRES_PORT', '5432'),
    }
}

MEDIA_ROOT = '/app/taiga-back/media'
STATIC_ROOT = '/app/taiga-back/static'

SECRET_KEY = os.getenv('SECRET_KEY', 'taiga-secret-key')
DEBUG = os.getenv('DEBUG', 'False').lower() == 'true'

ALLOWED_HOSTS = ['*']

PUBLIC_REGISTER_ENABLED = os.getenv('PUBLIC_REGISTER_ENABLED', 'True').lower() == 'true'
