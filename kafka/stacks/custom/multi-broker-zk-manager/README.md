# Single Kafka Broker, single zookeeper & kafka manager

The docker-compose file will start a stack of services i.e. a single [Zookeeer](https://zookeeper.apache.org/) instance and three instances of Kafka brokers and a [kakfa manager](https://github.com/yahoo/CMAK)

**Disclaimer**
: Please note, none of these images/stacks are fit for production usage. Please use at your own risk, assuming you are familiar with the [Apache Kafka ecosystem](https://cwiki.apache.org/confluence/display/kafka/ecosystem).


## Usage.
1. We can start the containers using `docker-compose`.
```bash
docker-compose up -d
```
A small service called `manager-cluster-init` should start in the background, initialize the kafka manager container (via the script `kafka-cluster-init.sh`) and then stop itself automatically. After that i.e. a few seconds, the zookeeper instance should start at port 2181, the kafka broker at ports 9092, 9093 and 9094 respectively and the manager at `http://localhost:9000/`. 
![Kafka Manager Init Screenshot - Step 0](./screenshots/kafka_manager_init.png?raw=true "Kafka Manager Init Screenshot - Step 0")

2. The cluster (in this case a single broker) is named `testing`. However this can be changed by adjusting the value of the environment variable `KAFKA_CLUSTER_NAME` before starting up the cluster.

3. Once inside we can see the number of topics, consumer, brokers etc
![Kafka Manager Init Screenshot - Step 1](./screenshots/kafka_manager_init1.png?raw=true "Kafka Manager Init Screenshot - Step 1")
   
4. Now we can create a topic using the kafka cli inside the broker
```bash
docker exec -it kafka kafka-topics --create --topic test --partitions 1 --replication-factor 1 --if-not-exists --bootstrap-server kafka:9092
```

5. We can now see the topic in the manager
![Kafka Manager Topic Screenshot - Step 1](./screenshots/kafka_manager_topic1.png?raw=true "Kafka Manager Topic Screenshot - Step 1")
6. Now we can add some data into the topic using a producer via the kafka cli inside the broker
```bash
docker exec -it kafka bash -c "seq 42 | kafka-console-producer --request-required-acks 1 --broker-list kafka:9092 --topic test && echo 'Produced 42 messages.'"
```
7. Clicking the topic `test` in the kafka manager shows that 42 messages have been added into the topic (via offset count)
![Kafka Manager Topic Screenshot - Step 2](./screenshots/kafka_manager_topic2.png?raw=true "Kafka Manager Topic Screenshot - Step 2")

When finished, please stop/remove the containers using `docker-compose down`. 