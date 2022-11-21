# Postgres-Sample

Creates a postgres container with a [Sample Database](https://www.postgresqltutorial.com/postgresql-sample-database/) pre-loaded. 
## How To

Clone the repository
```bash
git clone https://github.com/soumik-uxd/docker-recipes.git
```

**Build the image**
```bash
cd docker-recipes\db\postgres-sample
docker build -t <IMAGE_TAG_NAME> .
```

**Run the image in a container**
```bash
docker run -d --name <CONTAINER_NAME> \
    -v <DATA_VOLUME_NAME>:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=<POSTGRES_PASSWORD> \
    -p 5432:5432 <IMAGE_TAG_NAME>
```

Usually the start of container and the load of the data takes a couple of seconds. Once the container is ready the database can be accessed at `postgresql://localhost:5432/dvdrental`. For JDBC use `jdbc:postgresql://localhost:5432/dvdrental`.
