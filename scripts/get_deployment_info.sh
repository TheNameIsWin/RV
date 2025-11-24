#!/bin/bash

# Inputs
REPO="$1"       # TheNameIsWin/RV
PR_NUMBER="$2"  # Provided from workflow
TOKEN="$3"      # GITHUB_TOKEN or PAT

# Fetch PR title
API_URL="https://api.github.com/repos/$REPO/pulls/$PR_NUMBER"

PR_TITLE=$(curl -s -H "Authorization: token $TOKEN" "$API_URL" | jq -r '.title')

if [ "$PR_TITLE" == "null" ] || [ -z "$PR_TITLE" ]; then
  echo "PR title not found"
  exit 1
fi

# Export output (GitHub will read this)
echo "pr_title=$PR_TITLE" >> $GITHUB_OUTPUT
