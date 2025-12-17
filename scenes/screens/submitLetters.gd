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
		var tiles = board.boardBuffer.keys()
		if (not board.validateLine()):
			print ("Incorrect")
			return
		var newWords = board.get_all_new_words()
		for word in newWords:
			for tile in word:
				print (tile.letter_text)
			print ("")
		board.flushBoardBuffer()
