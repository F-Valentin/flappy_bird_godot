class_name Player
extends RigidBody2D

signal game_started
signal died
signal scored

var started: bool = false

var flap_force: float = -340.0
var flap_angular_force: float = -8.0

var maximum_rotation_up: float = -30.0
var maximum_rotation_down: float = 90.0
var falling_angular_velocity: float = 5.0

var is_alive = true

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Flap") and is_alive:
		if not started:
			start_game()
		flap()

	if rotation_degrees <= maximum_rotation_up:
		rotation_degrees = maximum_rotation_up
		angular_velocity = 0.0

	if linear_velocity.y > 0.0:
		if rotation_degrees <= maximum_rotation_down:
			angular_velocity = falling_angular_velocity
		else:
			angular_velocity = 0.0

func start_game() -> void:
	started = true
	gravity_scale = 1.0
	game_started.emit()


func flap() -> void:
	linear_velocity.y = flap_force
	angular_velocity = flap_angular_force
	animation_player.play("Flap")


func die() -> void:
	if is_alive:
		is_alive = false
		died.emit()

func score_point() -> void:
	if is_alive:
		scored.emit()
