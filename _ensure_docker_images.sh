#! /bin/sh

[ ! "$(docker images | grep busybox)" ] && docker pull busybox
[ ! "$(docker images | grep code-maat-gitlogger)" ] && ./build.sh
[ ! "$(docker images | grep code-maat-cloc)" ] && ./build.sh
[ ! "$(docker images | grep code-maat-scripts)" ] && ./build.sh
[ ! "$(docker images | grep code-maat-app)" ] && ./build.sh



