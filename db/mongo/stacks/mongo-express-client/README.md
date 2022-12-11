# Mongo-Express Client Stack
This stack creates a single MongoDB server instance, and a client container where the [mongo-express client](https://github.com/mongo-express/mongo-express) can be used to connect to the server. 

## Usage.
1. We can start the containers using `docker-compose`.
```bash
docker-compose up -d
```
The mongo-express client should then be available at `http://localhost:8081/`.

![Mongo-Express Client App Screenshot](./Mongo-Express.png?raw=true "Mongo-Express Client App Screenshot")

When finished please stop/remove the container using `docker-compose down`. The environment variables `MONGO_SERVER`, `MONGO_INITDB_DATABASE`, `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`, can be adjusted in the `docker-compose.yml` file.  