# Docker recipes for PostgreSQL

Here one can find all the images and stacks related to [PostgreSQL](https://www.postgresql.org/) database. 

**Disclaimer**
: Please note, none of these images/stacks are fit for production usage. Please use at your own risk, assuming you are familiar with the [PostgreSQL ecosystem](https://wiki.postgresql.org/wiki/Ecosystem:PostgreSQL_ecosystem).


# Docker recipes for databases

The following collections demonstrate the process of creation of services for various databases alongwith their ancilliary services.

- **[Postgres-sample](./postgresql-sample/)** -- A postgres image with a sample database preloaded
- **[Postgres-chinook](./postgresql-chinook/)** -- A postgres image with the Chinook database preloaded
- **[Postgres-chinook with pgAdmin](./pgadmin-db-chinook/)** -- PostgreSQL and pgAdmin containers with the Chinook database preloaded, a preconfigured database connection, and the pgAdmin master-password prompt disabled
- **[Postgres-minimal](./postgresql-minimal/)** -- Simplest postgres image based on alpine
- **[Spring-Batch-Postgres-DB-Server](./spring-batch-pgsql-dbserver//)** -- A postgres image loaded with the neccessary tables for spring batch execution.

