extends Node2D


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		GameManager.player.max_health += 1
		GameManager.player.healthbar.init_health(GameManager.player.max_health)
		queue_free()
