# Crypto News Fetcher

This is a bash script that fetches the latest news about cryptocurrencies, stocks, and forex from different sources using their APIs and displays them in the terminal. The script fetches 3 latest news about the given keyword from each API.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to have `curl` and `jq` installed on your system to run this script. If not installed, you can install them using the following commands:

For curl:
```
sudo apt-get install curl
```

For jq:
```
sudo apt-get install jq
```

### Installing

Clone the repository to your local machine:

```
git clone https://github.com/ETFrocks/cryptonewsfetcher.git
```

Navigate to the project directory:

```
cd cryptonewsfetcher
```

Make the script executable:

```
chmod +x fetch_news.sh
```

### Configuration

The keys that are already in the script are dummy keys and they might have reached their daily limits as this script is public. Therefore, it is highly recommended that you create your own keys and add them to the script.

To do this, you need to set up your API keys for Alphavantage, NewsAPI, and GNews. You should create a `.env` file in the project directory and add your API keys in the following format:

```
API_KEY_ALPHAVantage=your_alphavantage_api_key
API_KEY_NEWSAPI_ORG=your_newsapi_org_api_key
API_KEY_GNEWS=your_gnews_api_key
```

You can obtain your API keys from the following links:

- For Alphavantage, visit: https://www.alphavantage.co/support/#api-key
- For NewsAPI, visit: https://newsapi.org/register
- For GNews, visit: https://gnews.io/login

Once you have obtained your API keys and added them to the `.env` file, your application will be able to access these keys as environment variables.

### Usage

Run the script with a keyword (optional, will use bitcoin if none is provided):

```
./fetch_news.sh keyword
```

To display help:

```
./fetch_news.sh -h
```

If no keyword is provided, the script fetches news about "bitcoin", "ethereum", "uniswap", "coinbase", and "usd".

## Built With

* [Bash](https://www.gnu.org/software/bash/) - The scripting language used
* [curl](https://curl.se/) - Command line tool and library for transferring data with URLs
* [jq](https://stedolan.github.io/jq/) - Lightweight and flexible command-line JSON processor

## Authors

* **BlackBird** - *Initial work* - [ETFrocks](https://github.com/ETFrocks)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to Stephen Dolan, the creator of jq, a lightweight and flexible command-line JSON processor, first released in 2013.
* Respect to Daniel Stenberg, the creator of curl, a command-line tool for transferring data with URLs, first released in 1997.
* Acknowledgment to Mark Shuttleworth, who founded Canonical Ltd., which developed and continues to maintain Ubuntu, first released in 2004.
* Salute to Linus Torvalds, the creator of Linux, the open-source operating system kernel, first released in 1991.
* A big thank you to all the creators and contributors of open-source software. Your work has made a significant impact on the world of technology.

Please note that the dates mentioned are for the initial releases of these tools and platforms.

