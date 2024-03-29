#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Creation Ephemeral Environment${NC}"
echo -e "${YELLOW}Verifying the existence of: ${HEROKU_APP_NAME}${NC}"

if heroku apps:info $HEROKU_APP_NAME &> /dev/null; then
    echo -e "${GREEN}Ephemeral Environment ${HEROKU_APP_NAME} created.${NC}"
else
    echo -e "${YELLOW}Creating new Ephemeral Environment: ${HEROKU_APP_NAME}${NC}"
    heroku create $HEROKU_APP_NAME
fi

echo -e "${GREEN}Completed.${NC}"
