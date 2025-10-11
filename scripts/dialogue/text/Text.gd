class_name Text
extends Resource

enum Mode{BASIC}

@export_multiline var content : String
@export var centered : bool = true
@export var initial_letter : int = 0

@export_group("Skip")
@export var enable_skip : bool = true
@export var can_auto_skip : bool = false
@export var skip_time : float = 2.0

@export_group("Typewrite")
@export var enable_typewrite : bool = true
@export var typewrite_speed : float = 0.1
@export var letters_per_write : int = 1
@export var can_skip_write : bool = true
