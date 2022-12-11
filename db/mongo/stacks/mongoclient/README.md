# Mongo Client Stack
This stack creates a single MongoDB server instanceand a client container where the [mongoclient](https://github.com/nosqlclient/nosqlclient) can be used to connect to the server. 

## Usage.
1. We can start the containers using `docker-compose`.
```bash
docker-compose up -d
```
The mongo-express client should then be available at `http://localhost:3300/`.

1. After opening a new connection needs to be created to connect to the server. Click the `Create New` button.
![MongoClient Create New Connection Screenshot - Step 1](./screenshots/mongoclient-create-connection1.png?raw=true "MongoClient Create New Connection Screenshot - Step 1")

Here we are trying to connect initially to the `test` database (which was created by the init db scriptzs). The hostname should match the container name of the mongoDB server.
![MongoClient Create New Connection Screenshot - Step 2](./screenshots/mongoclient-create-connection2.png?raw=true "MongoClient Create New Connection Screenshot - Step 2")

Then we add the authentication details, the `Username`, `Password` and `Authentication DB` should match the environment variables `MONGO_INITDB_ROOT_USERNAME`, `MONGO_INITDB_ROOT_PASSWORD` and `MONGO_INITDB_DATABASE` respectively.
![MongoClient Create New Connection Screenshot - Step 3](./screenshots/mongoclient-create-connection3.png?raw=true "MongoClient Create New Connection Screenshot - Step 3").

Now we can connect to the mongoDB server by choosing the newly created connection and clicking the `Connect` button.
![MongoClient Create New Connection Screenshot - Step 4](./screenshots/mongoclient-create-connection4.png?raw=true "MongoClient Create New Connection Screenshot - Step 4").

We are now connected to the to the `test` database, where we can browse the single collection.
![MongoClient Create New Connection Screenshot - Step 5](./screenshots/mongoclient-create-connection5.png?raw=true "MongoClient Create New Connection Screenshot - Step 5").

When finished, please stop/remove the containers using `docker-compose down`. The environment variables `MONGO_INITDB_DATABASE`, `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`, can be adjusted in the `docker-compose.yml` file.  