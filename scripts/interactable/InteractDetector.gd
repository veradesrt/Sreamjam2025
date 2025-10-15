class_name InteractDetector
extends Node3D


@export var enable_show_name : bool = false
@export var raycast_scale : float = 1.0


@onready var ray_cast: RayCast3D = $RayCast3D
@onready var label_name: Label = $Control/CenterContainer/VBoxContainer/Label

var current_interactable_node : InteractableNode

signal is_touching
signal not_touching

var current_state_touching : bool = false
var previous_state_touching : bool = false

func _ready() -> void:
	ray_cast.target_position.x = raycast_scale

func _process(delta: float) -> void:
	
	if (ray_cast.is_colliding()):
		current_state_touching = true
	else:
		current_state_touching = false
	
	
	if(current_state_touching != previous_state_touching):
		if(current_state_touching):
			current_interactable_node = ray_cast.get_collider() as InteractableNode
			is_touching.emit()
			current_interactable_node._on_contact()
		else:
			not_touching.emit()
			current_interactable_node._out_of_contact()
			current_interactable_node = null
			label_name.hide()
		
		if(current_state_touching and enable_show_name):
			label_name.text = current_interactable_node.interactable_name
			label_name.show()
			
		previous_state_touching = current_state_touching
	
	if(Input.is_action_just_pressed("enter") and current_state_touching):
		current_interactable_node._interact()
