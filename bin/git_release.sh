#!/bin/bash

# Check if the argument is provided
if [ -z "$1" ]; then
  echo "Please provide an argument: major, minor, or fix"
  exit 1
fi

# Read the current version from Cargo.toml
VERSION=$(grep '^version =' Cargo.toml | awk -F'=' '{print $2}' | tr -d ' "')

# Split the version into major, minor, and fix components
IFS='.' read -r -a VERSION_PARTS <<< "$VERSION"
MAJOR="${VERSION_PARTS[0]}"
MINOR="${VERSION_PARTS[1]}"
FIX="${VERSION_PARTS[2]}"

# Increment the version based on the argument
case "$1" in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    FIX=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    FIX=0
    ;;
  fix)
    FIX=$((FIX + 1))
    ;;
  *)
    echo "Invalid argument. Please provide one of: major, minor, or fix"
    exit 1
    ;;
esac

# Create the new version string
NEW_VERSION="$MAJOR.$MINOR.$FIX"

# Update the version in Cargo.toml
# Linux
# sed -i "s/^version = \"$VERSION\"/version = \"$NEW_VERSION\"/" Cargo.toml
# Mac
sed -i '' "s/^version = \"$VERSION\"/version = \"$NEW_VERSION\"/" Cargo.toml

# Cargo lock
cargo build

# Commit new tag change
git add .
git commit -m "[release] v$NEW_VERSION"

# Create the Git tag
git tag -a "v$NEW_VERSION" -m "Release version v$NEW_VERSION"

# Output the new version
echo "Version updated to $NEW_VERSION"
