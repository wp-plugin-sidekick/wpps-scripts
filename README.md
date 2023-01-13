# WPPS Scripts.

Run phpunit, eslint, and stylelint using WordPress Coding Standards for any WordPress plugin by setting up your package.json file like this:

## Your package.json file in your plugin.
```
{
	"name": "your-plugin-name",
	"version": "1.0.0",
	"license": "GPL-2.0",
	"repository": {
		"type": "git",
		"url": "your-repo-url-here"
	},
	"wpps_options": "-n YourPluginNamespace -t your-plugin-textdomain",
	"scripts": {
		"preinstall": "if [ ! -d ../../wpps-scripts ]; then git clone https://github.com/wp-plugin-sidekick/wpps-scripts ../../wpps-scripts; else cd ../../wpps-scripts && git reset --hard && git checkout main && git pull origin main;fi;",
		"dev": "cd ../../wpps-scripts; sh dev.sh $npm_package_wpps_options -p $OLDPWD;",
		"build": "cd ../../wpps-scripts; sh build.sh $npm_package_wpps_options -p $OLDPWD;",
		"test:phpunit": "cd ../../wpps-scripts; sh phpunit.sh $npm_package_wpps_options -p $OLDPWD;",
		"lint:php": "cd ../../wpps-scripts; sh phpcs.sh $npm_package_wpps_options -p $OLDPWD;",
		"lint:php:fix": "cd ../../wpps-scripts; sh phpcs.sh $npm_package_wpps_options -p $OLDPWD -f 1;",
		"lint:js": "cd ../../wpps-scripts; sh lint-js.sh $npm_package_wpps_options -p $OLDPWD",
		"lint:js:fix": "cd ../../wpps-scripts; sh lint-js.sh $npm_package_wpps_options -p $OLDPWD -f 1;",
		"lint:css": "cd ../../wpps-scripts; sh lint-css.sh $npm_package_wpps_options -p $OLDPWD;",
		"lint:css:fix": "cd ../../wpps-scripts; sh lint-css.sh $npm_package_wpps_options -p $OLDPWD -f 1;",
		"test:js": "cd ../../wpps-scripts; sh test-js.sh $npm_package_wpps_options -p $OLDPWD;",
		"zip": "cd ../../wpps-scripts; sh zip.sh $npm_package_wpps_options -p $OLDPWD;"
	}
}
```
That's it!

In the example package.json file above, simply replace these strings:

- `your-plugin-name` - A slug for your plugin
- `YourPluginNamespace` - The unique namespace used for your plugin (Will be enforced as function/class prefix in WordPress Coding Standards)
- `your-plugin-textdomain` - The text domain to use for your plugin (Will be enforced by WordPress Coding Standards)

Then inside your plugin, run `npm run install`. This will clone this repo inside your local wp-content directory, and make the commands like `npm run lint:php` work on the command line when inside the plugin's directory.