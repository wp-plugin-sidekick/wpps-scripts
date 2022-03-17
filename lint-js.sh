#!/bin/bash

while getopts 'c:p:n:t:f:' flag; do
	case "${flag}" in
		p) plugindirname=${OPTARG} ;;
		n) namespace=${OPTARG} ;;
		t) textdomain=${OPTARG} ;;
		f) fix=${OPTARG} ;;
	esac
done

plugindir="$(dirname "$(dirname "$(realpath "$0")" )" )"
wpcontentdir="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath $0)" )" )" )" )"
scriptsdir="$plugindir/wpps-scripts/"

#Go to wp-content directory.
cd "$wpcontentdir";
sh "${scriptsdir}/install-script-dependencies.sh"

# Run the lint command from the wp-content directory.
if [ "$fix" = "1" ]; then
	npm run lint:js "$plugindir" -- --config "$scriptsdir.eslintrc" --fix;
else
	npm run lint:js "$plugindir" -- --config "$scriptsdir.eslintrc";
fi
