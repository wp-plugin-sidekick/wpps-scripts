// Copied from https://jestjs.io/docs/code-transformation#examples
module.exports = {
  ...require('@wordpress/scripts/config/jest-unit.config'),
  transform: {
    '\\.(jpg|jpeg|png|svg)$':
      '<rootDir>/fileTransformer.js',
  },
};
