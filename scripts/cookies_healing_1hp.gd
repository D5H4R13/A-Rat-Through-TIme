extends Node2D


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		# healing the player by 1
		GameManager.player.heal(1)
		queue_free()
