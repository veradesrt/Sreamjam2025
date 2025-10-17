extends Node3D

@onready var ball: Node3D = $ball
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ball_item_grabbed_destroy() -> void:
	PlayerData.has_beaten_game = true
	audio_stream_player_3d.play()
	PlayerData.get_player_ref().fade_system.fade_from_clear_to_black()

func _on_audio_stream_player_3d_finished() -> void:
	print("audio end")
	SceneChanger.request_scene_change("main_menu")
	
