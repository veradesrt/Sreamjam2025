extends Node3D

@export var item_to_listen : String

signal correct_item_grabbed()

func _ready() -> void:
	PlayerData.get_inv_ref().new_item_added.connect(check_item_grabed)

func check_item_grabed(new_item:String)->void:
	print(new_item,item_to_listen)
	if new_item == item_to_listen:
		correct_item_grabbed.emit()

func _process(delta: float) -> void:
	pass
