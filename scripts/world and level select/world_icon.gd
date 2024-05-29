@tool
extends Control

@export var world_index: int = 1
@export var level_select_packed: PackedScene = load("res://scene/world and level select/level_select_1.tscn")
@onready var level_select_scene: LevelSelect = level_select_packed.instantiate()

# makes name of world
func _ready():
	$Label.text = "World " + str(world_index)

# same thing but updates in game
func _process(_delta):
	if Engine.is_editor_hint():
		$Label.text = "World " + str(world_index)
