class_name DialogueHandler
extends Node

@export var movement_configuration : MovementConfiguration

func _enter_tree() -> void:
	DialogueGlobalEmitter.has_started.connect(is_on_dialogue)
	pass

func is_on_dialogue() -> void:
	if(movement_configuration):
		movement_configuration.CAN_MOVE = false

func is_out_dialogue() -> void:
	if(movement_configuration):
		movement_configuration.CAN_MOVE = true
