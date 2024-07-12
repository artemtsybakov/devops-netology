# syntax=docker/dockerfile:1
FROM centos:7
#Копирование файла конфигурации
COPY elasticsearch.yml /usr/share/elasticsearch/config/
ADD --checksum= home/artem/elasticsearch-7.9.3-x86_64.rpm /elasticsearch-7.9.3-x86_64.rpm
#Установка wget
RUN mkdir "/elasticsearch-7.9.3"
RUN yum -y install elasticsearch-7.9.3-x86_64.rpm
#Загрузка и установка Elasticsearch
#RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.13.2-linux-x86_64.tar.gz && \
#    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.13.2-linux-x86_64.tar.gz.sha512  && \
#    shasum -a 512 -c elasticsearch-8.13.2-linux-x86_64.tar.gz.sha512 && \
#    tar -xzf elasticsearch-8.13.2-linux-x86_64.tar.gz && \
#    rm elasticsearch-8.13.2-linux-x86_64.tar.gz elasticsearch-8.13.2-linux-x86_64.tar.gz.sha512 \
ENV ES_HOME /elasticsearch-7.9.3
ENV PATH=$ES_HOME/bin:$PATH
WORKDIR $ES_HOME
EXPOSE 9200 9300
CMD ["elasticsearch"]