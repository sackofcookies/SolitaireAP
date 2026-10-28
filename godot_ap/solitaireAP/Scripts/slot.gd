extends ColorRect

class_name Slot

@export_range(0,6) var slotNumber: int = 0
var unlocked = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if unlocked:
		self.set_color(Color(1,1,1,1))
	else:
		self.set_color(Color(1,1,1,0))

func is_valid_placement(data: Card) -> bool:
	return unlocked

func _get_drag_data(position: Vector2):
	return null

func get_last_child():
	var child_card = self.get_node("Target").get_children()
	if child_card.is_empty():
		return self
	else:
		return child_card[0].get_last_child()

func is_stackable_slot(_card: Card):
	return true

func initialize_slot():
	var temp = self.get_node("Target").get_children()
	for card in temp:
		card.queue_free()