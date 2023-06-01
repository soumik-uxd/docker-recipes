# Spring Batch Postgres DB Server

Creates a postgres container with a database called `springbatchdb` which is loaded with the neccessary tables for spring batch execution.
## How To

Clone the repository
```bash
git clone https://github.com/soumik-uxd/docker-recipes.git
```

**Build the image**
```bash
cd docker-recipes\db\spring-batch-pgsql-dbserver
docker build -t <IMAGE_TAG_NAME> .
```

**Run the image in a container**
```bash
docker run -d --name <CONTAINER_NAME> \
    -v <DATA_VOLUME_NAME>:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=<POSTGRES_PASSWORD> \
    -p 5432:5432 <IMAGE_TAG_NAME>
```

Usually the start of container and the load of the data takes a couple of seconds. Once the container is ready the database can be accessed at `postgresql://localhost:5432/springbatchdb`. For JDBC use `jdbc:postgresql://localhost:5432/springbatchdb`.
