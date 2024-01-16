#!/bin/bash

COMMAND=$1

case "$COMMAND" in
  create)
    /app/create-app.sh
    ;;
  destroy)
    /app/destroy-app.sh
    ;;
  update-version)
    /app/update-version.sh
    ;;
  *)
    echo "Command not found: $COMMAND"
    echo "use 'create' - 'destroy' - 'update-version'."
    exit 1
    ;;
esac
