extends Node2D

var speed: float = -150.0

func _physics_process(delta: float) -> void:
	position.x += speed * delta

func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()


func _on_score_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.score_point()

func stop() -> void:
	speed = 0.0
