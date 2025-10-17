extends Node3D

@onready var grab_items_warning: DialogueEmitter3D = $"../grab_items_warning"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_object_list_item_grabbed_destroy() -> void:
	grab_items_warning.queue_free()
