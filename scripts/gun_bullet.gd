extends Node2D


var direction : Vector2 
var speed = 700
@onready var animated_sprite_2d = $AttackBoxArea2D/AnimatedSprite2D

 
func _process(delta):
	if direction == Vector2.UP:
		animated_sprite_2d.rotate(deg_to_rad(90))
	elif direction == Vector2.DOWN:
		animated_sprite_2d.rotate(deg_to_rad(-90))
	elif direction == Vector2.LEFT:
		animated_sprite_2d.flip_h = true
		
		
	global_position += direction * speed * delta


func _on_attack_box_area_2d_area_entered(area):
	if not(area.get_parent() is Player):
		queue_free()


func _on_attack_box_area_2d_body_entered(body):
	
	if body is TileMap:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	#print("visibility")
	queue_free()
