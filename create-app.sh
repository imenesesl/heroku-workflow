#!/bin/bash

APP_NAME="${GITHUB_REPOSITORY_NAME//\//-}-pr-${GITHUB_PR_NUMBER}"

if heroku apps:info $APP_NAME &> /dev/null; then
    echo "environment $APP_NAME created."
else
    heroku create $APP_NAME
fi
