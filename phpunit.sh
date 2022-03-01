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
else
	plugindir="$(dirname $(dirname $(realpath $0) ) )"
	wpcontentdir="$(dirname $(dirname $(dirname $(dirname $(realpath $0) ) ) ) )"
fi

#Go to wp-content directory.
cd $wpcontentdir;

# Make sure that packagejson and composer json exist in wp-content.
if [ ! -f package.json ] || [ ! -f composer.json ]; then
	cd -;
	sh hoister.sh;
	cd $wpcontentdir;
fi

# Make sure that node_modules and vendor directories exist in wp-content.
if [ ! -d node_modules ] || [ ! -d vendor ]; then
	cd -;
	sh install-linters.sh;
	cd $wpcontentdir;
fi

# Start wp-env
npx wp-env start;

# Run PHPunit inside wp-env, targeting the plugin in question.
if [ "$multisite" = "1" ]; then
	npx wp-env run phpunit "phpunit -c /var/www/html/wp-content/plugins/wp-plugin-sidekick/wp-modules/phpunit/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname";
else
	npx wp-env run phpunit "WP_MULTISITE=1 phpunit -c /var/www/html/wp-content/plugins/wp-plugin-sidekick/wp-modules/phpunit/phpunit.xml.dist /var/www/html/wp-content/plugins/$plugindirname";
fi