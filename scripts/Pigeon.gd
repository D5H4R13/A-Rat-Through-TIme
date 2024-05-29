extends CharacterBody2D

@export var max_health = 1
@export var SPEED = 30 #make this value smaller to make it faster
var health = max_health
var is_alive = true
var player_chase = false
var player = null
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var Asprite = $AnimatedSprite2D
@onready var healthbar = $Healthbar
#@onready var hitbox = $HitBoxArea2D

#Spawn of Pigeon
func _ready():
	healthbar.init_health(health)

#Death of Pigeon
func _die():
	is_alive = false
	queue_free()
	#emit_signal("died")

#sets healthbar value
func _set_health(value):
	var prev_health = health
	health = clamp(value,0,max_health)
	healthbar.health = health
	if health != prev_health:
		#emit_signal("health_updated",health)
		if health == 0:
			_die()
			#emit_signal("killed")

# Calculates damage and updates health
func _damage(amount):
	_set_health(health - amount)

# Physics
func _physics_process(_delta):
	# Chase player if in range
	if player_chase:
		var old_position = position
		position += (player.position -position)/SPEED
		if (old_position.x < position.x):
			Asprite.flip_h = true
		else:
			Asprite.flip_h = false
	move_and_slide()
	
# Tony entered detection
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

# Tony exited detection
func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false

# Tony damages
func _on_hit_box_shape_2d_area_entered(area):
	if area.name == "AttackBoxArea2D":
		_damage(1)
