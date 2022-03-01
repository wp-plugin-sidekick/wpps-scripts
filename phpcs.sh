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

# Make sure that node_modules and vendor directories exist in wp-content.
if [ ! -d node_modules ] || [ ! -d vendor ]; then
	cd -;
	sh install-linters.sh;
	cd $wpcontentdir;
fi

# Copy the phpcs.xml file from the linter module to wp-content.
cp ./plugins/wp-plugin-sidekick/wp-modules/linter/phpcs.xml ./

# Modify the phpcs.xml file in the linter module to contain the namespace and text domain of the plugin in question.
sed -i.bak "s/MadeWithWPPS/$namespace/g" phpcs.xml
sed -i.bak "s/madewithwpps/$textdomain/g" phpcs.xml

# Run the phpcs command from the wp-content directory.
if [ "$fix" = "1" ]; then
	./vendor/bin/phpcbf -q $plugindir;
	./vendor/bin/phpcs -q $plugindir;
else
	./vendor/bin/phpcs -q $plugindir;
fi