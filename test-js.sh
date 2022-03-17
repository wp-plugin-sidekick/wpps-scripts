#!/bin/bash

plugindir="$(dirname "$(dirname "$(realpath "$0")" )" )"
wpcontentdir="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath $0)" )" )" )" )"
scriptsdir="${plugindir}/wpps-scripts/"

cd "$wpcontentdir"
sh "${scriptsdir}/install-script-dependencies.sh"

npm run test:js $plugindir
