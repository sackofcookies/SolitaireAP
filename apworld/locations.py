from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import ItemClassification, Location

from . import items

if TYPE_CHECKING:
    from .world import SolitaireAPWorld


LOCATION_NAME_TO_ID = {}

for i in range(1,14):
    LOCATION_NAME_TO_ID[f"Goal Hearts {i}"] = i
    LOCATION_NAME_TO_ID[f"Goal diamonds {i}"] = i + 13
    LOCATION_NAME_TO_ID[f"Goal spades {i}"] = i + 26
    LOCATION_NAME_TO_ID[f"Goal clubs {i}"] = i + 39

LOCATION_NAME_TO_ID["Complete 10 card game"] = 53
LOCATION_NAME_TO_ID["Complete 20 card game"] = 54
LOCATION_NAME_TO_ID["Complete 30 card game"] = 55
LOCATION_NAME_TO_ID["Complete 40 card game"] = 56
LOCATION_NAME_TO_ID["Complete 50 card game"] = 57
LOCATION_NAME_TO_ID["Complete 52 card game"] = 58


class SolitaireAPLocation(Location):
    game = "SolitaireAP"

def get_location_names_with_ids(location_names: list[str]) -> dict[str, int | None]:
    return {location_name: LOCATION_NAME_TO_ID[location_name] for location_name in location_names}


def create_all_locations(world: SolitaireAPWorld) -> None:
    create_regular_locations(world)


def create_regular_locations(world: SolitaireAPWorld) -> None:
    board = world.get_region("board")

    board.add_locations(LOCATION_NAME_TO_ID, SolitaireAPLocation)