extends TextureButton

@export var deckSlot: Control

#array of cards represented by vectors (suit, value)
var cards: Array[Vector2i] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		for j in range(12):
			cards.append(Vector2i(i+1,j+1))
	cards.shuffle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cards.is_empty():
		self.hide()

func deal(location: Target):
	if !cards.is_empty():
		var temp = load("res://godot_ap/solitaireAP/Scenes/Card.tscn")
		add_child(temp)
		var card = get_children()[0]
		card.suit = cards[0].x
		card.value = cards[0].y
		cards.remove_at(0)
		location.add_child(card)


func _pressed() -> void:
	self.deal(deckSlot.get_last_child().get_node("Target"))
