FROM clojure:alpine as builder
ARG rev=5f84c6aedce3ec3721ca091967fa5db6fa969171
ARG dest=/usr/src/code-maat
RUN mkdir -p $dest && wget https://github.com/adamtornhill/code-maat/archive/${rev}.zip && \
    unzip ${rev}.zip && mv /tmp/code-maat-${rev}/* $dest && cd $dest && lein deps && \
    mv "$(lein uberjar | sed -n 's/^Created \(.*standalone\.jar\)/\1/p')" app-standalone.jar 

FROM clojure:alpine
COPY --from=builder /usr/src/code-maat/app-standalone.jar /tmp/app-standalone.jar
ENTRYPOINT ["java", "-jar", "app-standalone.jar"]
CMD []
