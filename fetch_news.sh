#!/bin/bash

# Determine the script's directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load API keys from .env file
source $BASE_DIR/.env

# Define a list of crypto keywords
declare -A CRYPTO_KEYWORDS=(["bitcoin"]="btc" ["ethereum"]="eth" ["uniswap"]="uni" ["ripple"]="xrp" ["cardano"]="ada" ["polkadot"]="dot" ["litecoin"]="ltc" ["chainlink"]="link" ["bitcoin cash"]="bch" ["stellar"]="xlm" ["usd coin"]="usdc" ["wrapped bitcoin"]="wbtc" ["aave"]="aave" ["cosmos"]="atom" ["monero"]="xmr" ["eos"]="eos" ["tron"]="trx" ["tezos"]="xtz" ["neo"]="neo" ["nem"]="xem")

# Define a list of stocks keywords
declare -A STOCKS_KEYWORDS=(["coinbase"]="coin" ["paypal"]="pypl" ["microsoft"]="msft" ["apple"]="aapl" ["amazon"]="amzn" ["google"]="googl" ["facebook"]="fb" ["tesla"]="tsla" ["nvidia"]="nvda" ["adobe"]="adbe" ["netflix"]="nflx" ["intel"]="intc" ["cisco"]="csco" ["oracle"]="orcl" ["ibm"]="ibm" ["salesforce"]="crm" ["zoom"]="zm" ["shopify"]="shop" ["uber"]="uber" ["lyft"]="lyft" ["slack"]="work" ["twitter"]="twtr" ["square"]="sq" ["atlassian"]="team" ["servicenow"]="now" ["splunk"]="splk" ["fortinet"]="ftnt" ["akamai"]="akam")

# Define a list of forex keywords
FOREX_KEYWORDS=("eur" "usd" "jpy" "chf" "gbp" "aud" "cad" "nzd" "sek" "nok" "mxn" "sgd" "hkd" "krw" "try" "rub" "inr" "brl" "zar" "myr" "idr" "thb" "vnd" "php" "egp" "clp" "cop" "ars" "pkr" "bdt")

# Function to display usage
usage() {
    echo "Usage: $0 [-h|--help] keyword"
    echo
    echo "Fetches the latest news from different sources using their RSS feeds or APIs and displays them in the terminal."
    echo "Fetches 3 latest news about the given keyword from each API."
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message and exit."
}

# Function to fetch news from Alphavantage
fetch_alphavantage() {
    local keyword=$1

    # Set default keyword if none provided
    if [[ "$keyword" == "bitcoin%20OR%20ethereum%20OR%20uniswap%20OR%20coinbase%20OR%20usd" ]]; then
        keyword="bitcoin"
    fi

    if [ -z "$API_KEY_ALPHAVANTAGE" ]; then
        echo "API_KEY_ALPHAVANTAGE is empty. Skipping fetch from Alphavantage."
        return
    fi

    # Check if the keyword is already a ticker symbol
    if [[ " ${CRYPTO_KEYWORDS[@]} " =~ " ${keyword} " ]]; then
        keyword="CRYPTO:${keyword^^}"
    elif [[ " ${STOCKS_KEYWORDS[@]} " =~ " ${keyword} " ]]; then
        keyword="STOCKS:${keyword^^}"
    elif [[ " ${FOREX_KEYWORDS[@]} " =~ " ${keyword} " ]]; then
        keyword="FOREX:${keyword^^}"
    # If not, look it up in the associative array
    elif [[ -n "${CRYPTO_KEYWORDS[$keyword]}" ]]; then
        keyword="CRYPTO:${CRYPTO_KEYWORDS[$keyword]^^}"
    elif [[ -n "${STOCKS_KEYWORDS[$keyword]}" ]]; then
        keyword="STOCKS:${STOCKS_KEYWORDS[$keyword]^^}"
    fi
    echo -e "\e[1mFetching news from \e[0;35mAlphavantage\e[0m...\n"
    echo "QUERY: https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=${keyword}&time_from=$(date -u -d '1 day ago' +%Y%m%dT%H%M)&apikey=$API_KEY_ALPHAVANTAGE"
    echo
    RESPONSE=$(curl -s "https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=${keyword}&time_from=$(date -u -d '1 day ago' +%Y%m%dT%H%M)&apikey=$API_KEY_ALPHAVANTAGE")
    if echo "$RESPONSE" | grep -q "Our standard API rate limit is 25 requests per day. Please subscribe to any of the premium plans"; then
        echo -e "You can't use the free API for this, you need to pay for their minimum subscription. Remove the value in API_KEY_ALPHAVANTAGE in .env file if you don't want to use it.\n"
        return
    fi
    echo "$RESPONSE" | jq -r '.feed[] | .title, .url, ""' | head -n 9
}

# Function to fetch news from NewsAPI
fetch_newsapi() {
    keyword=$1
    if [ -z "$API_KEY_NEWSAPI_ORG" ]; then
        echo "API_KEY_NEWSAPI_ORG is empty. Skipping fetch from NewsAPI."
        return
    fi
    echo -e "\e[1mFetching news from \e[0;35mNewsAPI\e[0m...\n"
    echo "QUERY: https://newsapi.org/v2/everything?q=${keyword}&language=en&sortBy=publishedAt&pageSize=3&apiKey=$API_KEY_NEWSAPI_ORG"
    echo
    curl -s "https://newsapi.org/v2/everything?q=${keyword}&language=en&sortBy=publishedAt&pageSize=3&apiKey=$API_KEY_NEWSAPI_ORG" | jq -r '.articles[] | .title, .url, ""'
}

# Function to fetch news from GNews
fetch_gnews() {
    keyword=$1
    if [ -z "$API_KEY_GNEWS" ]; then
        echo "API_KEY_GNEWS is empty. Skipping fetch from GNews."
        return
    fi
    echo -e "\e[1mFetching news from \e[0;35mGNews\e[0m...\n"
    echo "QUERY: https://gnews.io/api/v4/search?q=${keyword}&lang=en&max=3&token=$API_KEY_GNEWS"
    echo
    curl -s "https://gnews.io/api/v4/search?q=${keyword}&lang=en&max=3&token=$API_KEY_GNEWS" | jq -r '.articles[] | .title, .url, ""'
}

# Parse command-line options
while (( "$#" )); do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        *)
            keyword=$1
            shift
            ;;
    esac
done

# Set default keyword if none provided
if [ -z "$keyword" ]; then
    keyword="bitcoin%20OR%20ethereum%20OR%20uniswap%20OR%20coinbase%20OR%20usd"
fi

# Fetch news
fetch_alphavantage $keyword
fetch_newsapi $keyword
fetch_gnews $keyword
