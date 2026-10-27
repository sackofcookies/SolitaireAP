extends TextureButton

@export var deckSlot: Control
@export var card: PackedScene

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
		var temp: Card = card.instantiate() as Card
		print(temp.suit)
		location.add_child(temp)
		temp.set_card(cards[0].y, cards[0].x)
		cards.remove_at(0)



func _pressed() -> void:
	self.deal(deckSlot.get_last_child().get_node("Target"))
	self.deal(deckSlot.get_last_child().get_node("Target"))
	self.deal(deckSlot.get_last_child().get_node("Target"))
