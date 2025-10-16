class_name Dialogue
extends Resource

enum DialogueMode{BASIC}
enum RestrictionMode{NONE , ALL}

@export var dialogue : Array[Text]
@export var dialogue_mode : DialogueMode = DialogueMode.BASIC
@export var restriction_mode : RestrictionMode = RestrictionMode.ALL
