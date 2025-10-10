class_name BasicBoxUI
extends DialogueBoxUI

@export var label : RichTextLabel

func set_text(text : String) -> void:
	label.text = text

func get_text() -> String:
	return label.text
