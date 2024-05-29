extends Node2D


@onready var sprite_2d = $Sprite2D

## If this value is [color=red]enabled[/color], this buff will respawn when the player jumps
@export var reappearing = false

var consumed = false

func _ready():
	GameManager.player.connect("jumped",reset_jump_height)

func reset_jump_height():
	if GameManager.player.JUMP_VELOCITY < -500:
		GameManager.player.JUMP_VELOCITY += 200
		
	if !reappearing and consumed:
		queue_free()
	elif reappearing and consumed:
		sprite_2d.show()
		consumed = false

func _on_area_2d_area_entered(area):
	#print(area.name, area.get_parent())
	# If this is Tony
	if area.get_parent() is Player and !consumed:
		# Now the buff is consumed
		GameManager.player.JUMP_VELOCITY += -200
		sprite_2d.hide()
		consumed = true
