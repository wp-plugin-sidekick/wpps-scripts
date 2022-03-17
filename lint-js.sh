while getopts 'c:p:n:t:f:' flag; do
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
	scriptsdir="$(dirname $(realpath $0) ) )"
else
	plugindir="$(dirname "$(dirname "$(realpath "$0")" )" )"
	wpcontentdir="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath $0)" )" )" )" )"
	scriptsdir="$plugindir/wpps-scripts/"
fi

./install-script-dependencies.sh

#Go to wp-content directory.
cd "$wpcontentdir";

# Run the lint command from the wp-content directory.
if [ "$fix" = "1" ]; then
	npm run lint:js "$plugindir" -- --config "$scriptsdir.eslintrc" --fix;
else
	npm run lint:js "$plugindir" -- --config "$scriptsdir.eslintrc";
fi
