const path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  //entry: './app/javascripts/app.js',
  entry: {
    app: './app/javascripts/app.js', 
    driver: './app/javascripts/driver.js',
    supplier: './app/javascripts/supplier.js',
  },
  output: {
    path: __dirname + '/dist',
    filename: '[name].js'
  },
  plugins: [
    // Copy our app's index.html to the build folder.
    new HtmlWebpackPlugin({  // Also generate a driver.html
      filename: 'index.html',
      chunks:['app'],
      template: 'app/index.html'
    }),
    new HtmlWebpackPlugin({  // Also generate a driver.html
      filename: 'driver.html',
      chunks:['driver'],
      template: 'app/driver.html'
    }),
    new HtmlWebpackPlugin({  // Also generate a driver.html
      filename: 'supplier.html',
      chunks:['supplier'],
      template: 'app/supplier.html'
    }),
  ],
  module: {
    rules: [
      {
       test: /\.css$/,
       use: [ 'style-loader', 'css-loader' ]
      }
    ],
    loaders: [
      { test: /\.json$/, use: 'json-loader' },
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015'],
          plugins: ['transform-runtime']
        }
      }
    ]
  }
}
