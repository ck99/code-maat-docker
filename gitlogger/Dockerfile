FROM alpine/git:latest
COPY generate-log.sh /bin/generate-log.sh
ENTRYPOINT ["/bin/generate-log.sh"]
#CMD "git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames > /logs/logfile.log"
#CMD ["/bin/ash", "-c", "git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames > /logs/logfile.log"]
