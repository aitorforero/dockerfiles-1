FROM elasticsearch:5.6.14-alpine
RUN apk update && apk add curl; \
    bin/elasticsearch-plugin install -b ingest-attachment
