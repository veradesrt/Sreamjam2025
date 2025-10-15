class_name DialogueHandler
extends Node

@export var movement_configuration : MovementConfiguration

func _enter_tree() -> void:
	DialogueGlobalEmitter.has_started.connect(is_on_dialogue)
	DialogueGlobalEmitter.has_ended.connect(is_out_dialogue)
	pass

func is_on_dialogue(d : Dialogue) -> void:
	
	if(movement_configuration and d.restriction_mode == Dialogue.RestrictionMode.ALL):
		movement_configuration.CAN_MOVE = false

func is_out_dialogue(d : Dialogue) -> void:
	
	
	if(movement_configuration and d.restriction_mode == Dialogue.RestrictionMode.ALL):
		movement_configuration.CAN_MOVE = true
