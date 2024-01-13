#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Destroying Ephemeral Environment${NC}"

APP_NAME="${GITHUB_REPOSITORY_NAME}-pr-${GITHUB_PR_NUMBER}"

heroku apps:destroy --app $APP_NAME --confirm $APP_NAME

echo -e "${GREEN}Completed.${NC}"
