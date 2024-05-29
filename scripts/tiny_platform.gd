extends StaticBody2D

@onready var collision = $CollisionShape2D
@onready var area = $Area2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		area.set_deferred("monitoring", true)

func _on_area_2d_body_entered(_body):
	collision.set_deferred("disabled", true)


func _on_area_2d_body_exited(_body):
	collision.set_deferred("disabled", false)
	area.set_deferred("monitoring", false)
