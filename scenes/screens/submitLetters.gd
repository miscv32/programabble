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
		
		if (not allNewLetterWord):
			print ("Invalid")
			return
		for word in newWords:
			for tile in word:
				print (tile.letter_text)
			print ("")
		board.flushBoardBuffer()
