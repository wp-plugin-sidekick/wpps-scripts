#!/bin/bash

# Run setup.
. ./setup.sh

# Duplicate the .wp-env.json boiler, and call it .wp-env.json.
cp wp-env-boiler.json .wp-env.json

# Modify the .wp-env.json file in the wpps-scripts module to contain the path to the plugin in question.
sed -i.bak "s~PATH_TO_PLUGIN_BEING_TESTED~$plugindir~g" .wp-env.json
sed -i.bak "s/REPLACE_WITH_PLUGIN_DIR_NAME/$plugindirname/g" .wp-env.json

# Start wp-env
npx -p @wordpress/env wp-env start

# Run PHPunit inside wp-env, targeting the plugin in question.
npx -p @wordpress/env wp-env run --env-cwd=\"wp-content/wpps-scripts\" tests-wordpress phpunit -c ./phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname

