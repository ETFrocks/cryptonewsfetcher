#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $BASE_DIR/.env

# Fetch 3 most popular posts from the front page
echo "Fetching 3 most popular posts from the front page..."
curl -s -H "User-Agent: my-bot" "https://www.reddit.com/top.json?limit=3" | jq -r '.data.children[] | "\(.data.title) - \(.data.url)"'

# Fetch 3 most popular posts from the Bitcoin subreddit
echo "Fetching 3 most popular posts from the Bitcoin subreddit..."
curl -s -H "User-Agent: my-bot" "https://www.reddit.com/r/Bitcoin/top.json?limit=3" | jq -r '.data.children[] | "\(.data.title) - \(.data.url)"'
