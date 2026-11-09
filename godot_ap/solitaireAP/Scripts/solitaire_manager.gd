extends Node

class VariantItems:
	var slots: Array = []
	var cards: Dictionary = {}
	var storage: bool = false
		

var recievedItems: Dictionary = {}


signal deathlink(source: String, cause: String, json: Dictionary)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Archipelago.connected.connect(_on_connected)

func _on_connected(conn, json):
	Archipelago.conn.obtained_item.connect(_on_obtained_item)
	Archipelago.conn.deathlink.connect(_on_deathlink)

func _on_deathlink(source: String, cause: String, json: Dictionary):
	deathlink.emit(source, cause, json)


# Variant: Progressive suitName
#or
# Variant: Slot number
#or
# Variant: Storage Slot
func _on_obtained_item(item: NetworkItem):
	var temp = item.get_name()
	temp = temp.split(" ", false)
	var variantName = temp[0].rStrip(":")

	if !recievedItems.has(variantName):
		recievedItems.set(variantName, VariantItems)

	if temp[1] == "Progressive":
		if !recievedItems.get(variantName).cards.has(temp[2]):
			recievedItems.get(variantName).cards.set(temp[2], 0)
		recievedItems.get(variantName).cards.set(temp[2], recievedItems.get(variantName).cards.get(temp[2]) + 1)
	elif temp[1] == "Slot":
		recievedItems.get(variantName).slots.append(temp[2].to_int())		
	elif temp[1] == "Storage":
		recievedItems.get(variantName).storage = true
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
