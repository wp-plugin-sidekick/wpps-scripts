// Copied from https://jestjs.io/docs/code-transformation#examples
module.exports = {
  transform: {
    '\\.(jpg|jpeg|png|svg)$':
      '<rootDir>/fileTransformer.js',
  },
};
