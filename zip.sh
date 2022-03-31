#!/bin/bash

# Run setup.
. ./setup.sh

plugin_slug="$(basename "$plugin_dir")"

build_version=`grep 'Version:' $plugin_dir/$plugin_slug.php | cut -f4 -d' '`
zip_file_name="$plugin_slug.$build_version.zip"
cd "$(dirname "$plugin_dir")"

if [ ! -f "$plugin_dir/.zipignore" ]; then
	echo "Error: please add a .zipignore to the root of the plugin"
	exit 1
fi

zip -r "$zip_file_name" "$plugin_slug" -x@"$plugin_dir/.zipignore"
mv "$zip_file_name" "$plugin_dir"