extends TextureRect

#array of cards represented by vectors (suit, value)
var cards: Array[Vector2i] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func deal(location: Target):
	if !cards.is_empty():
		var temp = Card.new()
		temp.suit = cards[0].x
		temp.value = cards[0].y
		cards.remove_at(0)
		location.add_child(temp)
