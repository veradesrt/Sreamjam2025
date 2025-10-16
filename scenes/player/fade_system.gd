extends Control
class_name fade_screen_system
@onready var black_screen: ColorRect = $black_screen
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal fade_to_black_ended
signal fade_to_clear_ended

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func force_set_screen_to_black():
	black_screen.visible = true
	black_screen.color = Color(0.0, 0.0, 0.0, 1.0)

func force_set_screen_to_clear():
	black_screen.visible = false
	black_screen.color = Color(0.0, 0.0, 0.0, 0.0)

func fade_from_black_to_clear():
	black_screen.visible = true
	animation_player.play("black_to_clear")

func fade_from_clear_to_black():
	black_screen.visible = true
	animation_player.play("clear_to_black")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "clear_to_black":
		fade_to_black_ended.emit()
	elif anim_name == "black_to_clear":
		fade_to_clear_ended.emit()
