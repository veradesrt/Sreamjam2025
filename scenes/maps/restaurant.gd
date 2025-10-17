extends Node3D

@onready var key_silla_1: MeshInstance3D = $props/mesa_redonda6/KEY_SILLA
@onready var key_silla_2: MeshInstance3D = $props/mesa_redonda7/KEY_SILLA_2
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $props/AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mask_item_grabbed_destroy() -> void:
	audio_stream_player_3d.play()
	key_silla_1.visible = false
	key_silla_2.visible = true
