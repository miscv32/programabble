extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _button_pressed():
	var board = get_tree().root.find_child("Board", true, false)
	for index in range(board.board_buffer.size()):
		if board.board_buffer[index] != null:
			var tile = board.board_buffer[index]
			
			board.remove(board.get_grid_coords(tile.global_position))
			tile.global_position = tile.originalPos
			
