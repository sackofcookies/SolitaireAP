extends Node2D

var hearts = 13
var diamonds = 13
var spades = 13
var clubs = 13

var slots
var goals
var deckSlot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.slots = self.get_node("slots").get_children()
	self.goals = self.get_node("GoalStacks").get_children()
	self.deckSlot = self.get_node("DeckSlot")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_pressed() -> void:
	pass # Replace with function body.
