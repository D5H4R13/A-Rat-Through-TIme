extends Area2D

var direction : Vector2 = Vector2.RIGHT
var SPEED : float = 300

func _physics_process(delta):
	#acorn motion
	global_position += direction * SPEED * delta

# Hits tony and disapears
func _on_area_entered(area):
	if area.name == "HurtBoxArea2D" || area.name == "AttackBoxArea2D":
		queue_free()

# Hits tilemap and disapears
func _on_body_entered(body):
	if body.name == "TileMap":
		queue_free()
