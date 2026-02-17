"""
    Add Metadata Component
"""
from datetime import datetime
from zoneinfo import ZoneInfo

from langflow.custom import Component
from langflow.io import MessageTextInput, Output
from langflow.schema import Data


class AddMetadata(Component):
    """
        Add Metadata to the output of a component.
    """
    display_name = "Add Metadata"
    description = "Add Metadata to the output of a component."
    documentation: str = "http://docs.langflow.org/components/custom"
    icon = "code"
    name = "AddMetadata"
    status = None

    inputs = [
        MessageTextInput(
            name="author",
            display_name="Soumik Das",
            info="This is a custom component Input to define the Author Name",
            value="Soumik Das",
            tool_mode=True,
        ),
    ]

    outputs = [
        Output(display_name="Output", name="output", method="build_output"),
    ]

    def build_output(self) -> Data:
        """
            Build the output with metadata.
        """
        tz = ZoneInfo("UTC")
        data = Data(
            data={
            "author": self.author, 
            "updated_at": datetime.now(tz).strftime("%Y-%m-%d %H:%M:%S %Z")
        })
        self.status = data
        return data
