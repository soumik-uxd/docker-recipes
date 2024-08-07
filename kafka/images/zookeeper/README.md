# Zookeeper

## Details

### Arguments

| Argument           | Description                           | Default   |
|--------------------|---------------------------------------|-----------|
| `ZOOKEEPER_VERSION`| Specifies the Zookeeper version to be used | `3.9.2`    |

### Environment Variables

| Variable              | Description                                    | Default   |
|-----------------------|------------------------------------------------|-----------|
| `ZOOKEEPER_WORKDIR`   | Directory where Zookeeper will be installed | `/opt/zookeeper` |
| `ZOOKEEPER_CONF_DIR`  | Directory for Zookeeper configuration files    | `/opt/zookeeper/conf` |
| `ZOOKEEPER_DATA_DIR`  | Directory for Zookeeper data                   | `/opt/zookeeper/data` |
| `ZOOKEEPER_LOG_DIR`   | Directory for Zookeeper logs                   | `/opt/zookeeper/logs` |

### Ports

| Port | Description           |
|------|-----------------------|
| 2181 | Zookeeper client port |
| 2888 | Zookeeper follower port |
| 3888 | Zookeeper election port |
| 8080 | Admin server port     |

### Volumes
The directories specified by env params `ZOOKEEPER_CONF_DIR`, `ZOOKEEPER_DATA_DIR` and `ZOOKEEPER_LOG_DIR`.

## Build 

To build the Docker image, we can run the following command in the directory containing the Dockerfile:

```bash
docker build -t zookeeper .
```

## Run
Examples of usages have been provided [here](../../stacks/custom/).

## Disclaimer
This Dockerfile is intended for testing purposes only. For production builds, use the official Apache Zookeeper image from [Docker Hub](https://hub.docker.com/_/zookeeper).