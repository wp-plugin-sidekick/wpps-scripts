while getopts 'c:p:m:' flag; do
	case "${flag}" in
		c) cwdiswppslinter=${OPTARG} ;;
		p) plugindirname=${OPTARG} ;;
		m) multisite=${OPTARG} ;;
	esac
done

# Get the absolute path to the plugin we want to check.
if [ "$cwdiswppslinter" = "1" ]; then
	plugindir="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath "$0")" )" )" )" )/$plugindirname"
	wpcontentdir="./../../../../"
	scriptsdir="$(dirname "$(realpath "$0")" )/"
else
	plugindir="$(dirname "$(dirname "$(realpath "$0")" )" )"
	wpcontentdir="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath $0)" )" )" )" )"
	scriptsdir="$plugindir/wpps-scripts/"
fi

#Go to wp-content directory.
cd "$wpcontentdir";
sh "${scriptsdir}/install-script-dependencies.sh" -c $cwdiswppslinter

# Start wp-env
npx -p @wordpress/env wp-env start

# Run PHPunit inside wp-env, targeting the plugin in question.
if [ "$multisite" = "1" ]; then
	npx -p @wordpress/env wp-env run phpunit "WP_MULTISITE=1 phpunit -c /var/www/html/wp-content/plugins/wp-plugin-sidekick/wp-modules/phpunit/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname"
else
	npx -p @wordpress/env wp-env run phpunit "phpunit -c /var/www/html/wp-content/plugins/wp-plugin-sidekick/wp-modules/phpunit/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname"
fi
