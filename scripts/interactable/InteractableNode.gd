class_name InteractableNode
extends Area3D

@export var is_on : bool = true
@export var interactable_name : String = "Object"

signal interact()
signal on_contact()
signal out_of_contact()

func _enter_tree() -> void:
	set_collision_layer_value(1,false)
	set_collision_layer_value(4,true)
	monitoring = false
	switch(is_on)

func _interact() -> void:
	print("interact")
	interact.emit()

func _on_contact() -> void:
	print("on_contact")
	on_contact.emit()

func _out_of_contact() -> void:
	print("out_of_contact")
	out_of_contact.emit()

func switch(state : bool) -> void:
	monitorable = state
