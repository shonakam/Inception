#!/usr/bin/env sh

set -eu

WP_DOMAIN="${WP_DOMAIN:-shonakam.42.fr}"
WP_ACCESS_PORT="${WP_HOST_PORT:-80}"

# WP_HOME_URL と WP_SITEURL_URL からポート80を明示的に削除するロジックを追加
if [ "$WP_ACCESS_PORT" = "80" ]; then
    WP_HOME_URL="https://${WP_DOMAIN}"
    WP_SITEURL_URL="https://${WP_DOMAIN}"
else
    WP_HOME_URL="https://${WP_DOMAIN}:${WP_ACCESS_PORT}"
    WP_SITEURL_URL="https://${WP_DOMAIN}:${WP_ACCESS_PORT}"
fi

WP_TITLE="${WP_TITLE:-My Awesome WordPress Site}"
WP_ADMIN_USER="${WP_ADMIN_USER:-wpadmin}"
WP_ADMIN_PASS="${WP_ADMIN_PASS:-password}"
WP_ADMIN_EMAIL="${WP_ADMIN_EMAIL:-admin@example.com}"

DB_NAME="${DB_NAME:-wordpress}"
DB_USER="${DB_USER:-wp_user}"
DB_PASS="${DB_PASS:-wp_pass}"
DB_HOST="${DB_HOST:-mariadb}"

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASS" \
        --dbhost="$DB_HOST" \
        --dbcharset="utf8mb4" \
        --dbcollate="" \
        --allow-root
fi

if ! wp core is-installed --allow-root; then
    echo "WordPressがインストールされていません。インストールを実行します。"
    wp core install \
        --url="$WP_HOME_URL" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    if [ $? -eq 0 ]; then
        echo "WordPress が正常にインストールされました！"
    else
        echo "WordPress のインストール中にエラーが発生しました。スクリプトを終了します。"
        exit 1
    fi
else
    echo "WordPressは既にインストールされています。設定を更新します。"
    wp option update blogname "${WP_TITLE}" --allow-root
    wp option update siteurl "${WP_SITEURL_URL}" --allow-root
    wp option update home "${WP_HOME_URL}" --allow-root
    echo "WordPressサイト設定を更新しました。"
fi

exec php-fpm82 -F -R
