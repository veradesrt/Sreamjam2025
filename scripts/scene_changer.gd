extends Node

const MAIN_MENU = preload("uid://cm5fdk81bqipp")
const CUTSCENE = preload("uid://dm8k7cg8r2lwo")
const MAIN_LEVEL = preload("uid://c78bdq77ygnhk")


func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func request_scene_change(scene_name:String):
	if scene_name == "main_menu":
		get_tree().change_scene_to_packed(MAIN_MENU)
	elif scene_name == "cutscene":
		get_tree().change_scene_to_packed(CUTSCENE)
	elif scene_name == "main_level":
		get_tree().change_scene_to_packed(MAIN_LEVEL)
