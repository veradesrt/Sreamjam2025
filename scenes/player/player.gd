extends CharacterBody3D
class_name Player

## container for the camera
@onready var head: Node3D = $head
## used for checking the ground material
@onready var ground_check: RayCast3D = $ground_check
## sound player for the player footsteps
@onready var footsteps_player: AudioStreamPlayer3D = $footsteps_player
## used for adding delay after each footstep sound without changin the sound pitch or length
@onready var footsteps_delay: Timer = $footsteps_delay

@onready var main_menu: Control = $UI

var footsteps_dirt : Array = [load("res://assets/footstep_dirt_1.ogg"),load("res://assets/footstep_dirt_2.ogg")]
var footsteps_concrete : Array = [load("res://assets/footstep_concrete_1.ogg"),load("res://assets/footstep_concrete_2.ogg"),load("res://assets/footstep_concrete_3.ogg")]
## used to control the player movement speed
const SPEED = 5.0
## Unused
const JUMP_VELOCITY = 4.5

## mouse sensitivity, used for camera control
@export var mouse_sens : float = 0.001

func _ready() -> void:
	## on startup set the mouse mode to captured so the player can look around
	change_mouse_mode(Input.MOUSE_MODE_CAPTURED)

## function used to change the mouse mode from a single place
func change_mouse_mode(new_mode):
	Input.mouse_mode = new_mode

func open_exit_menu():
	
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		change_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pass
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(event.relative.x * -1 *mouse_sens)
		head.rotate_x(event.relative.y * -1 *mouse_sens)
		head.rotation.x = clamp(head.rotation.x ,deg_to_rad(-90),deg_to_rad(90))

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		##only if the player is moving
		##check if the ground check can detect ground
		var collider = ground_check.get_collider()
		##if raycast cant detect anything (example: player is on air) skip
		if collider != null:
			## get the groups of the detected collider
			var ground_groups : Array = collider.get_groups()
			if ground_groups.has("concrete"):
				if !footsteps_player.playing && footsteps_delay.is_stopped():
					footsteps_player.stream = footsteps_concrete[randi_range(0,footsteps_concrete.size()-1)]
					footsteps_player.pitch_scale = randf_range(0.9,1.1)
					footsteps_player.play()
					footsteps_delay.wait_time = 0.6
					footsteps_delay.start()
			if ground_groups.has("dirt"):
				if !footsteps_player.playing:
					footsteps_player.stream = footsteps_dirt[randi_range(0,footsteps_dirt.size()-1)]
					footsteps_player.pitch_scale = randf_range(0.9,1.1)
					footsteps_player.play()

			pass
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
