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
	pass

func _end_tween():
	represents.visible = true
	self.queue_free()


func animate(from: Vector2, to: Vector2, card: Card):
	card.visible = false
	self.texture = card.texture
	self.represents = card
	self.global_position = from
	self.visible = true
	var tween = create_tween()
	tween.tween_property(self, "global_position", to, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(_end_tween)



