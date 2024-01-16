#!/bin/bash

# Check if the path to package.json is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 path/to/package.json"
    exit 1
fi

# Assign the first argument as the path to package.json
PACKAGE_JSON_PATH="$1"

# Get the current version from package.json
currentVersion=$(grep '"version"' "$PACKAGE_JSON_PATH" | awk -F '"' '{print $4}')

# Split the version into major, minor, and patch
IFS='.' read -ra VERSION <<< "$currentVersion"
major=${VERSION[0]}
minor=${VERSION[1]}
patch=${VERSION[2]}

# Function to increment version
increment_version() {
    if [[ $1 == "patch" ]]; then
        patch=$((patch+1))
    elif [[ $1 == "minor" ]]; then
        minor=$((minor+1))
        patch=0
    elif [[ $1 == "major" ]]; then
        major=$((major+1))
        minor=0
        patch=0
    fi

    echo "${major}.${minor}.${patch}"
}

# Menu to select the type of increment
echo "Select the type of increment:"
select option in "fix - hotfix" "feature" "core"; do
    case $option in
        "fix - hotfix")
            newVersion=$(increment_version patch)
            break
            ;;
        "feature")
            newVersion=$(increment_version minor)
            break
            ;;
        "core")
            newVersion=$(increment_version major)
            break
            ;;
        *) echo "Invalid option";;
    esac
done

# Update the package.json file
sed -i '' -e "s/\"version\": \"$currentVersion\"/\"version\": \"$newVersion\"/" "$PACKAGE_JSON_PATH"

echo "Version updated to $newVersion"