extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var chat_timer = false
var player
var player_in_chat_zone = false
@export var dialogue_path: String = "res://dialogue/pixie/pixie.json"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# If entered pressed start chatting
	if Input.is_action_just_pressed("interact") && player_in_chat_zone && !chat_timer:
		$Dialogue.start()
		chat_timer = true
	move_and_slide()
	
func _on_dialogue_dialogue_finished():
	await get_tree().create_timer(1).timeout
	chat_timer = false
	

func _on_chat_detection_area_body_entered(body):
	if body.name == "Tony":
		player = body
		player_in_chat_zone = true

func _on_chat_detection_area_body_exited(body):
	if body.name == "Tony":
		player_in_chat_zone = false
