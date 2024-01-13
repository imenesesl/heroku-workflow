#!/bin/bash

APP_NAME="${GITHUB_REPOSITORY_NAME//\//-}-pr-${GITHUB_PR_NUMBER}"

heroku apps:destroy --app $APP_NAME --confirm $APP_NAME
