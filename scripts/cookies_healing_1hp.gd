extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "Tony":
		# healing the player by 1
		GameManager.player.heal(1)
		queue_free()
