extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_valid_placement(data: Card) -> bool:
	return true

func _get_drag_data(position: Vector2):
	return null

func get_last_child():
	var child_card = self.get_node("Target").get_children()
	if child_card.is_empty():
		return self
	else:
		return child_card[0].get_last_child()
