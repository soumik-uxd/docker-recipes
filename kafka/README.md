# Kafka
Here one can find all the images and stacks related to [Apache Kafka](https://kafka.apache.org/). 

**Disclaimer**
: Please note, none of these images/stacks are fit for production usage. Please use at your own risk, assuming you are familiar with the [Apache Kafka ecosystem](https://cwiki.apache.org/confluence/display/kafka/ecosystem).

## Images
| Section     | Description |
| ----------- | ----------- |
| **[zookeeper](./images/zookeeper/)**      | Custom [Apache Zookeeper](https://zookeeper.apache.org/) image       |
| **[kafka-base](./images/kafka-base/)**      | Base image for [Apache Kafka](https://kafka.apache.org/) |
| **[kafka-broker](./images/kafka-broker/)**      | Image for [Apache Kafka](https://kafka.apache.org/) brokers       |
| **[cmak](./images/cmak/)**      | Image for [Kafka Manager or CMAK](https://github.com/yahoo/CMAK) |

## Stacks
| Section     | Description |
| ----------- | ----------- |
| [Custom](./stacks/custom) | Kakfa stacks built using [custom images](./images) |
| [Apache](./stacks/apache) | Kakfa stacks built using [Apache Kafka](https://hub.docker.com/r/apache/kafka) images |
| [Bitnami](./stacks/bitnami) | Kakfa stacks built using [Bitnami Kafka](https://hub.docker.com/r/bitnami/kafka) images |
| [Confluent](./stacks/confluent) | Kakfa stacks built using [Confluent Kafka](https://hub.docker.com/r/confluentinc/cp-kafka) images |





