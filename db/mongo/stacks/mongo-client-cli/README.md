# Mongo CLI client
This stack creates a single MongoDB server instance with a client container where the mongo CLI client can be used to connect to the server. There is also an init database sript that creates a sample databse to test connections etc.

# Using the CLI.
1. First we start the container using `docker-compose`.
```bash
docker-compose up -d
```
2. Then we can start a shell in the client container:
```bash
docker exec -it mongoclient /sh
```
3. Finally we can execute the client to connect to the test database:
```bash
mongo $MONGO_SERVER/$MONGO_INITDB_DATABASE -u $MONGO_INITDB_ROOT_USERNAME -p $MONGO_INITDB_ROOT_PASSWORD
```

When finished please stop/remove the container using `docker-compose down`. The environment variables `MONGO_SERVER`, `MONGO_INITDB_DATABASE`, `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`. Can be adjusted in the `docker-compose.yml` file.  

