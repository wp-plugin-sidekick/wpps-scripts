# WPPS Scripts.

Add phpunit, eslint, and stylelint using WordPress Coding Standards to any WordPress plugin by setting up your package.json file like this:

## Your package.json file in your plugin.
```
{
	"name": "your-plugin-name",
	"version": "1.0.0",
	"license": "GPL-2.0",
	"repository": {
		"type": "git",
		"url": "https://github.com/your-repo-url"
	},
	"scripts": {
		"clone-wpps": "git clone https://github.com/wp-plugin-sidekick/wpps-scripts; cd ../; git clone https://github.com/wp-plugin-sidekick/wp-plugin-sidekick;",
		"installation": "npx run clone-wpps; sh wpps-scripts/install-module-dependencies.sh;",
		"dev": "sh wpps-scripts/dev.sh",
		"test:phpunit": "sh .scripts/clone-wpps.sh; sh wpps-scripts/phpunit.sh -p fse-studio;",
		"lint:php": "sh wpps-scripts/phpcs.sh -p fse-studio -n FseStudio -t fse-studio;",
		"lint:php:fix": "sh wpps-scripts/phpcs.sh -p fse-studio -n FseStudio -t fse-studio -f 1;",
		"lint:js": "sh wpps-scripts/lint-js.sh -n FseStudio -t fse-studio",
		"lint:js:fix": "sh wpps-scripts/lint-js.sh -n FseStudio -t fse-studio -f 1;",
		"lint:css": "sh wpps-scripts/lint-css.sh -p fse-studio -n FseStudio -t fse-studio;",
		"lint:css:fix": "sh wpps-scripts/lint-css.sh -p fse-studio -n FseStudio -t fse-studio -f 1;"
	}
}
```

Then run `npm run installation`. This will clone this repo inside your project (temporarily), and make the commands like `npm run lint:php` work on the command line when inside the plugin's directory.

You will likely want to add a gitignore to your project as well that ignores the wpps-scripts directory.