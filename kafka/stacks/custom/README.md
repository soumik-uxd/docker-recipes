# Kafka Stacks (Custom)
These below Kafka stacks are built using the custom images which can be found [here](../../images/).

## Stacks
| Section     | Description |
| ----------- | ----------- |
| **[single-broker-zk](./single-broker-zk/)** | Single kafka broker with a singular zookeeper |
| **[single-broker-zk-manager](./single-broker-zk-manager/)**      | Single kafka broker with a singular zookeeper, and a kafka manager on top |
| **[single-broker-zk-cmak](./single-broker-zk-cmak/)**      | Single kafka broker with a singular zookeeper, and a kafka manager (based on [custom image](../../images/cmak/)) on top. |
| **[single-broker-zk-connect](./single-broker-zk-connect/)**      | Single kafka broker with a singular zookeeper, kafka-connect and a kafka manager on top |
| **[single-broker-zk-ui](./single-broker-zk-ui/)**      | Single kafka broker with a singular zookeeper, and [Kafdrop](https://github.com/obsidiandynamics/kafdrop)/[Provectus](https://github.com/provectus/kafka-ui) as a UI |
| **[multi-broker-zk](./multi-broker-zk/)** | Mutliple kafka brokers with a singular zookeeper |
| **[multi-broker-multi-zk](./multi-broker-zk/)** | Mutliple kafka brokers with mutilple zookeepers |
| **[multi-broker-zk-manager](./multi-broker-zk-manager/)**      | Mutliple kafka brokers with a singular zookeeper, and a kafka manager on top |