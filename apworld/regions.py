from __future__ import annotations

from typing import TYPE_CHECKING

from BaseClasses import Entrance, Region

if TYPE_CHECKING:
    from .world import SolitaireAPWorld


def create_all_regions(world: SolitaireAPWorld) -> None:
    board = Region("board", world.player, world.multiworld)