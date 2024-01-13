#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

APP_NAME="${GITHUB_REPOSITORY_NAME//\//-}-pr-${GITHUB_PR_NUMBER}"

echo -e "${YELLOW}Creation Ephemeral Environment${NC}"
echo -e "${YELLOW}Verifying the existence of: ${APP_NAME}${NC}"

if heroku apps:info $APP_NAME &> /dev/null; then
    echo -e "${GREEN}Ephemeral Environment ${APP_NAME} created.${NC}"
else
    echo -e "${YELLOW}Creating new Ephemeral Environment: ${APP_NAME}${NC}"
    heroku create $APP_NAME
    heroku buildpacks:add heroku/nodejs -a $APP_NAME
    heroku buildpacks:add https://github.com/heroku/heroku-buildpack-static.git -a $APP_NAME
fi

echo -e "${GREEN}Completed.${NC}"
