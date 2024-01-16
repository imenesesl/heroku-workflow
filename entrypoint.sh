#!/bin/bash

COMMAND=$1

case "$COMMAND" in
  create)
    /app/create-app.sh
    ;;
  destroy)
    /app/destroy-app.sh
    ;;
  deploy)
    /app/deploy-app.sh
    ;;
  *)
    echo "Command not found: $COMMAND"
    echo "use 'create' - 'destroy' - 'deploy'."
    exit 1
    ;;
esac
