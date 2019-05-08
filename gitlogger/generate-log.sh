#! /bin/ash

git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames > /logs/logfile.log
