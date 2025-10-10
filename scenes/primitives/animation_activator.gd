extends Node3D

@export var trigger : Trigger
@export var animation_player : AnimationPlayer

func _ready() -> void:
	if trigger == null or animation_player == null:
		push_error("either trigger or animation player hasnt been set")

func _process(delta: float) -> void:
	pass

func trigger_signal_reciever() -> void:
	animation_player.play()
