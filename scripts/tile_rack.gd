extends Node2D

var tile_scene := preload("res://scenes/components/tile.tscn")
var commands = []
var indexes = []

var rack = []

func reset_tiles():
	var board = get_tree().root.find_child("Board", true, false)
	for index in range(board.board_buffer.size()):
		if board.board_buffer[index] != null:
			var tile = board.board_buffer[index]
			
			board.remove(board.get_grid_coords(tile.global_position))
			tile.global_position = tile.originalPos
			
			
func draw_command():
	if (rack.size() >= 9):
		print ("Full")
		return
	var t = tile_scene.instantiate()
	t.position.x += 64 * rack.size() + 32
	t.position.y = 32
	var text_index = randi() % commands.size()
	t.letter_text = commands[text_index]
	commands.remove_at(text_index)
	add_child(t)
	rack.append(t)
	
func draw_index():
	if (rack.size() >= 9):
		print ("Full")
		return
	var t = tile_scene.instantiate()
	t.position.x += 64 * rack.size() + 32
	t.position.y = 32
	var text_index = randi() % indexes.size()
	t.letter_text = indexes[text_index]
	indexes.remove_at(text_index)
	add_child(t)
	rack.append(t)
	
			
func remove_tile(t):
	rack.erase(t)
	_move_positions()
			
func _move_positions():
	var t
	var move
	var updatePrev
	for i in range(rack.size()):
		t = rack[i]
		move = t.global_position == t.originalPos
		updatePrev = t.prevPos == t.originalPos
		t.originalPos.x = 64 * i + 32
		t.originalPos.y = 32
		t.originalPos = to_global(t.originalPos)
		if move: 
			t.global_position = t.originalPos
		if updatePrev: 
			t.prevPos = t.originalPos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(10):
		commands.append("shift")
		commands.append("take")
	for i in range(4):
		commands.append("replace")
		commands.append("swap")
		
	for i in range(4):
		commands.append("with")
		commands.append("then")
		commands.append("x2")
		
		
	for i in range(2):
		indexes.append("1")
		indexes.append("2")
		indexes.append("3")
		indexes.append("4")
		indexes.append("5")
		indexes.append("6")
		indexes.append("7")
		indexes.append("8")
		indexes.append("9")
		indexes.append("A")
		indexes.append("B")
		indexes.append("C")
		indexes.append("D")
		indexes.append("F")
		indexes.append("G")
		indexes.append("H")
		indexes.append("I")
		indexes.append("E")
