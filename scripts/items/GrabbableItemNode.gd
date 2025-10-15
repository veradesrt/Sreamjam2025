extends Node3D

@onready var interactable_node: InteractableNode = $Components/InteractableNode


func _ready() -> void:
	interactable_node.interact.connect(delete)

func delete() -> void:
	queue_free()
