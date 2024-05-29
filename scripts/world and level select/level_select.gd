extends Control
class_name LevelSelect

@onready var current_level: LevelIcon = $LevelIcon0
var parent_world_select: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerIcon.global_position = current_level.global_position

func _input(event):
	if event.is_action_pressed("ui_left") and current_level.next_level_left:
		current_level = current_level.next_level_left
		$PlayerIcon.global_position = current_level.global_position
	if event.is_action_pressed("ui_right") and current_level.next_level_right:
		current_level = current_level.next_level_right
		$PlayerIcon.global_position = current_level.global_position
	if event.is_action_pressed("ui_up") and current_level.next_level_up:
		current_level = current_level.next_level_up
		$PlayerIcon.global_position = current_level.global_position
	if event.is_action_pressed("ui_down") and current_level.next_level_down:
		current_level = current_level.next_level_down
		$PlayerIcon.global_position = current_level.global_position	
	if event.is_action_pressed("ui_cancel"):
		get_tree().get_root().add_child(parent_world_select)
		get_tree().current_scene = parent_world_select
		get_tree().get_root().remove_child(self)
		
	if event.is_action_pressed("ui_accept"):
		if current_level.next_scene_path:
			Functions.load_screen_to_scene(current_level.next_scene_path)
