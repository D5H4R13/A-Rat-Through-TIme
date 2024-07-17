extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1.0).timeout
	get_tree().paused = true
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
