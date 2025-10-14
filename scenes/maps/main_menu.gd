extends Node3D

@onready var options: Control = $UI/options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	SceneChanger.request_scene_change("cutscene")

func _on_settings_pressed() -> void:
	enable_options_menu()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	pass # Replace with function body.

func enable_options_menu():
	options.visible = true
func disable_options_menu():
	options.visible = false
