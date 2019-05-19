FROM elasticsearch:5.6.14
RUN apt-get -y update && \
    apt-get -y install curl && \
    bin/elasticsearch-plugin install -b ingest-attachment
