#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

APP_NAME="${GITHUB_REPOSITORY_NAME//\//-}-pr-${GITHUB_PR_NUMBER}"

echo -e "${YELLOW}Updating Ephemeral Environment: ${APP_NAME} ${NC}"

heroku auth:token
heroku git:remote -a $APP_NAME

cd $GITHUB_WORKSPACE

echo -e "${YELLOW}Installing dependencies${NC}"
yarn install

echo -e "${YELLOW}Building app${NC}"
yarn build

git add -A
git commit -m "Updating Ephemeral Environment"
git push heroku HEAD:master

echo -e "${YELLOW}Ephemeral Environment Updated${NC}"
echo -e "${GREEN}Completed.${NC}"
