#!/bin/bash
set -e

WP_DIR="/var/www/html"

if [ ! -f "$WP_DIR/wp-config.php" ]; then
    echo "⚙️ Génération de wp-config.php..."

    cp "$WP_DIR/wp-config-sample.php" "$WP_DIR/wp-config.php"
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" "$WP_DIR/wp-config.php"
    sed -i "s/username_here/${MYSQL_USER}/" "$WP_DIR/wp-config.php"
    sed -i "s/password_here/${MYSQL_PASSWORD}/" "$WP_DIR/wp-config.php"
    sed -i "s/localhost/mariadb/" "$WP_DIR/wp-config.php"
fi

until mysql -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;" "${MYSQL_DATABASE}" --silent > /dev/null 2>&1; do
    echo "En attente de MariaDB..."
    sleep 1
done

if ! wp core is-installed --path="$WP_DIR" --allow-root; then
    echo "Installation de WordPress..."

    wp core install \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path="$WP_DIR" \
        --allow-root

    echo "Création de l'utilisateur evaluator..."
    wp user create "${WP_EVAL_USER}" "${WP_EVAL_EMAIL}" \
        --role=author \
        --user_pass="${WP_EVAL_PASSWORD}" \
        --path="$WP_DIR" \
        --allow-root
else
    echo "WordPress déjà installé"
fi

chown -R www-data:www-data "$WP_DIR"

exec php-fpm7.4 -F

