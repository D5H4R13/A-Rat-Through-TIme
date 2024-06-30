extends Control
@onready var label = $Label

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _process(delta):
	label.set_text(str(GameManager.coins))
func _on_exit_pressed():
	# When close button on shop is pressed it will go invisible
	get_tree().paused = false
	$".".visible = false
