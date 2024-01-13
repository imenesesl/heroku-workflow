#!/bin/bash
REPO_NAME_AFTER_FIRST_DASH=$(echo "$GITHUB_REPOSITORY_NAME" | cut -d '-' -f2-)

APP_NAME="${REPO_NAME_AFTER_FIRST_DASH}-pr-${GITHUB_PR_NUMBER}"

heroku apps:destroy --app $APP_NAME --confirm $APP_NAME
