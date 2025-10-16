extends Node3D

@onready var options: Control = $UI/options
@onready var credits: Control = $UI/credits

@onready var hover_sound: AudioStreamPlayer = $hover_sound
@onready var click_sound: AudioStreamPlayer = $click_sound
@onready var fade_system: fade_screen_system = $UI/fade_system

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_system.force_set_screen_to_clear()
	fade_system.fade_to_black_ended.connect(change_scene_to_cutscene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	SceneChanger.play_sound_across_scenes()
	fade_system.fade_from_clear_to_black()

func change_scene_to_cutscene():
	SceneChanger.request_scene_change("cutscene")

func _on_settings_pressed() -> void:
	click_sound.pitch_scale = 1
	click_sound.play()
	enable_options_menu()

func _on_exit_pressed() -> void:
	click_sound.pitch_scale = 1
	click_sound.play()
	get_tree().quit()

func _on_credits_pressed() -> void:
	click_sound.pitch_scale = 1
	click_sound.play()
	credits.visible=true

func enable_options_menu():
	options.visible = true
func disable_options_menu():
	options.visible = false

func on_hover_sound()->void:
	hover_sound.play()

func _on_close_options_pressed() -> void:
	click_sound.pitch_scale = 0.5
	click_sound.play()
	disable_options_menu()

func _on_close_credits_pressed() -> void:
	click_sound.pitch_scale = 0.5
	click_sound.play()
	credits.visible=false
