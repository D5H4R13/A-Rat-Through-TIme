extends Node

signal gained_coins()
signal gained_ammo()
signal spent_coins()
var coins : int = 0
var ammo : int = 10
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var learned_double_jump = false
var learned_dash = false
var learned_attack = false
var learned_shooting = false

var items = {
	0: {
		"Name": "Cola Serum",
		"Des": "this item allows you to run faster",
		"Cost": 20
	},
	1: {
		"Name": "Fortified Brace",
		"Des": "this item grants immunity for 30s",
		"Cost": 35
	},
	2: {
		"Name": "Adrenaline",
		"Des": "this item grants speed and jump boost",
		"Cost": 25
	},
	3: {
		"Name": "Ammo",
		"Des": "1 bullet ",
		"Cost": 5
	},
}

var current_checkpoint : Checkpoint

var player : Player

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.position
		

func gain_coins(coins_gained : int):
	coins += coins_gained
	emit_signal("gained_coins")

func gain_ammo(ammo_gained : int):
	ammo += ammo_gained
	emit_signal("gained_ammo")
	
func spend_coins(coins_spent : int):
	coins -= coins_spent
	emit_signal("spent_coins")
