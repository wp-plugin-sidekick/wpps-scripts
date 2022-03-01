while getopts 'p:n:t:f:' flag; do
	case "${flag}" in
		c) cwdiswppslinter=${OPTARG} ;;
	esac
done

# Get the absolute path to the plugin we want to check.
if [ "$cwdiswppslinter" = "1" ]; then
	wpcontentdir="./../../../../"
else
	wpcontentdir="$(dirname $(dirname $(dirname $(dirname $(realpath $0) ) ) ) )"
fi


#Go to wp-content directory.
cd $wpcontentdir;

# Run npm install in wp-content
npm install;

# Run composer install in wp-content
composer install;

# Go back to original directory.
cd -