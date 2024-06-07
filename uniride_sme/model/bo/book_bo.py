"""Book business object module"""
from dataclasses import dataclass
from datetime import datetime
from typing import Optional


@dataclass
class BookBO:  # pylint: disable=too-many-instance-attributes
    """Book business object class"""

    user_id: Optional[int] = None
    trip_id: Optional[int] = None
    accepted: Optional[int] = None
    passenger_count: Optional[int] = None
    date_requested: Optional[datetime] = None
    joined: Optional[bool] = None
    verification_code: Optional[int] = None
