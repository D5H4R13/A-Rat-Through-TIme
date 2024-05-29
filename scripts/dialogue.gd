extends CanvasLayer

@export_file("*.json") var d_file: String
var dialogue = []

func _ready():
	start()
func start():
	dialogue = load_dialogue()
	print(dialogue[0])
	$NinePatchRect/Name.text = dialogue[0]["name"]
	$NinePatchRect/Chat.text = dialogue[0]["chat"]

func load_dialogue():
	var file = FileAccess.open(d_file,FileAccess.READ)
	var text = file.get_as_text()
	file.close()  # Close the file after reading
	var json_string = JSON.stringify(text)
	var data = JSON.parse_string(json_string)
	return data
