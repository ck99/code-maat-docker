FROM alpine:3.8
RUN apk add --no-cache cloc
COPY generate-cloc.sh /bin/generate-cloc.sh
ENTRYPOINT ["/bin/generate-cloc.sh"]
