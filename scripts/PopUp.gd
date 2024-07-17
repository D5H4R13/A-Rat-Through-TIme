extends Node2D
var displayed = false
@export var my_text: String = "some text we want to display when
the player moves through a trigger area"

func _ready():
	$MarginContainer/ColorRect/Label.visible_ratio = 0
	$MarginContainer/ColorRect.visible = false
	$MarginContainer/ColorRect/Label.text = my_text
	
func _play_animation():
	if displayed == false:
		$MarginContainer/ColorRect.visible = true
		$AnimationPlayer.play('show')
		displayed = true
		await get_tree().create_timer(7.0).timeout
		displayed = false
		_ready()
func _on_detect_body_entered(body):
	if body.name == "Tony":
		_play_animation()
