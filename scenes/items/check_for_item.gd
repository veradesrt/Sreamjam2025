extends Node3D

@export var item_needed : ItemData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func conditional()->bool:
	var inv_ref : InventoryNode = PlayerData.get_inv_ref()
	var check :bool = inv_ref.Items.has(item_needed)
	return check
