# Mongo-Client-Sample
This stack creates a single MongoDB server instance, and then loads the [sample dataset](https://www.mongodb.com/developer/products/atlas/atlas-sample-datasets/#sql-atlas-sample-data-deeper-dive) from MongoDB (downloaded from [here](https://github.com/neelabalan/mongodb-sample-dataset)), and with a client container where the [mongoclient](https://github.com/nosqlclient/nosqlclient) can be used to connect to the server. 

## Usage.
1. The sample data is not part of the repo, due to the size of the JSONs amounting to approx 430MB. Therefore it needs to be dowloaded with the below script.
```bash
./download-data.sh
```
2. Once the sample data has been downloaded we can start the containers using `docker-compose`.
```bash
docker-compose up -d
```
The mongo-express client should then be available at `http://localhost:3300/`.

3. After opening a new connection needs to be created to connect to the server. Click the `Create New` button.
![MongoClient Create New Connection Screenshot - Step 1](./screenshots/mongoclient-create-connection1.png?raw=true "MongoClient Create New Connection Screenshot - Step 1")

Here we are trying to connect initially to the `sample_mflix` database. The hostname should match the container name of the mongoDB server.
![MongoClient Create New Connection Screenshot - Step 2](./screenshots/mongoclient-create-connection2.png?raw=true "MongoClient Create New Connection Screenshot - Step 2")

Then we add the authentication details, the `Username`, `Password` and `Authentication DB` should match the environment variables `MONGO_INITDB_ROOT_USERNAME`, `MONGO_INITDB_ROOT_PASSWORD` and `MONGO_INITDB_DATABASE` respectively.
![MongoClient Create New Connection Screenshot - Step 3](./screenshots/mongoclient-create-connection3.png?raw=true "MongoClient Create New Connection Screenshot - Step 3").

Now we can connect to the mongoDB server by choosing the newly created connection and clicking the `Connect` button.
![MongoClient Create New Connection Screenshot - Step 4](./screenshots/mongoclient-create-connection4.png?raw=true "MongoClient Create New Connection Screenshot - Step 4").

We are now connected to the to the `sample_mflix` database.
![MongoClient Create New Connection Screenshot - Step 5](./screenshots/mongoclient-create-connection5.png?raw=true "MongoClient Create New Connection Screenshot - Step 5").

When finished, please stop/remove the containers using `docker-compose down`. The environment variables `MONGO_INITDB_DATABASE`, `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`, can be adjusted in the `docker-compose.yml` file.  

## Sample Datasets.

|Dataset Name|Description|
|---|---|
|[Sample AirBnB Listings Dataset](https://docs.atlas.mongodb.com/sample-data/sample-airbnb/)|Contains details on AirBnB listings.|
|[Sample Analytics Dataset](https://docs.atlas.mongodb.com/sample-data/sample-analytics/)|Contains training data for a mock financial services application.|
|[Sample Geospatial Dataset](https://docs.atlas.mongodb.com/sample-data/sample-geospatial/)|Contains shipwreck data.|
|[Sample Mflix Dataset](https://docs.atlas.mongodb.com/sample-data/sample-mflix/)|Contains movie data.|
|[Sample Supply Store Dataset](https://docs.atlas.mongodb.com/sample-data/sample-supplies/)|Contains data from a mock office supply store.|
|[Sample Training Dataset](https://docs.atlas.mongodb.com/sample-data/sample-training/)|Contains MongoDB training services dataset.|
|[Sample Weather Dataset](https://docs.atlas.mongodb.com/sample-data/sample-weather/)|Contains detailed weather reports.|

## Dataset Contents

|Database|Collections|
|---|---|
|sample_airbnb|listingsAndReviews|
|sample_analytics|accounts, customers, transactions|
|sample_geospatial|shipwrecks|
|sample_mflix|comments, movies, theaters, users|
|sample_supplies|sales|
|sample_training|companies, grades, inspection, posts, routes, stories, trips, tweets, zips|
|sample_weatherdata|data|