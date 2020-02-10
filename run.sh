#!/bin/bash

# 0. Create Development and setup branch branch
git checkout -b develop
git checkout -b setup
# 1. Init npm
npm init -y
# 2. Add support for linters
npx install-peerdeps --dev eslint-config-airbnb
npm i -D stylelint prettier
npm i -D stylelint-config-standard
# 3. Create Directories and default files
mkdir src
mkdir dist
touch src/index.js 
# 4. commit and push to origin
git add .
git commit -m "Setup project directories"

# 5. Add Webpack
npm install webpack webpack-cli --save-dev

touch webpack.config.js

git add .
git commit -m "Added webpack & config file"

# 6. Add css support
npm install --save-dev style-loader css-loader
touch src/style.css

echo "
.hello {
  color: red;
}
" >> src/style.css

git add .
git commit -m "Add css loader to webpack"

# 7. Add Images support
npm install --save-dev file-loader
git add .
git commit -m "Add images loader to webpack"

# 8. Add data support
npm install --save-dev csv-loader xml-loader

git add .
git commit -m "Add data loader to webpack"

# 10. Manage index.html with webpack

touch src/print.js

echo "
export default function printMe() {
  console.log('I get called from print.js!');
}
" >> src/print.js

# 10.1 

npm install --save-dev html-webpack-plugin
git add .
git commit -m "Setting up HtmlWebpackPlugin"

# 10.2 

npm install --save-dev clean-webpack-plugin
git add .
git commit -m "Cleaning up the dist folder"

# 11. Add config to webpack for asset mamgement 
echo "
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

module.exports = {
  entry: {
    app: './src/index.js',
    print: './src/print.js',
  },
  plugins: [
    new CleanWebpackPlugin(),
    new HtmlWebpackPlugin({
      title: 'Setup Webpack App',
    }),
  ],
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
  module: {
  rules: [
    {
      test: /\.css$/,
      use: [
        'style-loader',
        'css-loader',
      ],
    },
    {
      test: /\.(png|svg|jpg|gif)$/,
      use: [
        'file-loader',
      ],
    },
    {
      test: /\.(woff|woff2|eot|ttf|otf)$/,
      use: [
        'file-loader',
      ],
    },
    {
      test: /\.(csv|tsv)$/,
      use: [
        'csv-loader',
      ],
    },
    {
      test: /\.xml$/,
      use: [
        'xml-loader',
      ],
    },
  ],
},
};" >>webpack.config.js

git add .
git commit -m "Add webpack config"

# 11.1 add loadash
npm install --save lodash

git add .
git commit -m "Add lodash"


# 12. Add test code in src/index.js 

echo "
 import _ from 'lodash';
 import printMe from './print.js';

  function component() {
    const element = document.createElement('div');
   const btn = document.createElement('button');

    element.innerHTML = _.join(['Hello', 'webpack'], ' ');

   btn.innerHTML = 'Click me and check the console!';
   btn.onclick = printMe;

   element.appendChild(btn);

    return element;
  }

  document.body.appendChild(component());
" >> src/index.js

git add .
git commit -m "Add testcode in index.html"



# Build with new config
npx webpack --config webpack.config.js

git add .
git commit -m "[feat] first run of config with webpack"


git checkout develop
git merge setup


