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

# Default action is to fetch from both front page and Bitcoin subreddit
FETCH_FRONT_PAGE=true
FETCH_BITCOIN=true

# Check if specific option is passed
for arg in "$@"
do
    case $arg in
        -h|--help)
        display_help
        shift
        ;;
        --front-page)
        FETCH_BITCOIN=false
        shift
        ;;
        --bitcoin)
        FETCH_FRONT_PAGE=false
        shift
        ;;
        *)
        echo "Invalid option: $arg"
        display_help
        ;;
    esac
done

# Fetch 3 most popular posts from the front page
if $FETCH_FRONT_PAGE; then
    echo "Fetching 3 most popular posts from the front page..."
    curl -s -H "User-Agent: $USER_AGENT" "https://www.reddit.com/top.json?limit=3" | jq -r '.data.children[] | "\(.data.title) - \(.data.url)"'
fi

# Fetch 3 most popular posts from the Bitcoin subreddit
if $FETCH_BITCOIN; then
    echo "Fetching 3 most popular posts from the Bitcoin subreddit..."
    curl -s -H "User-Agent: $USER_AGENT" "https://www.reddit.com/r/Bitcoin/top.json?limit=3" | jq -r '.data.children[] | "\(.data.title) - \(.data.url)"'
fi
