#!/bin/bash

# Determine the script's directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load API keys from .env file
source $BASE_DIR/.env

# Function to fetch news from Alphavantage
fetch_alphavantage() {
    if [ -z "$API_KEY_ALPHAVANTAGE" ]; then
        echo "API_KEY_ALPHAVANTAGE is empty. Skipping fetch from Alphavantage."
        return
    fi
    echo -e "\e[1mFetching news from \e[0;35mAlphavantage\e[0m...\n"
    RESPONSE=$(curl -s "https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=CRYPTO:BTC&time_from=$(date -u -d '1 day ago' +%Y%m%dT%H%M)&apikey=$API_KEY_ALPHAVANTAGE")
    if echo "$RESPONSE" | grep -q "Our standard API rate limit is 25 requests per day. Please subscribe to any of the premium plans"; then
        echo -e "You can't use the free API for this, you need to pay for their minimum subscription. Remove the value in API_KEY_ALPHAVANTAGE in .env file if you don't want to use it.\n"
        return
    fi
    echo "$RESPONSE" | jq -r '.feed[] | .title, .url, ""' | head -n 9
}

# Function to fetch news from NewsAPI
fetch_newsapi() {
    if [ -z "$API_KEY_NEWSAPI_ORG" ]; then
        echo "API_KEY_NEWSAPI_ORG is empty. Skipping fetch from NewsAPI."
        return
    fi
    echo -e "\e[1mFetching news from \e[0;35mNewsAPI\e[0m...\n"
    curl -s "https://newsapi.org/v2/everything?q=bitcoin%20OR%20ethereum%20OR%20uniswap%20OR%20coinbase%20OR%20usd&language=en&sortBy=publishedAt&pageSize=3&apiKey=$API_KEY_NEWSAPI_ORG" | jq -r '.articles[] | .title, .url, ""'
}

# Function to fetch news from GNews
fetch_gnews() {
    if [ -z "$API_KEY_GNEWS" ]; then
        echo "API_KEY_GNEWS is empty. Skipping fetch from GNews."
        return
    fi
    echo -e "\e[1mFetching news from \e[0;35mGNews\e[0m...\n"
    curl -s "https://gnews.io/api/v4/search?q=bitcoin%20OR%20ethereum%20OR%20uniswap%20OR%20coinbase%20OR%20usd&lang=en&max=3&token=$API_KEY_GNEWS" | jq -r '.articles[] | .title, .url, ""'
}

# Function to display usage
usage() {
    echo "Usage: $0 [-h|--help]"
    echo
    echo "Fetches the latest news from different sources using their RSS feeds or APIs and displays them in the terminal."
    echo "Fetches 3 latest news about bitcoin, coinbase, us dollar, ethereum, uniswap from each API."
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message and exit."
}

# Parse command-line options
while (( "$#" )); do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Error: Invalid option '$1'"
            usage
            exit 1
            ;;
    esac
done

# Fetch news
fetch_alphavantage
fetch_newsapi
fetch_gnews
