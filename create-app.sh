#!/bin/bash

APP_NAME="${GITHUB_REPOSITORY_NAME//\//-}-pr-${GITHUB_PR_NUMBER}"

heroku create $APP_NAME
