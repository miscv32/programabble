extends Button

var tile_scene := preload("res://scenes/components/tile.tscn")

var tokens = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(12):
		tokens.append("swap")
		tokens.append("shift")
		tokens.append("take")
	for i in range(6):
		tokens.append("with")
		tokens.append("x2")
	for i in range(2):
		tokens.append("1")
		tokens.append("2")
		tokens.append("3")
		tokens.append("4")
		tokens.append("5")
		tokens.append("6")
		tokens.append("7")
		tokens.append("8")
		tokens.append("9")
		tokens.append("A")
		tokens.append("B")
		tokens.append("C")
		tokens.append("D")
		tokens.append("F")
		tokens.append("G")
		tokens.append("H")
		tokens.append("I")
		tokens.append("J")
	pressed.connect(_on_pressed)

func _on_pressed():
	var t;
	for i in range(9):
		t = tile_scene.instantiate()
		t.position.y += global_position.y + 67 * i
		t.position.x = global_position.x
		t.letter_text = tokens.pick_random()
		get_parent().add_child(t)
		
	
