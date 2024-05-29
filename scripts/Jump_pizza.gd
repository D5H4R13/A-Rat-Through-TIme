extends Node2D
@onready var sprite_2d = $Sprite2D

# This buff will reappear when the player jumps after consuming it

var consumed = false
func _ready():
	GameManager.player.connect("jumped", reappear)

func reappear():
	sprite_2d.show()
	consumed = false


func _on_area_2d_area_entered(area):
	#print(area.get_parent() is Player, consumed)
	if area.get_parent() is Player and !consumed:
		
		# Get the values from Rat to type less
		var jump_count = GameManager.player.jump_count
		var max_jumps = GameManager.player.jump_max
		
		# Won't reduce jump_count to a negative value
		GameManager.player.jump_count = clamp(jump_count - 1, 0, max_jumps)
		sprite_2d.hide()
		consumed = true
		
