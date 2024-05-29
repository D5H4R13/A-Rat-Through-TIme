extends Node2D



func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		GameManager.gain_ammo(5)
		queue_free()
