#!/bin/bash

# Function to display help message
function display_help() {
    echo "Usage: $0 [option...]"
    echo
    echo "   -h, --help         Display this help message"
    echo "   --front-page       Fetch 3 most popular posts from the front page"
    echo "   --bitcoin          Fetch 3 most popular posts from the Bitcoin subreddit"
    exit 1
}

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $BASE_DIR/.env

USER_AGENT="my-bot"

# Check if help option is passed
for arg in "$@"
do
    case $arg in
        -h|--help)
        display_help
        shift
        ;;
    esac
done

# Fetch 3 most popular posts from the front page
echo "Fetching 3 most popular posts from the front page..."
curl -s -H "User-Agent: $USER_AGENT" "https://www.reddit.com/top.json?limit=3" | jq -r '.data.children[] | "\(.data.title) - \(.data.url)"'

# Fetch 3 most popular posts from the Bitcoin subreddit
echo "Fetching 3 most popular posts from the Bitcoin subreddit..."
curl -s -H "User-Agent: $USER_AGENT" "https://www.reddit.com/r/Bitcoin/top.json?limit=3" | jq -r '.data.children[] | "\(.data.title) - \(.data.url)"'
