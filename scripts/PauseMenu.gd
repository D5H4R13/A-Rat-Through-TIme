extends Control

var world_select_packed: PackedScene = preload("res://scene/world and level select/world_select.tscn")
var world_select_scene: Control = world_select_packed.instantiate()

func _ready():
	$".".visible = false
func resume():
	$".".visible = false
	get_tree().paused = false
	
func pause():
	get_tree().paused = true
	$".".visible = true

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()

func _process(_delta):
	testEsc()

