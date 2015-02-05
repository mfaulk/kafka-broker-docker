FROM ubuntu:14.04

MAINTAINER mfaulk
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y openjdk-7-jre-headless wget ruby

RUN wget -q http://mirror.ox.ac.uk/sites/rsync.apache.org/kafka/0.8.1.1/kafka_2.9.2-0.8.1.1.tgz -O /tmp/kafka.tgz
RUN mkdir /opt/kafka
RUN tar xfz /tmp/kafka.tgz -C /opt/kafka --strip-components=1

ENV KAFKA_HOME /opt/kafka

ADD server.properties.erb /opt/kafka/config/server.properties.erb
ADD start-kafka.rb /usr/bin/start-kafka.rb
CMD start-kafka.rb
