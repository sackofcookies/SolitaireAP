extends Sprite2D

class_name MovingCard

var value = 1
var suit = 1
var target: Vector2
var speed = 500
var active = false
var represents: Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and !self.is_queued_for_deletion():
		if represents == null:
			self.queue_free()
			return
		if position != self.target:
			self.position = self.position.move_toward(self.target, speed*delta)
		else:
			represents.visible = true
			self.queue_free()



func set_card(new_value: int, new_suit: int):
	self.value = new_value
	self.suit = new_suit
	self.texture = load("res://godot_ap/assets/cards.tres")
	var temp = AtlasTexture.new()
	temp.atlas = self.texture.atlas
	temp.region = self.texture.region
	self.texture = temp
	self.texture.region.position = Vector2(48*(self.value-1), 64*(self.suit-1))

func animate(from: Vector2, to: Vector2, card: Card):
	card.visible = false
	self.set_card(card.value, card.suit)
	self.represents = card
	self.position = from
	self.target = to
	self.visible = true
	self.active = true
