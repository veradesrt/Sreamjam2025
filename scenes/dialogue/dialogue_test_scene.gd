extends CanvasLayer

@export var dialogue : Dialogue

func _ready() -> void:
	DialogueGlobalEmitter.start_dialogue.emit(dialogue)
	pass
	
