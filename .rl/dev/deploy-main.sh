#!/bin/bash

# set -e
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

COMMENT=$(git log -n 1 --format=oneline | jq -Rsa .)

echo "====> deploying to main"
rm -rf /tmp/recordlearning
mkdir -p /tmp/recordlearning
cp -rp $SCRIPTPATH/../../* /tmp/recordlearning/
cp -rp $SCRIPTPATH/../../.rl /tmp/recordlearning/
cd /tmp/recordlearning && \
    git init && git branch -M main && \
    git add --all && \
    git commit -m "${COMMENT}

deployed on $(date) by $(git config --get user.name)" && \
    git remote add origin git@github.com:am009/RecordLearning.git && \
    git push -f origin main
