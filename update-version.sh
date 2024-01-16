#!/bin/bash

# Check if both arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 path/to/package.json [fix|hotfix|feature|core]"
    exit 1
fi

# Assign the first argument as the path to package.json
PACKAGE_JSON_PATH="$1"

# Assign the second argument as the version increment type
INCREMENT_TYPE="$2"

# Get the current version from package.json
currentVersion=$(grep '"version"' "$PACKAGE_JSON_PATH" | awk -F '"' '{print $4}')

# Split the version into major, minor, and patch
IFS='.' read -ra VERSION <<< "$currentVersion"
major=${VERSION[0]}
minor=${VERSION[1]}
patch=${VERSION[2]}

# Function to increment version
increment_version() {
    if [[ $1 == "fix" || $1 == "hotfix" ]]; then
        patch=$((patch+1))
    elif [[ $1 == "feature" ]]; then
        minor=$((minor+1))
        patch=0
    elif [[ $1 == "core" ]]; then
        major=$((major+1))
        minor=0
        patch=0
    fi

    echo "${major}.${minor}.${patch}"
}

# Increment the version based on the type
newVersion=$(increment_version "$INCREMENT_TYPE")

# Update the package.json file
sed -i -e "s/\"version\": \"$currentVersion\"/\"version\": \"$newVersion\"/" "$PACKAGE_JSON_PATH"

echo "Version updated to $newVersion"