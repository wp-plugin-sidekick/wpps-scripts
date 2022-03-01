while getopts 'p:n:t:f:' flag; do
	case "${flag}" in
		c) cwdiswppslinter=${OPTARG} ;;
	esac
done

# Get the path to the wp-content directory
if [ "$cwdiswppslinter" = "1" ]; then
	wpcontentdir="./../../../../"
else
	wpcontentdir="$(dirname $(dirname $(dirname $(dirname $(realpath $0) ) ) ) )"
fi

# Hoist package.json and composer.json to the wp-content directory
cp package.json composer.json composer.lock .wp-env.json $wpcontentdir