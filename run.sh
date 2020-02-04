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
touch src/main.js 
touch dist/index.html
# 4. commit and push to origin
git add .
git commit -m "Setup project"
git push origin develop
git push origin setup


