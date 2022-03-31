#!/bin/bash

# Run setup.
. ./setup.sh

# Start wp-env
npx -p @wordpress/env wp-env start

# Run PHPunit inside wp-env, targeting the plugin in question.
if [ "$multisite" = "1" ]; then
	npx -p @wordpress/env wp-env run phpunit "WP_MULTISITE=1 phpunit -c /var/www/html/wp-content/wpps-scripts/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname"
else
	npx -p @wordpress/env wp-env run phpunit "phpunit -c /var/www/html/wp-content/wpps-scripts/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname"
fi
