extends TextureButton

class_name Deck

@export var deckSlot: Control
@export var card: PackedScene
@export var storeSlot: StoreSlot
@export var movingCard: PackedScene

#array of cards represented by vectors (suit, value)
var cards: Array[Vector2i] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func initialize_Deck(hearts: int, diamonds: int, spades: int, clubs: int):
	cards.clear()
	for i in range (hearts):
		cards.append(Vector2i(1,i+1))
	for i in range (diamonds):
		cards.append(Vector2i(2,i+1))
	for i in range (spades):
		cards.append(Vector2i(3,i+1))
	for i in range (clubs):
		cards.append(Vector2i(4,i+1))
	cards.shuffle()
	self.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cards.is_empty():
		storeSlot.uncovered = true
		self.hide()

func deal(location: Target):
	if !cards.is_empty():
		var temp: Card = card.instantiate() as Card
		var animate: MovingCard = movingCard.instantiate() as MovingCard
		location.add_child(temp)
		self.add_child(animate)
		temp.set_card(cards[0].y, cards[0].x)
		var to = temp.get_node("Target").global_position
		#to.x = to.x - temp.get_maximum_size().x
		animate.animate(self.position, to, temp)
		cards.remove_at(0)



func _pressed() -> void:
	self.deal(deckSlot.get_last_child().get_node("Target"))
	self.deal(deckSlot.get_last_child().get_node("Target"))
	self.deal(deckSlot.get_last_child().get_node("Target"))
