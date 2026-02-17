# Introduction 

[Langflow](https://www.langflow.org/) is a framework for building applications with LLMs. It provides a simple and intuitive way to create and manage LLM applications, allowing developers to focus on building their applications without worrying about the underlying infrastructure. This repository contains the server code for Langflow, which is responsible for managing the LLM applications and providing a REST API for interacting with them.

## Prerequisites

- Docker and Docker Compose installed
- API keys for the LLM providers you want to use

## Project Structure

```
langflow/
├── .env.example        # Environment variables template
├── .env                # Your environment configuration (create from .env.example)
├── docker-compose.yaml # Docker Compose configuration
├── flows/              # Langflow flow definitions
├── components/         # Custom components
│   ├── custom_components/
│   └── tools/
├── data/               # Data files for your flows
└── scripts/            # Utility scripts
```

# Getting Started

1. **Clone and configure environment**

   ```bash
   cp .env.example .env
   ```

2. **Edit `.env` and add your API keys**

   ```dotenv
   OPENAI_API_KEY=your-openai-api-key
   AZURE_OPENAI_API_KEY=your-azure-openai-api-key
   MISTRAL_API_TOKEN=your-mistral-api-token
   HF_TOKEN=your-huggingface-token
   GH_MODEL_TOKEN=your-github-model-token
   AIRTABLE_TOKEN=your-airtable-token
   MONGO_ATLAS_USERNAME=your-mongo-username
   MONGO_ATLAS_PASSWORD=your-mongo-password
   ```

3. **Start the services**

   ```bash
   docker compose up -d
   ```

4. **Access Langflow UI**

   Open your browser and navigate to: http://localhost:7860

## Environment Variables

### API Keys

| Variable | Description |
|----------|-------------|
| `OPENAI_API_KEY` | OpenAI API key |
| `AZURE_OPENAI_API_KEY` | Azure OpenAI API key |
| `MISTRAL_API_TOKEN` | Mistral AI API token |
| `HF_TOKEN` | Hugging Face API token |
| `GH_MODEL_TOKEN` | GitHub Models API token |
| `AIRTABLE_TOKEN` | Airtable API token |
| `MONGO_ATLAS_USERNAME` | MongoDB Atlas username |
| `MONGO_ATLAS_PASSWORD` | MongoDB Atlas password |

### MCP Server Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `LANGFLOW_MCP_SERVER_ENABLED` | `true` | Enable/disable MCP server initialization for projects |
| `LANGFLOW_MCP_SERVER_ENABLE_PROGRESS_NOTIFICATIONS` | `false` | Enable progress notifications from MCP servers |
| `LANGFLOW_MCP_SERVER_TIMEOUT` | `20` | Timeout in seconds for MCP server operations |
| `LANGFLOW_MCP_MAX_SESSIONS_PER_SERVER` | `10` | Maximum number of MCP sessions per server |
| `LANGFLOW_ADD_PROJECTS_TO_MCP_SERVERS` | `true` | Auto-add new projects to MCP servers configuration |

For more information on MCP server configuration, see the [Langflow MCP documentation](https://docs.langflow.org/mcp-server#mcp-server-environment-variables).

# Build and Test

## Starting Services

```bash
# Start all services in detached mode
docker compose up -d

# View logs
docker compose logs -f langflow
```

## Stopping Services

```bash
# Stop all services
docker compose down

# Stop and remove volumes (WARNING: deletes all data)
docker compose down -v
```

## Custom Components

Place your custom components in the `components/custom_components/` directory. They will be automatically loaded by Langflow.

## Flows

Export your flows from the Langflow UI and save them in the `flows/` directory for version control.

## Volumes

| Volume | Description |
|--------|-------------|
| `langflow-postgres` | PostgreSQL data persistence |
| `langflow-data` | Langflow application data, logs, and secrets |

