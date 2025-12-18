extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _values(arr):
	var res = []
	for x in arr:
		if x != null:
			res.append(x)
	return res
	
func _keys(arr):
	var board = get_tree().root.find_child("Board", true, false)
	var res = []
	for i in range(arr.size()):
		if arr[i] != null:
			res.append(board._index_to_pos(i))
	return res
func _button_pressed():
	var board = get_tree().root.find_child("Board", true, false)
	if board:
		var tiles = _values(board.board_buffer)
		var newWords = board.get_all_new_words()
		
		# Check if the tiles form a line
		if (not _checkLine(tiles, newWords)):
			print("Tiles do not form a line")
			print ("Invalid")
			_reset_tiles(tiles)
			return
			
		# Check if the word is attatched to some other word 
		var existing = _values(board.perm_board)
		var newPositions = _keys(board.board_buffer)
		if not (_checkCombining(existing, newWords) or Vector2i(4, 4) in newPositions):

			print(board.board_buffer)
			print("Word is not attached to some other word")
			_reset_tiles(tiles)
			return
		
			
			
		# make sure the grammar is valid
		var parser = get_tree().root.find_child("Parser", true, false)
		#print("newWords is ", newWords)
		for word in newWords:
			if (not parser.parse(word)):
				print("Parser could not parse this word")
				_reset_tiles(tiles)
				return
		
		board.flushBoardBuffer()
		
		var tileRack = get_tree().root.find_child("TileRack", true, false)
		if tileRack:
			for tile in tiles:
				tileRack.remove_tile(tile)
			tileRack.refill_rack()
		
func _checkLine(tiles, newWords):
	var allNewLetterWord = false
	for word in newWords:
		var wordGood = true
		for tile in tiles:
			if (word.has(tile) == false):
				wordGood = false
				break
		if wordGood:
			allNewLetterWord = true
			break
	return allNewLetterWord
	
func _reset_tiles(tiles):
	var tileRack = get_tree().root.find_child("TileRack", true, false)
	if tileRack:
		tileRack.reset_tiles()
	
	
func _checkCombining(existing, newWords):
	for word in newWords:
		for tile in existing:
			if word.has(tile): return true
	return false
