extends Node2D

@export var speed: int = 250
var current_speed = 0

@onready var spawn_pos = global_position

func _physics_process(delta):
	position.y += current_speed * delta

func _on_hitbox_body_entered(body):
	if body.name == "Tony":
		GameManager.player._damage(1)
		# reset using spawn_pos after timeout
		position = spawn_pos
		
		current_speed = 0
	if body.name != "Tony":
		position = spawn_pos
		current_speed = 0


func _on_player_detection_body_entered(body):
	if body.name == "Tony":
		fall()

func fall():
	current_speed = speed
	# destroy itself after 3 seconds
	await get_tree().create_timer(3).timeout
	# reset using spawn_pos after timeout
	position = spawn_pos
	current_speed = 0
	
