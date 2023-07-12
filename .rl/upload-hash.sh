#!/bin/bash
# This bash version requires git, curl and jq.

set -e
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source $SCRIPTPATH/config.sh

COMMENT=$(git log -n 1 --format=oneline | jq -Rsa .)

echo "comment to https://github.com/repos/$OWNER/$REPO/issues/$ISSUE_NUMBER"
echo "content: ${COMMENT}"
read -e -p "continue? [y/n]" yn
if [[ $yn == y ]]; then
    curl -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/$OWNER/$REPO/issues/$ISSUE_NUMBER/comments \
    -d "{\"body\": ${COMMENT}}"
fi
