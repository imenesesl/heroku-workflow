#!/bin/bash

cd "$(dirname "$0")"
cd ..

currentVersion=$(grep '"version"' package.json | awk -F '"' '{print $4}')

IFS='.' read -ra VERSION <<< "$currentVersion"
major=${VERSION[0]}
minor=${VERSION[1]}
patch=${VERSION[2]}

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

sed -i '' -e "s/\"version\": \"$currentVersion\"/\"version\": \"$newVersion\"/" package.json

echo "Version updated to $newVersion"
