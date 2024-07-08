# Multiple Kafka Broker & single zookeeper

The docker-compose file will start a stack of services i.e. a single [Zookeeer](https://zookeeper.apache.org/) instance and three instances of Kafka brokers.

**Disclaimer**
: Please note, none of these images/stacks are fit for production usage. Please use at your own risk, assuming you are familiar with the [Apache Kafka ecosystem](https://cwiki.apache.org/confluence/display/kafka/ecosystem).


## Usage.
1. We can start the containers using `docker-compose`.
```bash
docker-compose up -d
```
The zookeeper instance should start at port 2181, the kafka broker at ports 9092, 9093 and 9094 respectively.

2. Now we can create a topic using the kafka cli inside the broker
```bash
docker exec -it kafka1 kafka-topics --create --topic test --partitions 1 --replication-factor 1 --if-not-exists --bootstrap-server kafka1:9092
```

3. Then check if the topic has been created
```bash
docker exec -it kafka kafka-topics --bootstrap-server kafka1:9092 --list
```

4. Then we can add some data into the topic using a producer via the kafka cli inside the broker
```bash
docker exec -it kafka1 bash -c "seq 42 | kafka-console-producer --request-required-acks 1 --broker-list kafka1:9092 --topic test && echo 'Produced 42 messages.'"
```

5. We can then check the topic details
```bash
docker exec -it kafka1 kafka-topics --bootstrap-server kafka1:9092 --topic test --describe 
```

When finished, please stop/remove the containers using `docker-compose down --volumes`. 

