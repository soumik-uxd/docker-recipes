ARG LANGFLOW_VERSION=1.7.3
FROM langflowai/langflow:${LANGFLOW_VERSION}

# Install additional dependencies if needed
# For example, to install a specific Python package, you can uncomment the following line:
# RUN pip install <package-name>

RUN mkdir /app/flows /app/custom_components 
ENV LANGFLOW_LOAD_FLOWS_PATH=/app/flows
ENV LANGFLOW_COMPONENTS_PATH=/app/custom_components