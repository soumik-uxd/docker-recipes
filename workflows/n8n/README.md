# Introduction

[n8n](https://n8n.io/) is a workflow automation platform that allows you to connect various services and automate tasks. It provides a visual interface for building workflows and supports hundreds of integrations. This repository contains a Docker Compose setup for self-hosting n8n with PostgreSQL, Redis, and additional services.

## Prerequisites

- Docker and Docker Compose installed
- API keys for the services you want to integrate (e.g., Azure OpenAI)

## Project Structure

```
n8n/
├── .env.example        # Environment variables template
├── .env                # Your environment configuration (create from .env.example)
├── docker-compose.yml  # Docker Compose configuration
├── flows/              # n8n workflow definitions
├── credentials/        # n8n credentials (exported)
├── scripts/            # Utility scripts and database configuration
└── ticket_db/          # Ticket database initialization scripts
```

# Getting Started

1. **Clone and configure environment**

   ```bash
   cp .env.example .env
   ```

2. **Edit `.env` and update the configuration**

   ```dotenv
   POSTGRES_USER=postgres
   POSTGRES_PASSWORD=root
   POSTGRES_DB=n8n

   AZURE_OPENAI_API_KEY=your-azure-openai-api-key
   AZURE_OPENAI_API_ENDPOINT=your-azure-openai-endpoint
   AZURE_OPENAI_API_VERSION=2024-02-01
   AZURE_OPENAI_API_DEPLOYMENT=gpt-4o
   AZURE_OPENAI_EMBED_KEY=your-azure-embedding-api-key
   AZURE_OPENAI_EMBED_ENDPOINT=your-azure-embedding-endpoint
   AZURE_OPENAI_EMBED_VERSION=2024-02-01
   AZURE_OPENAI_EMBED_DEPLOYMENT=text-embedding-3-small

   N8N_ENCRYPTION_KEY=your-encryption-key
   N8N_USER_MANAGEMENT_JWT_SECRET=your-jwt-secret
   ```

3. **Start the services**

   ```bash
   docker compose up -d
   ```

4. **Access n8n UI**

   Open your browser and navigate to: http://localhost:5678

## Environment Variables

### Database Configuration

| Variable | Description |
|----------|-------------|
| `POSTGRES_USER` | PostgreSQL username |
| `POSTGRES_PASSWORD` | PostgreSQL password |
| `POSTGRES_DB` | PostgreSQL database name |

### Azure OpenAI Configuration

| Variable | Description |
|----------|-------------|
| `AZURE_OPENAI_API_KEY` | API key for Azure OpenAI LLM |
| `AZURE_OPENAI_API_ENDPOINT` | Endpoint for Azure OpenAI LLM |
| `AZURE_OPENAI_API_VERSION` | API version for Azure OpenAI LLM |
| `AZURE_OPENAI_API_DEPLOYMENT` | Deployment name for Azure OpenAI LLM |
| `AZURE_OPENAI_EMBED_KEY` | API key for Azure OpenAI Embedding Model |
| `AZURE_OPENAI_EMBED_ENDPOINT` | Endpoint for Azure OpenAI Embedding Model |
| `AZURE_OPENAI_EMBED_VERSION` | API version for Azure OpenAI Embedding |
| `AZURE_OPENAI_EMBED_DEPLOYMENT` | Deployment name for embedding model |

### n8n Configuration

| Variable | Description |
|----------|-------------|
| `N8N_ENCRYPTION_KEY` | Encryption key for credentials |
| `N8N_USER_MANAGEMENT_JWT_SECRET` | JWT secret for user management |
| `N8N_DEFAULT_BINARY_DATA_MODE` | Binary data storage mode (default: `filesystem`) |

### pgAdmin Configuration (Optional)

| Variable | Default | Description |
|----------|---------|-------------|
| `PGADMIN_VERSION` | `8.5` | pgAdmin Docker image version |
| `PGADMIN_EMAIL` | `admin@admin.com` | pgAdmin login email |
| `PGADMIN_PASSWORD` | `root` | pgAdmin login password |

# Build and Test

## Starting Services

```bash
# Start all services in detached mode
docker compose up -d

# View logs
docker compose logs -f n8n
```

## Stopping Services

```bash
# Stop all services
docker compose down

# Stop and remove volumes (WARNING: deletes all data)
docker compose down -v
```

## Workflows

Export your workflows from the n8n UI and save them in the `flows/` directory for version control. The LangChain community package used by the Claude examples is declared with n8n's `N8N_COMMUNITY_PACKAGES` setting. On startup, `n8n-setup` imports credentials and workflows; the main and worker services wait for setup to finish.

Two Claude examples are provided in `flows/`: a basic prompt workflow and a text summarizer. Set `ANTHROPIC_API_KEY` in `.env`, then in n8n create an Anthropic API credential using that value. Assign the credential to the Anthropic node in each imported workflow, then save the workflows. The API key is not embedded in workflow JSON.

## Credentials

Export credentials as a single JSON file at `credentials/credentials.json` (without `--separate`). The setup service imports that file on startup. Keep it encrypted with the same `N8N_ENCRYPTION_KEY` used by the n8n instance.

Credential exports are encrypted with `N8N_ENCRYPTION_KEY`. Create the Anthropic credential in the UI, export it to `credentials/` if you want automatic import on startup, and use the same encryption key across restarts. Never commit plaintext API keys.

## Services Overview

| Service | Port | Description |
|---------|------|-------------|
| `n8n` | 5678 | n8n web UI and API |
| `n8n-worker` | - | Background worker for workflow execution |
| `n8n-postgres` | 5432 | PostgreSQL database for n8n |
| `n8n-redis` | 6379 | Redis for queue management |
| `pgadmin` | 5050 | pgAdmin web interface |
| `ticket-db` | 5433 | Additional PostgreSQL database |

## Volumes

| Volume | Description |
|--------|-------------|
| `n8n-storage` | n8n application data and settings |
| `n8n-db-storage` | PostgreSQL data for n8n |
| `n8n-redis-storage` | Redis data persistence |
| `n8n-pgadmin-data` | pgAdmin configuration and data |
| `ticket-db-data` | Ticket database data persistence |
