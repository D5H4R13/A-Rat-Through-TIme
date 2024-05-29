extends CharacterBody2D
var shopping = false
var rat

func _ready():
	$Area2D/ShopMenu.visible = false
func _process(_delta):
	pass
func _on_area_2d_body_entered(body):
	if body.name == "Tony":
		shopping = true
func _on_area_2d_body_exited(body):
	if body.name == "Tony":
		$Area2D/ShopMenu.visible = false
		shopping = false
func _input(event):
	if event.is_action_pressed("interact") && shopping:
		get_tree().paused = true
		$Area2D/ShopMenu.visible = true
		
