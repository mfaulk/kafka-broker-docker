FROM ubuntu:14.04

MAINTAINER Matthew Faulkner mnfaulk@gmail.com

# Install basics
RUN apt-get -qy update
RUN apt-get -qy install wget curl
RUN apt-get -y upgrade
RUN apt-get install -y openjdk-7-jre-headless wget

# Install confd
RUN curl -qL https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 -o /usr/local/bin/confd && chmod +x /usr/local/bin/confd
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Add confd templates
ADD ./server.properties.tmpl /etc/confd/templates/server.properties.tmpl
ADD ./kafka.toml /etc/confd/conf.d/kafka.toml

# Add a boot script
ADD boot.sh /opt/boot.sh
RUN chmod +x /opt/boot.sh

RUN wget -q http://mirror.ox.ac.uk/sites/rsync.apache.org/kafka/0.8.1.1/kafka_2.9.2-0.8.1.1.tgz -O /tmp/kafka.tgz
RUN mkdir /opt/kafka
RUN tar xfz /tmp/kafka.tgz -C /opt/kafka --strip-components=1

ENV KAFKA_HOME /opt/kafka

# Run the boot script
CMD /opt/boot.sh
