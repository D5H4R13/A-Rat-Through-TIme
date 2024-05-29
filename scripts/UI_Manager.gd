extends CanvasLayer


func _ready():
	update_coin_display()
	update_ammo_display()
	GameManager.gained_coins.connect(update_coin_display)
	GameManager.gained_ammo.connect(update_ammo_display)
	GameManager.spent_coins.connect(update_coin_display)

func update_coin_display():
	$CoinDisplay.text = str(GameManager.coins)

func update_ammo_display():
	$AmmoDisplay.text = str(GameManager.ammo)
