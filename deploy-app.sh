#!/bin/bash

APP_NAME="${GITHUB_REPOSITORY_NAME//\//-}-pr-${GITHUB_PR_NUMBER}"

heroku auth:token
heroku git:remote -a $APP_NAME

cd $GITHUB_WORKSPACE
yarn install
yarn build

git add -A
git commit -m "Updating Ephemeral Environment"
git push heroku HEAD:master
