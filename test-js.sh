#!/bin/bash

# Run setup.
. ./setup.sh

npm run test:js -- --config=jest.config.js --roots "$plugindir"
