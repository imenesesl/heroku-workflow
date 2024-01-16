#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Destroying Ephemeral Environment${NC}"

heroku apps:destroy --app $HEROKU_APP_NAME --confirm $HEROKU_APP_NAME

echo -e "${GREEN}Completed.${NC}"
