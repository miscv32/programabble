extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _button_pressed():
	var tileRack = get_tree().root.find_child("TileRack", true, false)
	if tileRack:
		tileRack.draw_index()
