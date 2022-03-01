while getopts 'p:n:t:f:' flag; do
	case "${flag}" in
		c) cwdiswppslinter=${OPTARG} ;;
		p) plugindirname=${OPTARG} ;;
		n) namespace=${OPTARG} ;;
		t) textdomain=${OPTARG} ;;
		f) fix=${OPTARG} ;;
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

# Make sure that node_modules exists in wp-content.
if [ ! -d node_modules ] || [ ! -d vendor ]; then
	# Run npm install in wp-content
	npm install;
fi

# Make sure that vendor exists in wp-content.
if [ ! -d vendor ]; then
	# Run composer install in wp-content
	composer install;
fi

# Run the lint command from the wp-content directory.
if [ "$fix" = "1" ]; then
	npm run lint:js "$plugindir"  -- --fix;
else
	npm run lint:js "$plugindir";
fi