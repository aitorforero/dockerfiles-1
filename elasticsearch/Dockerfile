FROM elasticsearch:5.6.14
RUN apk update && apk add curl; \
    bin/elasticsearch-plugin install -b ingest-attachment; \
    bin/elasticsearch-plugin install -b x-pack
    
