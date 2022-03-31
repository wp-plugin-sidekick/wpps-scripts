#!/bin/bash

# Run setup.
. ./setup.sh

plugin_slug="$(basename "$plugindir")"

build_version=`grep 'Version:' $plugindir/$plugin_slug.php | cut -f4 -d' '`
zip_file_name="$plugin_slug.$build_version.zip"
cd "$(dirname "$plugindir")"

if [ ! -f "$plugindir/.zipignore" ]; then
	echo "Error: please add a .zipignore to the root of the plugin"
	exit 1
fi

zip -r "$zip_file_name" "$plugin_slug" -x@"$plugindir/.zipignore"
mv "$zip_file_name" "$plugindir"