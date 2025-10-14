extends Node

var mouse_sensitivity : float = 0.001

var master_audio_db : float = 0
var sfx_audio_db : float = 0

signal mouse_sens_changed()
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func set_mouse_sensitivity(new_value:float)->void:
	mouse_sensitivity = new_value
	mouse_sens_changed.emit()

func get_mouse_sensitivity()->float:
	return mouse_sensitivity

func set_master_audio(new_master_db:float)->void:
	master_audio_db = new_master_db

func get_master_audio()->float:
	return master_audio_db
