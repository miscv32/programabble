extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hllo")
	var button = Button.new()
	button.text = "Play"
	button.pressed.connect(_button_pressed)
	add_child(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _button_pressed():
	print("Pressed play")
	get_tree().change_scene_to_file("res://game.tscn")
