# Introduction

[Langfuse](https://langfuse.com/) is an open-source LLM engineering platform that helps teams debug, analyze, and iterate on their LLM applications. It provides tracing, prompt management, and evaluation capabilities. This repository contains a Docker Compose setup for self-hosting Langfuse.

## Prerequisites

- Docker and Docker Compose installed
- At least 4GB of RAM available for the services

## Project Structure

```
langfuse/
├── .env.example        # Environment variables template
├── .env                # Your environment configuration (create from .env.example)
├── docker-compose.yaml # Docker Compose configuration
└── README.md           # This file
```

# Getting Started

1. **Clone and configure environment**

   ```bash
   cp .env.example .env
   ```

2. **Generate secure secrets**

   ```bash
   # Generate ENCRYPTION_KEY (required)
   openssl rand -hex 32

   # Generate NEXTAUTH_SECRET (required)
   openssl rand -base64 32

   # Generate SALT (required)
   openssl rand -base64 32
   ```

3. **Edit `.env` and update the secrets**

   Update `NEXTAUTH_SECRET`, `SALT`, and `ENCRYPTION_KEY` with the generated values.

4. **Start the services**

   ```bash
   docker compose up -d
   ```

5. **Access Langfuse UI**

   Open your browser and navigate to: http://localhost:3000

## Environment Variables

### Authentication & Security

| Variable | Description |
|----------|-------------|
| `NEXTAUTH_URL` | Base URL for NextAuth (default: `http://localhost:3000`) |
| `NEXTAUTH_SECRET` | Secret for NextAuth session encryption |
| `SALT` | Salt for password hashing |
| `ENCRYPTION_KEY` | 64-character hex string for data encryption |

### Database Configuration

| Variable | Description |
|----------|-------------|
| `DATABASE_URL` | PostgreSQL connection string |
| `CLICKHOUSE_URL` | ClickHouse HTTP URL |
| `CLICKHOUSE_MIGRATION_URL` | ClickHouse native protocol URL |
| `CLICKHOUSE_USER` | ClickHouse username |
| `CLICKHOUSE_PASSWORD` | ClickHouse password |

### S3/MinIO Storage

| Variable | Description |
|----------|-------------|
| `LANGFUSE_S3_EVENT_UPLOAD_BUCKET` | Bucket name for event uploads |
| `LANGFUSE_S3_EVENT_UPLOAD_ACCESS_KEY_ID` | S3 access key ID |
| `LANGFUSE_S3_EVENT_UPLOAD_SECRET_ACCESS_KEY` | S3 secret access key |
| `LANGFUSE_S3_EVENT_UPLOAD_ENDPOINT` | S3 endpoint URL |
| `LANGFUSE_S3_MEDIA_UPLOAD_BUCKET` | Bucket name for media uploads |

### Redis Configuration

| Variable | Description |
|----------|-------------|
| `REDIS_HOST` | Redis hostname |
| `REDIS_PORT` | Redis port |
| `REDIS_AUTH` | Redis authentication password |

### Initialization (Optional)

| Variable | Description |
|----------|-------------|
| `LANGFUSE_INIT_ORG_ID` | Initial organization ID |
| `LANGFUSE_INIT_ORG_NAME` | Initial organization name |
| `LANGFUSE_INIT_PROJECT_ID` | Initial project ID |
| `LANGFUSE_INIT_PROJECT_NAME` | Initial project name |
| `LANGFUSE_INIT_USER_EMAIL` | Initial user email |
| `LANGFUSE_INIT_USER_PASSWORD` | Initial user password |

For more configuration options, see the [Langfuse Self-Hosting documentation](https://langfuse.com/docs/deployment/self-host).

# Build and Test

## Starting Services

```bash
# Start all services in detached mode
docker compose up -d

# View logs
docker compose logs -f langfuse-web
```

## Stopping Services

```bash
# Stop all services
docker compose down

# Stop and remove volumes (WARNING: deletes all data)
docker compose down -v
```

## Services Overview

| Service | Port | Description |
|---------|------|-------------|
| `langfuse-web` | 3000 | Langfuse web UI and API |
| `langfuse-worker` | 3030 | Background worker for async processing |
| `postgres` | 5432 | PostgreSQL database |
| `clickhouse` | 8123, 9000 | ClickHouse analytics database |
| `redis` | 6379 | Redis for caching and queues |
| `minio` | 9090, 9091 | S3-compatible object storage |

## Volumes

| Volume | Description |
|--------|-------------|
| `langfuse_postgres_data` | PostgreSQL data persistence |
| `langfuse_clickhouse_data` | ClickHouse data persistence |
| `langfuse_clickhouse_logs` | ClickHouse logs |
| `langfuse_minio_data` | MinIO object storage data |
