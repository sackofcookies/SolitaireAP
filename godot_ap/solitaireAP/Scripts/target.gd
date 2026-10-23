extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data == self.get_parent() or data.is_ancestor_of(self) or (data.value + 1 != self.get_parent().value):
		return false
	return self.get_children().is_empty()

func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.set_modulate(Color(1,1,1,1))
	data.get_parent().remove_child(data)
	self.add_child(data)