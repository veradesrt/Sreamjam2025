extends CharacterBody3D

@onready var head: Node3D = $head
## used for checking the ground material
@onready var ground_check: RayCast3D = $ground_check
@onready var footsteps_player: AudioStreamPlayer3D = $footsteps_player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var mouse_sens : float = 0.001

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(event.relative.x * -1 *mouse_sens)
		head.rotate_x(event.relative.y * -1 *mouse_sens)
		head.rotation.x = clamp(head.rotation.x ,deg_to_rad(-90),deg_to_rad(90))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		var collider = ground_check.get_collider()
		if collider != null:
			var ground_groups : Array = collider.get_groups()
			if ground_groups.has("concrete"):
				#print("walking on concrete")
				pass
			if ground_groups.has("dirt"):
				#print("walking on dirt")
				pass

			pass
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
