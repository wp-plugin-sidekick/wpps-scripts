while getopts 'c:' flag; do
	case "${flag}" in
		c) wpcontentdir=${OPTARG} ;;
	esac
done

# Hoist package.json and composer.json to the wp-content directory
cp package.json composer.json composer.lock .wp-env.json "$wpcontentdir"
