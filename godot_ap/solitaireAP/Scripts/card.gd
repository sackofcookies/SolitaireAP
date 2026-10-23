extends TextureRect
class_name Card
@export_range(1,13) var value: int = 1
@export_range(1,4) var suit: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _get_drag_data(position: Vector2):

	if !self.is_child_valid():
		return null

	var preview = self.duplicate()

	set_drag_preview(preview)
	self.set_modulate(Color(1,1,1,0))
	return self

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and not self.is_drag_successful():
		self.set_modulate(Color(1,1,1,1))

func is_child_valid() -> bool:
	var child_card = self.get_node("Target").get_children()
	if child_card.is_empty():
		return true
	child_card = child_card[0]

	if (self.suit < 3 and child_card.suit > 2) or (self.suit > 2 and child_card.suit < 3):
		if child_card.value + 1 == self.value:
			return child_card.is_child_valid();
	return false

