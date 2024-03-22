#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $BASE_DIR/.env

declare -A platforms
platforms=( ["instagram"]="instagram.sh" ["facebook"]="facebook.sh" ["linkedin"]="linkedin.sh" ["tiktok"]="tiktok.py" ["reddit"]="reddit.sh" ["twitter"]="twitter.sh" ["youtube"]="youtube.sh" )

for platform in "$@"
do
    if [[ -n "${platforms[$platform]}" ]]; then
        if [[ "${platform}" == "tiktok" ]]; then
            python $BASE_DIR/sub-scripts/${platforms[$platform]}
        else
            bash $BASE_DIR/sub-scripts/${platforms[$platform]}
        fi
    else
        echo "Invalid platform: $platform"
    fi
done