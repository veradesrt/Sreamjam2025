class_name InventoryNode
extends Node

@export var Items : Array[ItemData] = []

func add_item(item : ItemData) -> void:
	print("item added to inventory")
	Items.append(item)
	
