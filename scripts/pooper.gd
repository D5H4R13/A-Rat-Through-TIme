extends CharacterBody2D

@export var BULLET : PackedScene 
@export var pace_distance = 30



var max_health = 1
var health = max_health
var is_alive = true
var facing_right = false
## This value must be negative since the bird always starts fliying left first
@export var SPEED = 0
var current_pos : Vector2
var target = null

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_2d = $RayCast2D
@onready var reload_timer = $RayCast2D/ReloadTimer
@onready var healthbar = $Healthbar

@export var ray_length : int = 150

func _ready():	
	healthbar.init_health(health)
	current_pos = position
	ray_cast_2d.target_position.y = ray_length


func _physics_process(delta):
	
	var end_reached = abs(position.distance_to(current_pos)) >= pace_distance 
	
	if end_reached:
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
		SPEED = SPEED * -1
	
	velocity.x = SPEED
	
	if ray_cast_2d.is_colliding():
		target = ray_cast_2d.get_collider()
		
		
		if target.get_parent() is Player:
			if reload_timer.is_stopped():
				shit()
	
	move_and_slide()
	

#Death of pooper
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

func shit():
	
	if BULLET:
		var bullet: = BULLET.instantiate()
		bullet.global_position = position
		bullet.global_rotation = rotation
		get_tree().current_scene.add_child(bullet)
	
	reload_timer.start()


func _on_hitbox_area_2d_area_entered(area):
	if area.name == "AttackBoxArea2D":
		_damage(1)
