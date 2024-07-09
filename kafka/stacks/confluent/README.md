# Kafka Stacks (Custom)
These below Kafka stacks are built using the images from [Confluent](https://www.confluent.io/) which can be found [here](https://hub.docker.com/u/confluentinc).

## Stacks
| Section     | Description |
| ----------- | ----------- |
| **[single-broker-zk](./single-broker-zk/)** | Single kafka broker with a singular zookeeper |
| **[single-broker-zk-registry](./single-broker-zk-registry/)**      | Single kafka broker with a singular zookeeper, and a kafka schema registry |
| **[single-broker-zk-manager](./single-broker-zk-manager/)**      | Single kafka broker with a singular zookeeper, and a kafka manager on top |
| **[single-broker-zk-rest-proxy](./single-broker-zk-rest-proxy/)** | Single kafka broker with a singular zookeeper, schema-registry, kafka-connect and kafka rest proxy |
| **[single-broker-zk-ecc](./single-broker-zk-ecc/)** | Single kafka broker with a singular zookeeper, schema-registry, kafka-connect and the [confluent enterprise control center](https://hub.docker.com/r/confluentinc/cp-enterprise-control-center) |
| **[single-broker-zk-connect](./single-broker-zk-connect/)** | Single kafka broker with a singular zookeeper, schema-registry, kafka-connect and a kafka manager on top |
| **[single-broker-zk-ui](./single-broker-zk-ui/)**      | Single kafka broker with a singular zookeeper, and [Kafdrop](https://github.com/obsidiandynamics/kafdrop)/[Provectus](https://github.com/provectus/kafka-ui) as a UI |