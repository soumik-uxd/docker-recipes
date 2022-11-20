# Kafka
Here one can find all the images and stacks related to [Apache Kafka](https://kafka.apache.org/). 

**Disclaimer**
: Please note, none of these images/stacks are fit for production usage. Please use at your own risk, assuming you are familiar with the [Apache Kafka ecosystem](https://cwiki.apache.org/confluence/display/kafka/ecosystem).

## Images
| Section     | Description |
| ----------- | ----------- |
| **[zookeeper](./iamges/zookeeper/)**      | [Apache Zookeeper](https://zookeeper.apache.org/) build       |

## Stacks
| Section     | Description |
| ----------- | ----------- |
| **[single-broker-zk](./stacks/single-broker-zk/)** | Single kafka broker with a singular zookeeper      |
| **[single-broker-zk-manager](./stacks/single-broker-zk-manager/)**      | Single kafka broker with a singular zookeeper, and a kafka manager on top      |
| **[single-broker-zk-registry](./stacks/single-broker-zk-registry/)**      | Single kafka broker with a singular zookeeper, kafka-schema-registry and a kafka manager on top      |
| **[single-broker-zk-connect](./stacks/single-broker-zk-connect/)**      | Single kafka broker with a singular zookeeper, kafka-connect and a kafka manager on top      |
| **[single-broker-zk-rest-proxy](./stacks/single-broker-zk-rest-proxy/)**      | Single kafka broker with a singular zookeeper, kafka-connect and a kafka-rest-proxy.       |
| **[single-broker-zk-ui](./stacks/single-broker-zk-ui/)**      | Single kafka broker with a singular zookeeper, and [Kafdrop](https://github.com/obsidiandynamics/kafdrop)/[Provectus](https://github.com/provectus/kafka-ui) as a UI       |
| **[single-broker-zk-ecc](./stacks/single-broker-zk-ecc/)**      | Single kafka broker with a singular zookeeper, kafka connect, schema-registry and the Confluent enterprise control center to manage the services.       |
