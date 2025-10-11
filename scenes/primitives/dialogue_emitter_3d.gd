extends Node3D
## add the text resource for dialogue
@export var dialogue : Dialogue


func start_dialogue():
	## upon the calling of this fuction, emitt a signal for the singleton to activate dialogue
	DialogueGlobalEmitter.start_dialogue.emit(dialogue)
