extends Node2D

var score: int = 0
var high_score: int = 0

var save_file_path = "user://save_data.data"

@onready var obstacle_spawner: Node2D = $ObstacleSpawner
@onready var ground: StaticBody2D = $Ground
@onready var hud: CanvasLayer = $HUD

func _ready() -> void:
	load_high_score()
	hud.set_score(0)

func _on_player_game_started() -> void:
	obstacle_spawner.start()
	hud.hide_start_message()


func _on_player_died() -> void:
	obstacle_spawner.stop()

	var ground_animation_player: AnimationPlayer = ground.get_node_or_null("AnimationPlayer")
	if ground_animation_player:
		ground_animation_player.pause()
	
	if score > high_score:
		high_score = score
		save_high_score()

	get_tree().call_group("obstacles", "stop")
	hud.show_game_over_screen(score, high_score)


func _on_player_scored() -> void:
	score += 1
	hud.set_score(score)


func save_high_score() -> void:
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)

	file.store_var(high_score)
	file.close()


func load_high_score() -> void:
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)

		high_score = file.get_var()
		file.close()
