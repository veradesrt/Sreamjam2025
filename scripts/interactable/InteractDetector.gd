class_name InteractDetector
extends Node3D

@onready var ray_cast: RayCast3D = $RayCast3D

var current_interactable_node : InteractableNode

signal is_touching
signal not_touching

var current_state_touching : bool = false
var previous_state_touching : bool = false

func _process(delta: float) -> void:
	
	if (ray_cast.is_colliding()):
		current_state_touching = true
	else:
		current_state_touching = false
	
	
	if(current_state_touching != previous_state_touching):
		if(current_state_touching):
			current_interactable_node = ray_cast.get_collider() as InteractableNode
			is_touching.emit()
			current_interactable_node.on_contact.emit()
		else:
			not_touching.emit()
			current_interactable_node.out_of_contact.emit()
			current_interactable_node = null
		previous_state_touching = current_state_touching
	
	if(Input.is_action_just_pressed("enter") and current_state_touching):
		current_interactable_node.interact.emit()
