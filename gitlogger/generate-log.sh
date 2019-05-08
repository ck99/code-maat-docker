#! /bin/ash

git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aE' --no-renames > /logs/logfile.log
