# Postgres-chinook

Creates a postgres container with the [Chinook Database](https://github.com/soumik-uxd/docker-recipes.git) pre-loaded alongwith some technical users. The sql containing the CREATE and INSERT queries for the data was created by [John Atten](http://johnatten.com/2015/04/05/a-more-useful-port-of-the-chinook-database-to-postgresql/) and sourced from his [repo](https://github.com/xivSolutions/ChinookDb_Pg_Modified).
## How To

Clone the repository
```bash
git clone https://github.com/soumik-uxd/docker-recipes.git
```

**Prerequisites before building the image**

The assumption is that there is a `db.env` file present in the same directory as the Dockerfile which loads the technical usernames and their passwords. In case the file is absent the docker build will fail. The `db.env` should look like below:
```bash
SUPER_USERNAME=<SUPER_USERNAME>
SUPER_PASSWORD=<SUPER_USER_PASSWORD>
READER_USERNAME=<READER_USERNAME>
READER_PASSWORD=<READER_PASSWORD>
EDITOR_USERNAME=<EDITOR_USERNAME>
EDITOR_PASSWORD=<EDITOR_PASSWORD>
```
The super user will have the `CREATE`, `ALTER` and `DROP` permissions (along with all the permissions for the editor and reader user) for all tables on the schema where the data is loaded. The editor user will have `UPDATE` and `DELETE` permissions (along with all the permissions for the reader user), and the reader user will have `SELECT` permissions only.

**Build the image**
```bash
cd docker-recipes\db\postgres-chinook
docker build -t <IMAGE_TAG_NAME> .
```

**Run the image in a container**
```bash
docker run -d --name <CONTAINER_NAME> \
    -v <DATA_VOLUME_NAME>:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=<POSTGRES_PASSWORD> \
    -p 5432:5432 <IMAGE_TAG_NAME>
```
**Note:** The environment variable `DB_SCHEMA` to be set before the init script loaded to `/docker-entrypoint-initdb.d/` can be started. The value in Dockerfile is set to `main`. If you wish a different schema name it can be overriden using the extra `SCHEMA_NAME=<SCHEMA_NAME>` for environment variables in the `docker run` command like below.
```bash
docker run -d --name <CONTAINER_NAME> \
    -v <DATA_VOLUME_NAME>:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=<POSTGRES_PASSWORD> \
        SCHEMA_NAME=<SCHEMA_NAME> \
    -p 5432:5432 <IMAGE_TAG_NAME>
``` 

Usually the start of container and the load of the data takes about a minute. Once the container is ready the database can be accessed at `postgresql://localhost:5432/chinook`. For JDBC use `jdbc:postgresql://localhost:5432/chinook`.
