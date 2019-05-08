FROM elasticsearch:5.6.14
RUN apt-get update && apt-get install curl; \
    bin/elasticsearch-plugin install -b ingest-attachment; \
    bin/elasticsearch-plugin install -b x-pack
    
