FROM elasticsearch:5.6.14
RUN yum install curl; \
    bin/elasticsearch-plugin install -b ingest-attachment; \
    bin/elasticsearch-plugin install -b x-pack
    
