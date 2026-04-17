extends Node2D

var score = 0

@onready var obstacle_spawner: Node2D = $ObstacleSpawner
@onready var ground: StaticBody2D = $Ground


func _on_player_game_started() -> void:
	obstacle_spawner.start()


func _on_player_died() -> void:
	obstacle_spawner.stop()

	var ground_animation_player: AnimationPlayer = ground.get_node_or_null("AnimationPlayer")
	if ground_animation_player:
		ground_animation_player.pause()

	get_tree().call_group("obstacles", "stop")


func _on_player_scored() -> void:
	score += 1
	print(score)
