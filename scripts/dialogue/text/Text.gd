class_name Text
extends Resource

enum Mode{BASIC}

@export_multiline var content : String
@export var centered : bool = true

@export_group("Skip")
@export var enable_skip : bool = true
@export var finish_time : float = 1.0

@export_group("Typewrite")
@export var enable_typewrite : bool = true
@export var speed : float = 1.0
@export var can_skip_write : bool = true
