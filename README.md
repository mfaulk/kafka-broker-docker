kafka-broker
============

Dockerfile for [Apache Kafka](http://kafka.apache.org/) inspired by
[wurstmeister/kafka-docker](https://github.com/wurstmeister/kafka-docker). The
difference is that we focus on providing connectivity between Kafka brokers and
Zookeeper through Docker's links facility (an internally routed internal
subnet). You can connect to the Kafka brokers by binding their ports to ports
on the host container (the supplied fig.yml does this for you - localhost 9092
by default). Or you can introduce a networking dependency on kafkaBroker by
linking to it.

## Quickstart

[Fig](http://www.fig.sh/) is the recommended way to run this Docker image.
```
fig up
```
This will start up a Zookeeper Docker image and two Kafka broker Docker images.

## Running independently

To run a Kafka broker without fig when Zookeeper is provided externally then
you need to provide some environment variables explicitly. For example:

```bash
docker run -e "ZK_PORT_2181_TCP_ADDR=localhost" -e "PORT=9092" -e "BROKER_ID=1" -t hwasungmars/kafka-broker
```

Where `ZK_PORT_2181_TCP_ADDR` is the IP address of a Zookeeper node running on
port 2181, `PORT` is the port you want the Kafka broker to listen on, and
`BROKER_ID` is a unique integer id for the broker.
