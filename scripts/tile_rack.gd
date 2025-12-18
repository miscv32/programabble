extends Node2D

var tile_scene := preload("res://scenes/components/tile.tscn")
var tokens = []

var rack = []

func reset_tiles():
	var board = get_tree().root.find_child("Board", true, false)
	for index in range(board.board_buffer.size()):
		if board.board_buffer[index] != null:
			var tile = board.board_buffer[index]
			
			board.remove(board.get_grid_coords(tile.global_position))
			tile.global_position = tile.originalPos
			
		
func refill_rack():
	var t
	var text_index
	for i in range(rack.size()):
		if rack[i] == null:
			t = tile_scene.instantiate()
			t.position.x += 64 * i + 32
			t.position.y = 32
			text_index = randi() % tokens.size()
			t.letter_text = tokens[text_index]
			tokens.remove_at(text_index)
			add_child(t)
			rack[i] = t
			
func remove_tile(t):
	for i in range(rack.size()):
		if rack[i] == t:
			rack[i] = null
			
		


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(9):
		tokens.append("shift")
		tokens.append("take")
	for i in range(3):
		tokens.append("replace")
		tokens.append("swap")
		
	for i in range(6):
		tokens.append("with")
		tokens.append("then")
		tokens.append("x2")
		
		
	for i in range(3):
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
		
	rack.resize(9)
	refill_rack()
