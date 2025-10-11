class_name InteractableNode
extends Area3D

@export var is_on : bool = true

signal interact()
signal on_contact()
signal out_of_contact()

func _enter_tree() -> void:
	set_collision_layer_value(1,false)
	set_collision_layer_value(4,true)
	interact.connect(_interact)
	on_contact.connect(_on_contact)
	out_of_contact.connect(_out_of_contact)
	monitoring = false
	switch(is_on)

func _interact() -> void:
	print("interact")
	pass

func _on_contact() -> void:
	print("on_contact")
	pass

func _out_of_contact() -> void:
	print("out_of_contact")
	pass

func switch(state : bool) -> void:
	monitorable = state
