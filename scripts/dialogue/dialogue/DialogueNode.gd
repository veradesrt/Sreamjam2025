class_name DialogueNode
extends Control

const DIALOGUE_BASIC_SCENE : PackedScene = preload("uid://gt614lqfnysu")


var current_dialogue_running : DialogueProcess

func _enter_tree() -> void:
	DialogueGlobalEmitter.start_dialog.connect(start_dialogue)
	DialogueGlobalEmitter.force_end_dialog.connect(start_dialogue)


func start_dialogue(dialogue : Dialogue) -> void:
	if(current_dialogue_running != null):
		DialogueGlobalEmitter.already_running.emit()
		printerr("already running a dialogue")
	
	current_dialogue_running = DialogueProcess.new()
	current_dialogue_running.dialogue = dialogue

func loop() -> void:
	pass

func force_end_dialog() -> void:
	pass
