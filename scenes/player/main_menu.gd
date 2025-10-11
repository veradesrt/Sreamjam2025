extends Control

@onready var menu_container: Panel = $menu_container
@onready var dialogue_container: Control = $DialogueNode

@onready var player: Player = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close_all()
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func open_menu():
	player.change_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	menu_container.visible = true

func close_menu():
	player.change_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	menu_container.visible = false

func open_dialogue():
	player.change_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	dialogue_container.visible = true

func close_dialogue():
	player.change_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	dialogue_container.visible = false

func close_all():
	menu_container.visible = false
	#dialogue_container.visible = false
	player.change_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_resume_pressed() -> void:
	pass # Replace with function body.

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	pass # Replace with function body.
