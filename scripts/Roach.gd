extends CharacterBody2D

var max_health = 2
var health = max_health
var is_alive = true
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var Asprite = $Node2D
@onready var healthbar = $Healthbar
@onready var invulnerability_timer = $InvulnerabilityTimer
@onready var hitbox = $HitBoxArea2D

#Spawn of roach
func _ready():
	healthbar.init_health(health)

#Death of roach
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
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

# Attacked
func _on_hit_box_area_2d_area_entered(_area):
	_damage(1)
