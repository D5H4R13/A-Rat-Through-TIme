extends Node2D

@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@export var speed: int = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("spinningblade")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path_follow.progress += speed * delta

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent()._damage(1)
