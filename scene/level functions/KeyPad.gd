extends MarginContainer

@onready var label = $KeyPad/MarginContainer/Label
var MAX_SIZE
var current_size
var current_display
var item_dictionary: Dictionary = {} 

func _ready():
	MAX_SIZE = 3
	current_size = 0
	current_display = label.get_text()
	add_item("Cola Serum",8)
	add_item("Fortified Brace", 12)
	add_item("Adrenaline",25)
	add_item("Ammo",30)
	

func _process(_delta):
	current_display = label.get_text()
	
func add_item(key: String, value: int) -> void:
	item_dictionary[key] = value

func pressed_1():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "1")
		current_size = current_size + 1
		

func pressed_2():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "2")
		current_size = current_size + 1

func pressed_3():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "3")
		current_size = current_size + 1
		
func pressed_4():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "4")
		current_size = current_size + 1
		
func pressed_5():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "5")
		current_size = current_size + 1
		
func pressed_6():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "6")
		current_size = current_size + 1

func pressed_7():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "7")
		current_size = current_size + 1

func pressed_8():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "8")
		current_size = current_size + 1

func pressed_9():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "9")
		current_size = current_size + 1

func pressed_c():
	label.set_text("")
	current_size = 0

func pressed_0():
	if current_size < MAX_SIZE:
		label.set_text(current_display + "0")
		current_size + 1

func pressed_ok():
	var display_int = int(current_display)
	for item_name in item_dictionary.keys():
		if display_int == item_dictionary[item_name]:
			purchased(item_name)
	pressed_c()
func purchased(name: String):
	if name == "Cola Serum" && GameManager.coins >= 20:
		GameManager.spend_coins(20)
		GameManager.player.SPEED = 450
		await get_tree().create_timer(100.00).timeout
		GameManager.player.SPEED = 300
	if name == "Fortified Brace" && GameManager.coins >= 35:
		GameManager.spend_coins(35)
		GameManager.player.vulnerable = false
		await get_tree().create_timer(30.00).timeout
	if name == "Adrenaline" && GameManager.coins >= 25:
		GameManager.spend_coins(25)
		GameManager.player.SPEED = 400
		GameManager.player.JUMP_VELOCITY = -575
		await get_tree().create_timer(100.00).timeout
		GameManager.player.SPEED = 300
		GameManager.player.JUMP_VELOCITY = -500
		
	if name == "Ammo" && GameManager.coins >= 10:
		GameManager.spend_coins(10)
		GameManager.gain_ammo(8)

