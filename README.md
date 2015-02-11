kafka-broker
============

Dockerfile for [Apache Kafka](http://kafka.apache.org/) inspired by
[wurstmeister/kafka-docker](https://github.com/wurstmeister/kafka-docker) and [hwasungmars/kafka-broker-docker](https://github.com/hwasungmars/kafka-broker-docker). In contrast, this project is developed for compatibility with CoreOS.

# Docker image
```
docker build -t <your-dockerhub-username>/kafka-broker .
docker push <your-dockerhub-username>/kafka-broker
```

# Usage in Fleet unit files
This image writes values from Docker environmment variables to Kafka's [config/server.properties](https://apache.googlesource.com/kafka/+/0.8.1/config/server.properties) file. `kafka-broker.service` provides a sample Fleet unit file for passing relevant Kafka parameters. It assumes that the key /services/zookeeper has been written to etcd with the IP of a ZooKeeper server as its value. 
