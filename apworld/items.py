from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import Item, ItemClassification

if TYPE_CHECKING:
    from .world import SolitaireAPWorld


ITEM_NAME_TO_ID = {}

ITEM_NAME_TO_ID["Progressive Hearts"] = 1
ITEM_NAME_TO_ID["Progressive Diamonds"] = 2
ITEM_NAME_TO_ID["Progressive Spades"] = 3
ITEM_NAME_TO_ID["Progressive Clubs"] = 4

for i in range(3,8):
    ITEM_NAME_TO_ID[f"Slot {i}"] = i + 2

ITEM_NAME_TO_ID["Storage Slot"] = 11
ITEM_NAME_TO_ID["super cool item"] = 12

class SolitaireAPItem(Item):
    game = "SolitaireAP"


def create_item_with_correct_classification(world: SolitaireAPWorld, name: str) -> SolitaireAPItem:
    return SolitaireAPItem(name, ItemClassification.progression, ITEM_NAME_TO_ID[name], world.player)

def create_all_items(world: SolitaireAPWorld) -> None:
    itempool: list[Item] = []

    for i in range(1,12):
        itempool.append(world.create_item("Progressive Hearts"))
        itempool.append(world.create_item("Progressive Diamonds"))
        itempool.append(world.create_item("Progressive Spades"))
        itempool.append(world.create_item("Progressive Clubs"))

    for i in range(3,8):
        itempool.append(world.create_item(f"Slot {i}"))

    itempool.append(world.create_item("Storage Slot"))


    number_of_items = len(itempool)
    number_of_unfilled_locations = len(world.multiworld.get_unfilled_locations(world.player))
    needed_number_of_filler_items = number_of_unfilled_locations - number_of_items

    itempool += [world.create_filler() for _ in range(needed_number_of_filler_items)]
    
    world.multiworld.itempool += itempool

