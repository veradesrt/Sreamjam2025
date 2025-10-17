extends Node3D

@export var new_dialogue : Dialogue
@export var dialogue_emiter : DialogueEmitter3D

func _ready() -> void:
	pass # Replace with function body.

func change_dialogue()->void:
	dialogue_emiter.dialogue = new_dialogue


func _process(delta: float) -> void:
	pass
