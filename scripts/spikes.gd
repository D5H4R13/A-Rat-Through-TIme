extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Tony":
		GameManager.player._damage(1)
