extends Node2D

var hearts = 13
var diamonds = 13
var spades = 13
var clubs = 13

var slots
var goals
var deckSlot: DeckSlot
var deck: Deck
var storeSlot: StoreSlot
var autoButt

var toStart = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.slots = self.get_node("slots").get_children()
	self.goals = self.get_node("GoalStacks").get_children()
	self.deckSlot = self.get_node("DeckSlot")
	self.deck = self.get_node("Deck")
	self.storeSlot = self.get_node("StoreSlot")
	self.autoButt = self.get_node("AutoButton")

func clean_up():
	for slot in self.slots:
		slot.initialize_slot()

	deckSlot.initialize_slot()
	storeSlot.initialize_slot()
	
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

	if autoButt.button_pressed:
		var temp = deckSlot.get_last_child()
		if temp != deckSlot and temp.value == goals[temp.suit-1].topCard+1:
			temp.queue_free()
			goals[temp.suit-1].sink()
		temp = storeSlot.get_last_child()
		if temp != storeSlot and temp.value == goals[temp.suit-1].topCard+1:
			temp.queue_free()
			goals[temp.suit-1].sink()
		for slot in slots:
			var card = slot.get_last_child()
			if card != slot and card.value == goals[card.suit-1].topCard+1:
				card.queue_free()
				goals[card.suit-1].sink()


func _on_new_game_pressed() -> void:

	self.clean_up()
	self.toStart = true