#! /bin/sh
docker pull busybox
docker build -t code-maat-gitlogger gitlogger/. 
docker build -t code-maat-app code-maat-app/. 
