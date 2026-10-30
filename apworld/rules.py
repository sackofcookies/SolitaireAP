from __future__ import annotations

from typing import TYPE_CHECKING

from rule_builder.options import OptionFilter
from rule_builder.rules import Has, HasAll, Rule, HasFromList


if TYPE_CHECKING:
    from .world import SolitaireAPWorld


def set_all_rules(world: SolitaireAPWorld) -> None:
    set_all_location_rules(world)
    set_completion_condition(world)


def set_all_location_rules(world: SolitaireAPWorld) -> None:
    for i in range(3,14):
        world.set_rule(world.get_location(f"Goal Hearts {i}"), Has("Progressive Hearts", count=i-2))
        world.set_rule(world.get_location(f"Goal diamonds {i}"), Has("Progressive Diamonds", count=i-2))
        world.set_rule(world.get_location(f"Goal spades {i}"), Has("Progressive Spades", count=i-2))
        world.set_rule(world.get_location(f"Goal clubs {i}"), Has("Progressive Clubs", count=i-2))

    world.set_rule(world.get_location("Complete 10 card game"), HasFromList("Progressive Hearts","Progressive Diamonds","Progressive Spades","Progressive Clubs", count=2))
    world.set_rule(world.get_location("Complete 20 card game"), HasFromList("Progressive Hearts","Progressive Diamonds","Progressive Spades","Progressive Clubs", count=12))
    world.set_rule(world.get_location("Complete 30 card game"), HasFromList("Progressive Hearts","Progressive Diamonds","Progressive Spades","Progressive Clubs", count=22))
    world.set_rule(world.get_location("Complete 40 card game"), HasFromList("Progressive Hearts","Progressive Diamonds","Progressive Spades","Progressive Clubs", count=32))
    world.set_rule(world.get_location("Complete 50 card game"), HasFromList("Progressive Hearts","Progressive Diamonds","Progressive Spades","Progressive Clubs", count=42))

def set_completion_condition(world: SolitaireAPWorld) -> None:
    world.set_completion_rule(HasFromList("Progressive Hearts","Progressive Diamonds","Progressive Spades","Progressive Clubs", count=44))

    
    