#!/bin/bash

# Run setup.
. ./setup.sh

plugin_slug="$(basename "$plugindir")"

build_version=`grep 'Version:' "$plugindir"/$plugin_slug.php | cut -f4 -d' '`
zip_file_name="$plugin_slug.$build_version.zip"
cd "$(dirname "$plugindir")"

ignore_file="$plugindir/.zipignore"
if [ -f "$ignore_file" ]; then
	ignore_file="$plugindir/.zipignore"
elif [ -f "$plugindir/.distignore" ]; then
	# Ensure ignore file begins and ends with *
	sed "s/^[^*]/*&/g" "$plugindir/.distignore" | sed "s/[^*]$/&*/g" > "$ignore_file"
else
	echo "Error: please add a .zipignore to the root of the plugin"
	exit 1
fi

zip -r "$zip_file_name" "$plugin_slug" -x@"$ignore_file"
mv "$zip_file_name" "$plugindir"