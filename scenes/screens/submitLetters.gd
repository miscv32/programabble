extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _button_pressed():
	var board = get_tree().root.find_child("Board", true, false)
	if board:
		var tiles = board.boardBuffer.values()
		var newWords = board.get_all_new_words()
		
		# Check if the tiles form a line
		if (not _checkLine(tiles, newWords)):
			print ("Invalid")
			return
			
		# Check if the word is attatched to some other word 
		var existing = board.permBoard.values()
		var newPositions = board.boardBuffer.keys()
		if not (_checkCombining(existing, newWords) or Vector2i(4, 4) in newPositions):
			print ("Invalid")
			return
		
			
			
		for word in newWords:
			for tile in word:
				print (tile.letter_text)
			print ("")
		board.flushBoardBuffer()
		
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
	
func _checkCombining(existing, newWords):
	for word in newWords:
		for tile in existing:
			if word.has(tile): return true
	return false
