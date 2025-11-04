extends CharacterBody3D

const GameLayers = preload("res://scripts/systems/game_layers.gd")

var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export_group("Movement")
@export var _speed := 5.
@export var _friction := 5.

@export_group("Camera")
@export_range(.01, 1) var _sens := 0.5
@onready var head = $Head
@onready var _pcamera = $Head/PhantomCamera3D

const _MIN_PITCH: float = -40
const _MAX_PITCH: float = 60

#LINK - https://youtu.be/A3HLeyaBCq4?si=cUhby06aHcAweQa7
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	_handleCamera(event)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta
	
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * _speed 
		velocity.z = direction.z * _speed 
	else:
		velocity.x = move_toward(velocity.x, 0, _friction )
		velocity.z = move_toward(velocity.z, 0, _friction )

	move_and_slide()

func _handleCamera(event: InputEvent):
	if not event is InputEventMouse:
		return
	
	head.rotate_y(-event.relative.x * _sens * 0.01)

	_pcamera.rotate_x(-event.relative.y * _sens * 0.01)
	_pcamera.rotation.x = clamp(_pcamera.rotation.x, deg_to_rad(_MIN_PITCH), deg_to_rad(_MAX_PITCH))
