extends Node3D

@export var wood_placer : Node3D
@export var wood_planks : Node3D
@export var shadow_decal : Sprite3D
@export var plank_mesh : MeshInstance3D

@export var frontal_collision : CollisionShape3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plank_mesh.visible = false

func planks_placed() -> void:
	plank_mesh.visible = true
	frontal_collision.disabled = true

func planks_grabbed()->void:
	shadow_decal.visible = false

func enable_plank_grab()->void:
	wood_planks.interactable_node.switch(true)

func _process(delta: float) -> void:
	pass
