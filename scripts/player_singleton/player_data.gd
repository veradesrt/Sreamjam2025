extends Node

var mouse_sensitivity : float = 0.001

var master_audio_db : float = 0
var sfx_audio_db : float = 0

var player_ref : Player
var inventory_ref : InventoryNode

var has_beaten_game : bool = false

signal mouse_sens_changed()


func _ready() -> void:
	
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func set_mouse_sensitivity(new_value:float)->void:
	mouse_sensitivity = new_value
	mouse_sens_changed.emit(mouse_sensitivity)

func get_mouse_sensitivity()->float:
	return mouse_sensitivity

func set_master_audio(new_master_db:float)->void:
	master_audio_db = new_master_db

func get_master_audio()->float:
	return master_audio_db

func set_player_ref(new_pl:Player)->void:
	player_ref = new_pl
func get_player_ref()->Player:
	return player_ref

func set_inv_ref(inv:InventoryNode)->void:
	inventory_ref = inv
func get_inv_ref()->InventoryNode:
	return inventory_ref
