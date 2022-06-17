#!/bin/bash

while getopts 'p:n:t:f:' flag; do
	case "${flag}" in
		p) plugindirname=${OPTARG} ;;
		n) namespace=${OPTARG} ;;
		t) textdomain=${OPTARG} ;;
		f) fix=${OPTARG} ;;
	esac
done

# Make sure the node version matches.
nodeversion=$( node -v );
if [[ $nodeversion != v14* ]]; then
	echo "Your version of node needs to be v14, but it is set to be "$nodeversion;
	exit 1;
fi

# Get the absolute path to wpcontent
wpcontentdir="$(dirname "$PWD" )"

# If this system supports realpath, override with that.
if [ "$(realpath "$0")" ]; then
	wpcontentdir="$(dirname "$(dirname "$(realpath "$0")" )" )"
fi

# Define the absolute path to the plugin we want to deal with.
plugindir="$wpcontentdir"/plugins/"$plugindirname"

# Install dependencies.
if [ ! -d node_modules ] || [ ! -d vendor ]; then
	npm install
	composer install
fi

# Loop through each wp-module in the plugin, and install their dependencies.
for DIR in "$plugindir"/wp-modules/*; do
	# If this module has a package.json file.
	if [ -f "$DIR"/package.json ]; then
		# Go to the directory of this wp-module.
		cd "$DIR";

		# Run npm install for this module.
		if [ ! -d node_modules ]; then
			npm install;
		fi
		
		cd - > /dev/null
	fi
done
