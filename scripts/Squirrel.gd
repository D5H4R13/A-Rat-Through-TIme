extends CharacterBody2D

var player
var max_health = 2
var health = max_health
var is_alive = true
var facing_right = false
var detect = false
var gravity = GameManager.gravity
@onready var ray_cast = $RayCast2D
@onready var Asprite = $AnimatedSprite2D
@onready var healthbar = $Healthbar
@onready var invulnerability_timer = $InvulnerabilityTimer
@onready var shoot_timer = $ShootTimer
@onready var hitbox = $HitBoxArea2D
@export var acorn : PackedScene

#Spawn of Squirrel
func _ready():
	healthbar.init_health(health)
	player = get_parent().get_parent().find_child("Tony")


#Death of Squirrel
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
	if invulnerability_timer.is_stopped:
		invulnerability_timer.start()
		_set_health(health - amount)

	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	_aim()
	_check_player_collision()
	move_and_slide()
	
func _aim():
	ray_cast.target_position = to_local(player.global_position)

func _on_hit_box_area_2d_area_entered(area):
	if area.name == "AttackBoxArea2D":
		_damage(1)

func _check_player_collision():
	if ray_cast.get_collider() == player and shoot_timer.is_stopped() and detect:
		shoot_timer.start()
	elif ray_cast.get_collider() != player and not shoot_timer.is_stopped() and not detect:
		shoot_timer.stop()

func _on_shoot_timer_timeout():
	if detect:
		_shoot()

# Spawn acorn and sets its direction
func _shoot():
	var Acorn = acorn.instantiate()
	Acorn.global_position = position
	Acorn.direction = (ray_cast.target_position).normalized()
	get_tree().current_scene.add_child(Acorn)


func body_entered(body):	
	if body is Player:
		detect = true

func body_exited(body):
	if body is Player:
		detect = false

