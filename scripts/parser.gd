extends Node2D

# Use backtracking cos i cba to do LL(1) and these statements will be short

func row(tokens):
	if (tokens.size() <= 0): return false
	var tile = tokens.pop_front()
	match tile.letter_text:
		"1": return true
		"2": return true
		"3": return true
		"4": return true
		"5": return true
		"6": return true
		"7": return true
		"8": return true
		"9": return true
		_: return false
		
func col(tokens):
	if (tokens.size() <= 0): return false
	var tile = tokens.pop_front()
	match tile.letter_text:
		"A": return true
		"B": return true
		"C": return true
		"D": return true
		"E": return true
		"F": return true
		"H": return true
		"I": return true
		"J": return true
		_: return false
		
func line(tokens):
	if col(tokens.duplicate()):
		return col(tokens)
	return row(tokens)
	
func swap(tokens):
	var tile
	if (tokens.size() <= 0): return false
	tile = tokens.pop_front()
	if (tile.letter_text != "swap"):
		return false
	if not col(tokens): return false
	if not row(tokens): return false
	if (tokens.size() <= 0): return false
	tile = tokens.pop_front()
	if (tile.letter_text != "with"):
		return false
	if not col(tokens): return false
	if not row(tokens): return false
	return true
	
func shift(tokens):
	var tile
	if (tokens.size() <= 0): return false
	tile = tokens.pop_front()
	if (tile.letter_text != "shift"):
		return false
	if not line(tokens): return false
	return true
	
func statement(tokens):
	if swap(tokens.duplicate()):
		return swap(tokens)
	if shift(tokens.duplicate()):
		return shift(tokens)
	if take(tokens.duplicate()):
		return shift(tokens)
	return repeat(tokens)
	
func repeat(tokens):
	var tile
	if (tokens.size() <= 0): return false
	tile = tokens.pop_front()
	if (tile.letter_text != "x2"):
		return false
	if not statement(tokens): return false
	return true
	
func take(tokens):
	var tile
	if (tokens.size() <= 0): return false
	tile = tokens.pop_front()
	if (tile.letter_text != "take"):
		return false
	if not col(tokens): return false
	if not row(tokens): return false
	return true
	
func parse(tokens):
	var o = statement(tokens)
	if (tokens.size() == 0 and o):
		return true
	else:
		return false
	
		
	
	
