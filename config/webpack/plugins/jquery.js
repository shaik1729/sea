const webpack = require('webpack')

module.exports = new webpack.ProvidePlugin({
  "$":"jquery",
  "jQuery":"jquery",
  "window.jQuery":"jquery"
});

console.log("In jquery.js");