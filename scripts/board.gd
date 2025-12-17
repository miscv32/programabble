extends Node2D

@onready var tile_map = $TileMapLayer

# var boardBuffer = {}
var board_buffer = []
var perm_board = []
const BOARD_W_H = 9

func _ready():
	board_buffer.resize(BOARD_W_H*BOARD_W_H)
	board_buffer.fill(null)
	perm_board.resize(BOARD_W_H*BOARD_W_H)
	perm_board.fill(null)
# Converts pixel position to grid
func get_grid_coords(pixel_pos: Vector2):
	var local_pos = tile_map.to_local(pixel_pos)
	var map_pos = tile_map.local_to_map(local_pos)
	#map_pos.y *= -1
	#map_pos.y += 8
	return map_pos

# Converts grid to pixel center
func get_slot_center(grid_pos: Vector2i):
	#grid_pos.y -= 8
	#grid_pos.y *= -1
	var local_center = tile_map.map_to_local(grid_pos)
	return tile_map.to_global(local_center)

func _pos_to_index(gridPos):
	return gridPos.y*BOARD_W_H + gridPos.x

func _has(arr, gridPos):
	return arr[_pos_to_index(gridPos)] != null

func place(gridPos, tile_ref): # Pass 'self' from the tile
	board_buffer[_pos_to_index(gridPos)] = tile_ref
		
func isValidGridPos(gridPos, requesting_tile):
	# Check if someone ELSE is in this spot
	if _has(board_buffer, gridPos) and board_buffer[_pos_to_index(gridPos)] != requesting_tile: 
		return false
	if _has(perm_board, gridPos):
		return false
	# Bounds check
	return 0 <= gridPos.x and gridPos.x <= 8 and 0 <= gridPos.y and gridPos.y <= 8
	
func flushBoardBuffer():
	for index in range(board_buffer.size()):
		if board_buffer[index] != null:
			var tile = board_buffer[index]
			tile.selectable = false
			board_buffer[index] = null
			perm_board[index] = tile
		
		
func remove(gridPos):
	board_buffer[_pos_to_index(gridPos)] = null
		
func _index_to_pos(index):
	return Vector2i(int(index)/9, index%9)
# Validate stuff
func get_all_new_words() -> Array:
	var new_words = []
	var detected_word_signatures = [] # To avoid duplicates
	
	# Create a combined view of the board for easy lookup
	var full_board = perm_board.duplicate()
	for index in range(board_buffer.size()):
		if board_buffer[index] != null:
			full_board[index] = board_buffer[index]
	
	for index in range(board_buffer.size()):
		if board_buffer[index] != null:
			# Check both axes for every new tile
			for axis in ["horizontal", "vertical"]:
				var word = _get_word_at_pos(_index_to_pos(index), axis, full_board)
				print("Word at index ", index, " is ", word)
				# Create a unique signature based on tile positions to avoid duplicates
				if word.size() >= 2:
					var signature = _get_word_signature(word)
					if not signature in detected_word_signatures:
						detected_word_signatures.append(signature)
						var tile_refs = _convert_to_tile_refs(word, full_board)
						if tile_refs.size() >= 2:
							new_words.append(tile_refs)
	print("new_words is ", new_words)
	return new_words

func _get_word_at_pos(start_pos: Vector2i, axis: String, full_board: Array) -> Array:
	var word_positions = [start_pos]
	var direction = Vector2i(1, 0) if axis == "horizontal" else Vector2i(0, 1)
	
	# Look "Left" or "Up"
	var check_pos = start_pos - direction
	while _has(full_board, check_pos):
		word_positions.append(check_pos)
		check_pos -= direction
		
	# Look "Right" or "Down"
	check_pos = start_pos + direction
	while _has(full_board, check_pos):
		word_positions.append(check_pos)
		check_pos += direction
	
	word_positions.sort() # Ensure they are in reading order (increasing axis)
	return word_positions

func _get_word_signature(pos_array: Array) -> String:
	# Returns a string like "(0,0)(1,0)(2,0)" to uniquely identify the word's footprint
	var s = ""
	for p in pos_array:
		s += str(p)
	return s

func _convert_to_tile_refs(pos_array: Array, full_board: Array) -> Array:
	var tile_refs = []
	for p in pos_array:
		if full_board[_pos_to_index(p)] != null: # not sure that we should need this but fixes bug?
			tile_refs.append(full_board[_pos_to_index(p)])
	return tile_refs
