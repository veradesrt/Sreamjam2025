extends Node3D

@onready var dialogue_emitter_3d: Node3D = $dialogue_emitter_3d

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueGlobalEmitter.has_ended.connect(on_cutscene_end)
	dialogue_emitter_3d.start_dialogue()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_cutscene_end():
	print("text ended")
	SceneChanger.request_scene_change("main_level")
