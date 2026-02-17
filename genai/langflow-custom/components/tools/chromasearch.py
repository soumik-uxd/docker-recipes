from copy import deepcopy

from chromadb.config import Settings
from langchain_chroma import Chroma
from typing_extensions import override

from langflow.base.vectorstores.model import LCVectorStoreComponent, check_cached_vector_store
from langflow.base.vectorstores.utils import chroma_collection_to_data
from langflow.io import BoolInput, DropdownInput, HandleInput, IntInput, StrInput, Output, MessageInput
from langflow.schema import Data


class ChromaSearch(LCVectorStoreComponent):
    """Custom Chroma Vector Store with only search capabilities."""

    display_name: str = "Chroma Search"
    description: str = "Chroma Vector Store with search capabilities"
    name = "ChromaSearch"
    icon = "Chroma"

    inputs = [
        StrInput(
            name="collection_name",
            display_name="Collection Name",
            value="langflow",
        ),
        StrInput(
            name="persist_directory",
            display_name="Persist Directory",
            advanced=True,
        ),
        *LCVectorStoreComponent.inputs,
        MessageInput(
            name="search_query",
            display_name="Search Query",
            info="The query to search for in the vector store.",
        ),
        HandleInput(name="embedding", display_name="Embedding", input_types=["Embeddings"]),
        StrInput(
            name="chroma_server_cors_allow_origins",
            display_name="Server CORS Allow Origins",
            advanced=True,
        ),
        StrInput(
            name="chroma_server_host",
            display_name="Server Host",
        ),
        IntInput(
            name="chroma_server_http_port",
            display_name="Server HTTP Port",
        ),
        IntInput(
            name="chroma_server_grpc_port",
            display_name="Server gRPC Port",
            advanced=True,
        ),
        BoolInput(
            name="chroma_server_ssl_enabled",
            display_name="Server SSL Enabled",
            advanced=True,
        ),
        BoolInput(
            name="allow_duplicates",
            display_name="Allow Duplicates",
            advanced=True,
            info="If false, will not add documents that are already in the Vector Store.",
        ),
        DropdownInput(
            name="search_type",
            display_name="Search Type",
            options=["Similarity", "MMR"],
            value="Similarity",
            advanced=True,
        ),
        IntInput(
            name="number_of_results",
            display_name="Number of Results",
            info="Number of results to return.",
            advanced=True,
            value=10,
        ),
        IntInput(
            name="limit",
            display_name="Limit",
            advanced=True,
            info="Limit the number of records to compare when Allow Duplicates is False.",
        ),
    ]
    outputs = [Output(display_name="Search Results", name="output", method="search")]

    @override
    @check_cached_vector_store
    def build_vector_store(self) -> Chroma:
        """Builds the Chroma object."""
        try:
            from chromadb import Client
            from langchain_chroma import Chroma
        except ImportError as e:
            msg = "Could not import Chroma integration package. Please install it with `pip install langchain-chroma`."
            raise ImportError(msg) from e
        # Chroma settings
        chroma_settings = None
        client = None
        if self.chroma_server_host:
            chroma_settings = Settings(
                chroma_server_cors_allow_origins=self.chroma_server_cors_allow_origins or [],
                chroma_server_host=self.chroma_server_host,
                chroma_server_http_port=self.chroma_server_http_port or None,
                chroma_server_grpc_port=self.chroma_server_grpc_port or None,
                chroma_server_ssl_enabled=self.chroma_server_ssl_enabled,
            )
            client = Client(settings=chroma_settings)

        # Check persist_directory and expand it if it is a relative path
        persist_directory = self.resolve_path(self.persist_directory) if self.persist_directory is not None else None
        
        chroma = Chroma(
            persist_directory=persist_directory,
            client=client,
            embedding_function=self.embedding,
            collection_name=self.collection_name,
        )

        self.status = chroma_collection_to_data(chroma.get(limit=self.limit))
        return chroma

    def search(self) -> Data:
        """Search the vector store for similar documents."""
        self._db = self.build_vector_store()
        docs = []
        query = self.search_query.get_text() 
        if isinstance(query, list):
            print(f"Search query : {query}") #TODO diagnostic remove later
            for q in query:
                embedding_vector = self.embedding.embed_query(q)
                doc = self._db.similarity_search_by_vector(embedding_vector, self.number_of_results)
                docs.extend(doc)
        else:
            embedding_vector = self.embedding.embed_query(query)
            docs = self._db.similarity_search_by_vector(embedding_vector, self.number_of_results)
        content = [doc.page_content for doc in docs]
        text = " ".join(content) if content else "No results found."
        print(f"Search results: {text}") #TODO diagnostic remove later
        return Data(value=text)