extends Node3D

@onready var interactable_node: InteractableNode = $Components/InteractableNode

func _ready() -> void:
	interactable_node.last_interact.connect(evaluate_interaction)

## used to check first if this item should pass some check to be grabbed
func evaluate_interaction():
	if interactable_node.interactable_conditional == null:
		delete()
		return
	if interactable_node.interactable_conditional.conditional():
		delete()
		print("conditional passed")
	else:
		print("conditional failed")

func delete() -> void:
	queue_free()
