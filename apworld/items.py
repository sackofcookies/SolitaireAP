from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import Item, ItemClassification

if TYPE_CHECKING:
    from .world import SolitaireAPWorld


ITEM_NAME_TO_ID = {}
DEFAULT_ITEM_CLASSIFICATIONS = {}

for i in range(3,14):
    ITEM_NAME_TO_ID["Progressive Hearts"] = i
    ITEM_NAME_TO_ID["Progressive Diamonds"] = i + 13
    ITEM_NAME_TO_ID["Progressive Spades"] = i + 26
    ITEM_NAME_TO_ID["Progressive Clubs"] = i + 39

for i in range(3,8):
    ITEM_NAME_TO_ID[f"Slot {i}"] = i + 52

ITEM_NAME_TO_ID["Storage Slot"] = 61

class SolitaireAPItem(Item):
    game = "SolitaireAP"


def create_item_with_correct_classification(world: SolitaireAPWorld, name: str) -> SolitaireAPItem:
    return SolitaireAPItem(name, ItemClassification.progression, ITEM_NAME_TO_ID[name], world.player)

def create_all_items(world: SolitaireAPWorld) -> None:
    itempool: list[Item] = []
    for item in ITEM_NAME_TO_ID:
        itempool.append(world.create_item(item))

    number_of_items = len(itempool)
    number_of_unfilled_locations = len(world.multiworld.get_unfilled_locations(world.player))
    needed_number_of_filler_items = number_of_unfilled_locations - number_of_items

    itempool += [world.create_filler() for _ in range(needed_number_of_filler_items)]
    
    world.multiworld.itempool += itempool

