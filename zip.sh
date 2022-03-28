#!/bin/bash

plugin_dir="$(dirname "$(dirname "$(realpath "$0")" )" )"
plugin_slug="$(basename "$plugin_dir")"
scripts_dir="$plugin_dir/wpps-scripts/"

build_version=`grep 'Version:' $plugin_dir/$plugin_slug.php | cut -f4 -d' '`
zip_file_name="$plugin_slug.$build_version.zip"
cd "$(dirname "$plugin_dir")"
zip -r "$zip_file_name" "$plugin_slug" -x@"$scripts_dir.zipignore"
