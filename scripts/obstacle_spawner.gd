extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer

var obstacle_scene: PackedScene = preload("res://scenes/obstacle.tscn")


func start() -> void:
	spawn_timer.start()


func stop() -> void:
	spawn_timer.stop()


func _on_spawn_timer_timeout() -> void:
	var obstacle: Node2D = obstacle_scene.instantiate()

	var max_y_pos: float = -200.0
	var min_y_pos: float = 120.0

	add_child(obstacle)

	obstacle.position.y = randf_range(max_y_pos, min_y_pos)
	print("new child")
