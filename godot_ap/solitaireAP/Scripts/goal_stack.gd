extends TextureRect

var topCard = 0
@export_range(1,4) var suit = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.initialize_goal()
	

func initialize_goal():
	self.topCard = 0
	self.texture = load("res://godot_ap/assets/cards.tres")
	var temp = AtlasTexture.new()
	temp.atlas = self.texture.atlas
	temp.region = self.texture.region
	self.texture = temp
	self.texture.region.position = Vector2(0, 64*(self.suit-1))
	self.set_modulate(Color(0.5,0.5,0.5,1.0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func sink():
	self.set_modulate(Color(1,1,1,1.0))
	topCard += 1
	if Archipelago.status == Archipelago.APStatus.PLAYING:
		Archipelago.collect_location(topCard + ((suit-1)*13))
	self.texture.region.position = Vector2(48*(topCard-1), 64*(self.suit-1))

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data.suit == self.suit and data.value == (self.topCard + 1):
		return true
	else:
		return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	self.sink()
	data.queue_free()

