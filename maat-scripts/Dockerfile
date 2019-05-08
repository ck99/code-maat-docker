FROM alpine:3.8 as builder
ARG rev=50348f79321a7c4502fe08c7f5bf20b663791d4a
RUN wget https://github.com/adamtornhill/maat-scripts/archive/${rev}.zip && \
    mkdir -p /maat-scripts && unzip ${rev}.zip && mv /maat-scripts-${rev}/* /maat-scripts

FROM jfloff/alpine-python:2.7
COPY --from=builder /maat-scripts /maat-scripts
COPY ./*.sh /maat-scripts
