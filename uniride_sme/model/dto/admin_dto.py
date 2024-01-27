"""DTO for AdminBO"""
from typing import TypedDict


class AdminInfosDTO(TypedDict):
    """DTO for Admin's informations"""

    id: int
    firstname: str
    lastname: str
    role: int
    profile_picture: str
    timestamp_creation: str
    timestamp_modification: str