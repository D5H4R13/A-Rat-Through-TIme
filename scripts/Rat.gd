extends CharacterBody2D
class_name Player

var SPEED = 300.0
var JUMP_VELOCITY = -500.0
@onready var sprite_2d = $Sprite2D
@onready var healthbar = $Healthbar
@onready var attack_timer = $AttackTimer
@onready var invulnerability_timer = $InvulnerabilityTimer
@onready var hurtbox = $AttackBoxArea2D/HitBoxCollisionShape2D
var vulnerable = true


# Variable for bullet
@export var BULLET : PackedScene


# Variables for dash trail & timer
@export var dash_trail_node : PackedScene
@onready var dash_trail_timer = $Dash_Trail_Timer

var jump_count = 0
var jump_max = 2
signal jumped

var max_health = 3
var health = max_health


# Variables to help deal with many dash bugs
var canDash = true
var isDashing = false


var is_alive: bool = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#movements and animation
func _physics_process(delta):
	# Adding walk animation
	if(velocity.x > 1 || velocity.x < -1) and attack_timer.is_stopped():
		if GameManager.learned_attack:
			sprite_2d.play("walk_sword")
		else:
			sprite_2d.play("walk1")
	elif velocity.x ==  0 and attack_timer.is_stopped():
		if GameManager.learned_attack:
			sprite_2d.play("idle_sword")
		else:
			sprite_2d.play("idle")
	
	# Add the gravity.
	if not is_on_floor()  and !isDashing:
		velocity.y += gravity * delta
		# Adding jumping frame
		if GameManager.learned_attack and attack_timer.is_stopped():
			sprite_2d.play("jumping_sword")
		elif !GameManager.learned_attack and attack_timer.is_stopped():
			sprite_2d.play("jumping")
	
	if is_on_floor():
		jump_count = 0
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count<jump_max and !isDashing:
		velocity.y = JUMP_VELOCITY
		if GameManager.learned_double_jump:
			jump_count += 1
		else:
			jump_count +=2
		emit_signal("jumped")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right") 
	# Handles hitbox h_flip
	if direction < 0:
		hurtbox.position.x = -35

	if direction > 0:
		hurtbox.position.x = 35

		
	if direction and !isDashing:
		velocity.x = direction * SPEED
	elif !direction and !isDashing:
		velocity.x = move_toward(velocity.x, 0, 30)
		
	# Handles attack
	if Input.is_action_just_pressed("left_click"):
		#if there is no timer then hitbox then call timer
		if attack_timer.is_stopped():
			hurtbox.disabled = false
			attack_timer.start()
			#we need attack animation
			sprite_2d.play("attack")
	else:
		hurtbox.disabled = true
	
	# Handles shooting
	if Input.is_action_just_pressed("right_click") and GameManager.ammo > 0 and GameManager.learned_shooting:
		var left_or_right = sprite_2d.flip_h
		var up_or_down = Input.get_axis("up","down")
		if up_or_down == 0:
			if left_or_right:
				_shoot(Vector2.LEFT)
			else:
				_shoot(Vector2.RIGHT)
		elif up_or_down < 0:
			_shoot(Vector2.UP)
		else:
			_shoot(Vector2.DOWN)
		
	

	move_and_slide()
	
	# Correct left turn
	if direction > 0:
		sprite_2d.flip_h = false
	elif direction < 0:
		sprite_2d.flip_h = true

# Player spawn
func _ready():
	healthbar.init_health(max_health)
	GameManager.player = self

#player death
func _die():
	is_alive = false
	GameManager.respawn_player()
	_set_health(max_health)
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

# function to call for healing the player from elsewhere
func heal(value):
	_set_health(value + health)

#calculates damage and updates health
func _damage(amount):
	if invulnerability_timer.is_stopped() && vulnerable:
		invulnerability_timer.start()
		_set_health(health - amount)

# Function to add trail to dash
func add_dash_trail():
	var trail = dash_trail_node.instantiate()
	
	# Turning the trail character when facing left
	var turn_left = velocity.x < 0
	if turn_left:
		trail.flip_h = turn_left
	
	trail.set_property(position, sprite_2d.scale)
	get_tree().current_scene.add_child(trail)


func _on_dash_trail_timer_timeout():
	add_dash_trail()

# Dash function
func dash():
	dash_trail_timer.start()
	isDashing = true # Setting true at start to deal with physics conflicts up there
	
	# Gets direction of dash from where the sprite is facing
	if sprite_2d.flip_h: # This spaghetti was the best global facing direction I could find
		velocity = Vector2(SPEED * -2.25, 0) # Only a change in X velocity and not Y
	else:
		velocity = Vector2(SPEED * 2.25, 0)
	
	await get_tree().create_timer(.5).timeout # Timer for trail to get off 5 sprites
	dash_trail_timer.stop()
	isDashing = false 

# Handles shooting
func _shoot(direction):
	if BULLET && GameManager.learned_shooting:
		var bullet = BULLET.instantiate()
		bullet.direction = direction
		bullet.global_position = position
		get_tree().current_scene.add_child(bullet)
		GameManager.gain_ammo(-1)

func _input(event):
	if event.is_action_pressed("dash") and canDash and GameManager.learned_dash:
		dash()
		canDash = false
		await get_tree().create_timer(1).timeout # Time between dashes
		canDash = true


func _on_spikes_impaled():
	_damage(1)

func _on_hurt_box_area_2d_area_entered(area):
	if area.name == "HitBoxArea2D":
		_damage(1)
