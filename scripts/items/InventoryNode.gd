class_name InventoryNode
extends Node

@export var Items : Array[ItemData] = []

signal new_item_added(item_name:String)

func add_item(item : ItemData) -> void:
	#print("item added to inventory ",item.name)
	if item == null:
		push_warning("invalid item")
		return
	Items.append(item)
	new_item_added.emit(item.name)
