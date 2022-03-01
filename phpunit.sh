while getopts 'p:m:' flag; do
	case "${flag}" in
		c) cwdiswppslinter=${OPTARG} ;;
		p) plugindirname=${OPTARG} ;;
		m) multisite=${OPTARG} ;;
	esac
done

# Get the absolute path to the plugin we want to check.
if [ "$cwdiswppslinter" = "1" ]; then
	plugindir="$(dirname $(dirname $(dirname $(dirname $(realpath $0) ) ) ) )/$plugindirname"
	wpcontentdir="./../../../../"
	scriptsdir="$(dirname $(realpath $0) ) )"
else
	plugindir="$(dirname $(dirname $(realpath $0) ) )"
	wpcontentdir="$(dirname $(dirname $(dirname $(dirname $(realpath $0) ) ) ) )"
	scriptsdir="$plugindir/wpps-scripts/"
fi

#Go to wp-content directory.
cd $wpcontentdir;

# Make sure that packagejson and composer json exist in wp-content.
if [ ! -f package.json ] || [ ! -f composer.json ]; then
	cd $scriptsdir;
	sh hoister.sh;
	cd $wpcontentdir;
fi

# Make sure that vendor exists in wp-content.
if [ ! -d vendor ]; then
	# Run composer install in wp-content
	composer install;
fi

# Start wp-env
npx wp-env start;

# Run PHPunit inside wp-env, targeting the plugin in question.
if [ "$multisite" = "1" ]; then
	npx wp-env run phpunit "phpunit -c /var/www/html/wp-content/plugins/wp-plugin-sidekick/wp-modules/phpunit/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname";
else
	npx wp-env run phpunit "WP_MULTISITE=1 phpunit -c /var/www/html/wp-content/plugins/wp-plugin-sidekick/wp-modules/phpunit/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname";
fi