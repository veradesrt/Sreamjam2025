class_name CrosshairNode
extends Node3D

enum CrosshairMode{TEXTURE,COLOR}

@onready var texture: TextureRect = $Control/CenterContainer/Texture
@onready var color_rect: ColorRect = $Control/CenterContainer/ColorRect

@export var on : bool = true : set = turn
@export var interactable_detector_reference : InteractDetector
@export var crosshair_mode : CrosshairMode = CrosshairMode.COLOR

##TODO: seguir implementando el modo textura despues wacho

func _ready() -> void:
	interactable_detector_reference.is_touching.connect(is_interacting)
	interactable_detector_reference.not_touching.connect(not_interacting)

func turn(state : bool) -> void:
	if(state):
		show()
	else:
		hide()
	on = state

func is_interacting() -> void:
	switch_crosshair(true)

func not_interacting() -> void:
	switch_crosshair(false)

func switch_crosshair(state : bool) -> void:
	match(crosshair_mode):
		CrosshairMode.TEXTURE:
			pass
		CrosshairMode.COLOR:
			if(state):
				color_rect.custom_minimum_size = Vector2(16,16)
			else:
				color_rect.custom_minimum_size = Vector2(8,8)
