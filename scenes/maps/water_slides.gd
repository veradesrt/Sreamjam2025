extends Node3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var steps_trigger: Trigger = $steps_trigger

@onready var down: Marker3D = $down
@onready var up: Marker3D = $up

var player_ref

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func warp_to_top()->void:
	player_ref = PlayerData.get_player_ref()
	player_ref.global_position = up.global_position

func warp_to_bottom()->void:
	player_ref = PlayerData.get_player_ref()
	player_ref.global_position = down.global_position


func _on_steps_trigger_player_entered() -> void:
	audio_stream_player_3d.play()
