class_name InteractManager
extends Node

@export var interact_detector : InteractDetector
@export var inventory : InventoryNode

func _ready() -> void:
	interact_detector.is_touching.connect(is_touching)
	interact_detector.not_touching.connect(not_touching)

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("enter") and interact_detector.current_state_touching):
		interacted(interact_detector.current_interactable_node)

func interacted(i : InteractableNode) -> void:
	i._first_interact()
	
	##esto no esta tan gucci pero si en algun momento hace falta se hace una queue y se saca todo esto
	##TODO: hacer un mediador para el interactablenode
	if(i.dialogue_emitter):
		i.dialogue_emitter.start_dialogue()
		DialogueGlobalEmitter.has_ended.connect(end_interaction)
		return
	
	end_interaction()

func end_interaction() -> void:
	var i : InteractableNode = interact_detector.current_interactable_node
	
	##este codigo es feaso pero por ahora sirve
	
	if(i == null):
		return
	
	if(DialogueGlobalEmitter.has_ended.is_connected(end_interaction)):
		DialogueGlobalEmitter.has_ended.disconnect(end_interaction)
	
	if(i.item_node):
		inventory.add_item(i.item_node.item_data)
	
	interact_detector.current_interactable_node._last_interact()
	pass

func is_touching() -> void:
	pass

func not_touching() -> void:
	pass
