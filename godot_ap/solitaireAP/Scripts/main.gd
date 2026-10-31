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
var midgame = false

var heartsItems: Array
var diamondsItems: Array
var spadesItems: Array
var clubsItems: Array
var slotsItems: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.slots = self.get_node("slots").get_children()
	self.goals = self.get_node("GoalStacks").get_children()
	self.deckSlot = self.get_node("DeckSlot")
	self.deck = self.get_node("Deck")
	self.storeSlot = self.get_node("StoreSlot")
	self.autoButt = self.get_node("AutoButton")
	Archipelago.connected.connect(_on_connected)
	Archipelago.disconnected.connect(_on_disconnected)

func _on_disconnected():
	heartsItems.clear()
	diamondsItems.clear()
	spadesItems.clear()
	clubsItems.clear()
	slotsItems.clear()
	self.clean_up()

func _on_connected(conn, json):
	Archipelago.conn.obtained_item.connect(_on_obtained_item)


func _on_obtained_item(item):
	self._add_item(item)


func _add_item(item: NetworkItem):
	if item.id == 1:
		heartsItems.append(item)
	if item.id == 2:
		diamondsItems.append(item)
	if item.id == 3:
		spadesItems.append(item)
	if item.id == 4:
		clubsItems.append(item)
	
	if item.id > 4 and item.id < 12:
		slotsItems.append(item)



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
		if Archipelago.status == Archipelago.APStatus.PLAYING:
			
			for i in range(3,8):
				self.slots[i-1].unlocked = false
			self.storeSlot.unlocked = false
			for slot in slotsItems:
				if slot.id == 11:
					self.storeSlot.unlocked = true
				else:
					self.slots[slot.id-3].unlocked = true

			hearts = 2
			hearts += heartsItems.size()	
			diamonds = 2
			diamonds += diamondsItems.size()
			spades = 2
			spades += spadesItems.size()
			print(spadesItems)
			clubs = 2
			clubs += clubsItems.size()
			
		self.deck.initialize_Deck(self.hearts, self.diamonds, self.spades, self.clubs)
		for slot in slots:
			if slot.unlocked:
				for i in range(slot.slotNumber+1):
					self.deck.deal(slot.get_last_child().get_node("Target"))
		self.toStart = false
		midgame = true

	if midgame:
		var won = true
		for slot in slots:
			if slot.get_last_child() != slot:
				won = false
		if !deck.cards.is_empty():
			won = false
		if deckSlot.get_last_child() != deckSlot:
			won = false
		if storeSlot.get_last_child() != storeSlot:
			won = false

		if won and Archipelago.status == Archipelago.APStatus.PLAYING:
			var total = hearts + spades + diamonds + clubs
			if total >= 10:
				Archipelago.collect_location(53) 
			if total >= 20:
				Archipelago.collect_location(54) 
			if total >= 30:
				Archipelago.collect_location(55)
			if total >= 40:
				Archipelago.collect_location(56)  
			if total >= 50:
				Archipelago.collect_location(57)
			if total >= 52:
				Archipelago.collect_location(58)  
				Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_GOAL)

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
