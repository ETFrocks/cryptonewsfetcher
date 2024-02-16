#!/bin/bash

# Install Tweepy if not already installed
pip install tweepy

# Python script to fetch tweets
python3 << END

import tweepy

# Authenticate to Twitter
auth = tweepy.OAuthHandler("CONSUMER_KEY", "CONSUMER_SECRET")
auth.set_access_token("ACCESS_TOKEN", "ACCESS_TOKEN_SECRET")

api = tweepy.API(auth)

# Fetch the 3 most popular tweets about Bitcoin
public_tweets = api.search(q="Bitcoin", result_type="popular", count=3)

for tweet in public_tweets:
    print(tweet.text)

END
