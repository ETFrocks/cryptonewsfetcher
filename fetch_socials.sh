#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $BASE_DIR/.env

# Fetch top 3 posts from Instagram
#bash $BASE_DIR/sub-scripts/instagram.sh

# Fetch top 3 posts from Facebook
#bash $BASE_DIR/sub-scripts/facebook.sh

# Fetch top 3 posts from LinkedIn
#bash $BASE_DIR/sub-scripts/linkedin.sh

# Fetch top 3 posts from TikTok
python $BASE_DIR/sub-scripts/tiktok.py

# Fetch top 3 posts from Reddit
bash $BASE_DIR/sub-scripts/reddit.sh

# Fetch top 3 posts from Twitter
bash $BASE_DIR/sub-scripts/twitter.sh

# Fetch top 3 posts from YouTube
#bash $BASE_DIR/sub-scripts/youtube.sh
