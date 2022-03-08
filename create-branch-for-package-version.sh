#!/bin/bash
set -euo pipefail

# Get arguments
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "options:"
      echo "-h, --help                              show brief help"
      echo "-p, --package                           package name (e.g. 'react-native-video')"
      echo "-u, --user                              GitHub user of the repository (e.g. 'wordpress-mobile')"
      echo "-t, --tag                               Git tag (i.e. package version 'X.Y.Z')"
      exit 0
      ;;
    -p|--package*)
      shift
      PACKAGE_NAME=$1
      shift
      ;;
    -u|--user*)
      shift
      GITHUB_USER=$1
      shift
      ;;
    -t|--tag*)
      shift
      GIT_TAG=$1
      shift
      ;;
    *)
      break
      ;;
  esac
done

if [[ -z ${PACKAGE_NAME:-} ]]; then
    echo "A package name must be provided (e.g. 'react-native-video')."
    exit 1
fi
if [[ -z ${GITHUB_USER:-} ]]; then
    echo "A GitHub user must be provided (e.g. 'wordpress-mobile')."
    exit 1
fi
if [[ -z ${GIT_TAG:-} ]]; then
    echo "A Git tag must be provided (i.e. package version 'X.Y.Z')."
    exit 1
fi

BRANCH_NAME="$PACKAGE_NAME-$GIT_TAG"

read -r -p "Are you sure that you want to create branch '${BRANCH_NAME:-}' and include changes from tag '${GIT_TAG:-}' of '${GITHUB_USER:-}/${PACKAGE_NAME:-}' repository? [y/N] " PROMPT_RESPONSE
if [[ $PROMPT_RESPONSE != "y" ]]; then
    exit 1
fi

echo "Creating '$BRANCH_NAME' branch"
git switch -c "$BRANCH_NAME"

rm -rf "$PACKAGE_NAME"

echo "Adding '$PACKAGE_NAME' subtree"
git subtree add --prefix "$PACKAGE_NAME" "git@github.com:$GITHUB_USER/$PACKAGE_NAME.git" $GIT_TAG --squash