#! /bin/sh

[ ! "$(docker images | grep busybox)" ] && docker pull busybox
[ ! "$(docker images | grep code-maat-gitlogger)" ] && ./build.sh
[ ! "$(docker images | grep code-maat-app)" ] && ./build.sh


