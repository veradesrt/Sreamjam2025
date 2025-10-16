extends Control

@onready var menu_container: Panel = $menu_container
@onready var dialogue_container: Control = $DialogueNode
@onready var options: Control = $options

@onready var player: Player = $".."

@onready var mouse_sensitivity: HSlider = $options/Panel/VBoxContainer/mouse_sens/mouse_sensitivity
@onready var mouse_sens_value: Label = $options/Panel/VBoxContainer/mouse_sens/mouse_sensitivity/mouse_sens_value

@onready var master_audio: HSlider = $options/Panel/VBoxContainer/master_sound/master_audio
@onready var audio_value: Label = $options/Panel/VBoxContainer/master_sound/master_audio/audio_value
@onready var sfx_audio: HSlider = $options/Panel/VBoxContainer/sfx_sound/sfx_audio
@onready var audio_sfx_value: Label = $options/Panel/VBoxContainer/sfx_sound/sfx_audio/audio_SFX_value

var local_mouse_sens : float = 0

func _ready() -> void:
	close_all()
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

## get the current mouse sensitivity from the player and set it into the UI
func set_mouse_sensitivity_from_player():
	var sens = player.mouse_sens
	local_mouse_sens = sens
	mouse_sensitivity.value = sens
	mouse_sens_value.text = str( sens )

## called from the player when u want to open/close the menu
func menu_update_request():
	if menu_container.visible:
		close_all()
	else:
		open_menu()

func open_menu():
	player.change_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	menu_container.visible = true

func close_menu():
	player.change_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	menu_container.visible = false

func open_options():
	set_mouse_sensitivity_from_player()
	options.visible = true

func close_options():
	options.visible = false

func open_dialogue():
	player.change_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	dialogue_container.visible = true

func close_dialogue():
	player.change_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	dialogue_container.visible = false

func close_all():
	menu_container.visible = false
	#dialogue_container.visible = false
	options.visible = false
	player.change_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_resume_pressed() -> void:
	close_menu()

func _on_options_pressed() -> void:
	open_options()

func _on_exit_pressed() -> void:
	SceneChanger.request_scene_change("main_menu")

func _on_mouse_sensitivity_value_changed(value: float) -> void:
	local_mouse_sens = value
	PlayerData.set_mouse_sensitivity(local_mouse_sens)
	mouse_sens_value.text = str( local_mouse_sens )
	

func _on_master_audio_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)
	audio_value.text = str(value)
	print("chage audio")

func _on_sfx_audio_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value)
	audio_sfx_value.text = str(value)
