extends Area3D
class_name Trigger

## determines how many times this trigger can be activated
@export var trigger_limit : int = 1

var trigger_counter : int = 0

signal player_entered()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") :
		if trigger_counter < trigger_limit:
			print(body)
			emit_signal("player_entered")
			trigger_counter +=1
