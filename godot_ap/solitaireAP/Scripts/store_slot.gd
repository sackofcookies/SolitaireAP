extends Slot

class_name  StoreSlot

var uncovered = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func initialize_slot():
	uncovered = false
	super()

func is_valid_placement(data: Card) -> bool:
	return unlocked and uncovered

func is_stackable_slot(card: Card):
	return false