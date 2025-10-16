extends Node3D

@onready var dialogue_emitter_3d: Node3D = $dialogue_emitter_3d

@onready var fade_system: fade_screen_system = $fade_system

func _ready() -> void:
	DialogueGlobalEmitter.has_ended.connect(dialogue_ended)
	dialogue_emitter_3d.start_dialogue()
	fade_system.force_set_screen_to_black()
	fade_system.fade_to_clear_ended.connect(clear_screen_ended)
	fade_system.fade_to_black_ended.connect(on_cutscene_end)
	fade_system.fade_from_black_to_clear()

func clear_screen_ended():
	pass

func dialogue_ended():
	fade_system.fade_from_clear_to_black()

func _process(delta: float) -> void:
	pass

func on_cutscene_end():
	print("text ended")
	SceneChanger.request_scene_change("main_level")
