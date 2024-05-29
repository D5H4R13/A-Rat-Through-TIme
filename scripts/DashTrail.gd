extends Sprite2D

func _ready():
	ghosting()

# Function to set position and scale of dash trail
func set_property(tx_pos, tx_scale):
	position = tx_pos
	scale = tx_scale

# Function to fade out dash trail
func ghosting():
	var tween_fade = get_tree().create_tween()	
	tween_fade.tween_property(self,"self_modulate", Color(1, 1, 1, 0), 0.75)
	
	await tween_fade.finished
	
	queue_free()
