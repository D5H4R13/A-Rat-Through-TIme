extends Node2D

var speed = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += speed * delta * Vector2.DOWN



func _on_hit_box_area_2d_area_entered(area):
	if area.get_parent() is Player:
		queue_free()




func _on_hit_box_area_2d_body_entered(body):
	if body is TileMap:
		queue_free()
