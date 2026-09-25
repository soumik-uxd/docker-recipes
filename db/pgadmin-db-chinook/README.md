# PgAdmin-db-chinook

Creates PostgreSQL and pgAdmin containers with the [Chinook Database](https://github.com/soumik-uxd/docker-recipes.git) pre-loaded, along with some technical users. The PostgreSQL database is exposed on port `5432`, while pgAdmin is available on port `5050` with a preconfigured connection to the database.

## How To

Clone the repository
```bash
git clone https://github.com/soumik-uxd/docker-recipes.git
```

**Prerequisites before starting the containers**

The assumption is that there is a `db.env` file at `initdb/conf/db.env`. The initialization script uses this file to create the technical users and their passwords. In case the file is absent the database initialization will fail. The `db.env` should look like below:
```bash
SUPER_USERNAME=<SUPER_USERNAME>
SUPER_PASSWORD=<SUPER_USER_PASSWORD>
READER_USERNAME=<READER_USERNAME>
READER_PASSWORD=<READER_PASSWORD>
EDITOR_USERNAME=<EDITOR_USERNAME>
EDITOR_PASSWORD=<EDITOR_PASSWORD>
```

The super user will have all permissions on the tables, sequences and functions in the configured schema. The editor user is currently created with the same read permissions as the reader user; the reader user has `SELECT` permissions only.

**Start the containers**
```bash
cd docker-recipes/db/pgadmin-db-chinook
docker compose up -d
```

The default PostgreSQL connection uses:

```text
Host:     localhost
Port:     5432
Database: chinook
User:     postgres
Password: root
```

The default pgAdmin login is:

```text
URL:      http://localhost:5050
Email:    admin@admin.com
Password: root
```

The pgAdmin image version, login email and login password can be overridden with environment variables:
```bash
PGADMIN_VERSION=9.1 PGADMIN_EMAIL=<PGADMIN_EMAIL> PGADMIN_PASSWORD=<PGADMIN_PASSWORD> docker compose up -d
```

The database schema defaults to `media_store`. To use a different schema, override `DB_SCHEMA` in `docker-compose.yaml` before the first container startup. The database initialization runs only when the PostgreSQL data volume is created. To initialize the database again after changing the schema or users, remove the `db-data` volume and start the containers again.

Once the containers are ready, the database can be accessed at `postgresql://localhost:5432/chinook`. For JDBC use `jdbc:postgresql://localhost:5432/chinook`.

