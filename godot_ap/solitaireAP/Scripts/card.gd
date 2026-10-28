extends TextureRect
class_name Card
@export_range(1,13) var value: int = 1
@export_range(1,4) var suit: int = 1


func set_card(new_value: int, new_suit: int):
	self.value = new_value
	self.suit = new_suit
	self.texture = load("res://godot_ap/assets/cards.tres")
	var temp = AtlasTexture.new()
	temp.atlas = self.texture.atlas
	temp.region = self.texture.region
	self.texture = temp
	self.texture.region.position = Vector2(48*(self.value-1), 64*(self.suit-1))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_card(self.value, self.suit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _get_drag_data(position: Vector2):

	if !self.is_child_valid() and !self.is_stackable_slot(self):
		return null

	var preview = self.duplicate()
	preview.offset_transform_enabled = true
	preview.set_offset_transform_position(Vector2(-(self.custom_minimum_size.x/2), 0))
	set_drag_preview(preview)
	self.set_modulate(Color(1,1,1,0))
	return self

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and not self.is_drag_successful():
		self.set_modulate(Color(1,1,1,1))

#checks if the card just below this card is 
func is_child_valid() -> bool:
	var child_card = self.get_node("Target").get_children()
	if child_card.is_empty():
		return true
	child_card = child_card[0]

	if self.is_valid_placement(child_card):
		return child_card.is_child_valid();
	return false

#finds the lowest card in a stack of cards
func get_last_child() -> Card:
	var child_card = self.get_node("Target").get_children()
	if child_card.is_empty():
		return self
	else:
		return child_card[0].get_last_child()

#ran by target to see what the rules on placement are
func is_valid_placement(data: Card) -> bool:
	return (data.value + 1 == self.value) and ((self.suit < 3 and data.suit > 2) or (self.suit > 2 and data.suit < 3)) and self.is_stackable_slot(self)

#asks the slot if stacks can be moved
func is_stackable_slot(card: Card) -> bool:
	return self.get_parent().get_parent().is_stackable_slot(card)
