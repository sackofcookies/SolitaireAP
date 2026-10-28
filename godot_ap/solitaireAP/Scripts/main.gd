extends Node2D

var hearts = 13
var diamonds = 13
var spades = 13
var clubs = 13

var slots
var goals
var deckSlot: DeckSlot
var deck: Deck

var toStart = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.slots = self.get_node("slots").get_children()
	self.goals = self.get_node("GoalStacks").get_children()
	self.deckSlot = self.get_node("DeckSlot")
	self.deck = self.get_node("Deck")

func clean_up():
	for slot in self.slots:
		slot.initialize_slot()

	deckSlot.initialize_slot()
	
	for goal in goals:
		goal.initialize_goal()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.toStart:
		self.deck.initialize_Deck(self.hearts, self.diamonds, self.spades, self.clubs)
		for slot in slots:
			if slot.unlocked:
				for i in range(slot.slotNumber+1):
					self.deck.deal(slot.get_last_child().get_node("Target"))
		self.toStart = false


func _on_new_game_pressed() -> void:

	self.clean_up()
	self.toStart = true