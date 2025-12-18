extends Node2D

# Use backtracking cos i cba to do LL(1) and these statements will be short

func row(tokens):
	if (tokens.size() <= 0): return false
	var tile = tokens.pop_front()
	match tile.letter_text:
		"1": return 8
		"2": return 7
		"3": return 6
		"4": return 5
		"5": return 4
		"6": return 3
		"7": return 2
		"8": return 1
		"9": return 0
		_: return null
		
func col(tokens):
	if (tokens.size() <= 0): return false
	var tile = tokens.pop_front()
	match tile.letter_text:
		"A": return 0
		"B": return 1
		"C": return 2
		"D": return 3
		"E": return 4
		"F": return 5
		"G": return 6
		"H": return 7
		"I": return 8
		_: return null
		
func line(tokens):
	if col(tokens.duplicate()) != null:
		var c = col(tokens)
		return ["col", c]
	if row(tokens.duplicate()) != null:
		var r = row(tokens)
		return ["row", r]
	return null
	
func tile(tokens):
	if (tokens.size() <= 0): return null
	var tile = tokens.pop_front()
	return tile.letter_text
	
func swap(tokens):
	var tile
	if (tokens.size() <= 0): return null
	tile = tokens.pop_front()
	if (tile.letter_text != "swap"):
		return null
	var c1 = col(tokens)
	if  c1 == null: return null
	var r1 = row(tokens)
	
	if  r1 == null: return null
	if (tokens.size() <= 0): return null
	tile = tokens.pop_front()
	if (tile.letter_text != "with"):
		return null
	var c2 = col(tokens)
	if  c2 == null: return null
	var r2 = row(tokens)
	
	if  r2 == null: return null
	return AST.Swap.new(Vector2i(c1, r1), Vector2i(c2, r2))
	
func shift(tokens):
	var tile
	if (tokens.size() <= 0): return null
	tile = tokens.pop_front()
	if (tile.letter_text != "shift"):
		return null
	var t = line(tokens)
	if t == null: return null
	var l = t as Array
	if l[0] == "row":
		return AST.ShiftRow.new(l[1])
	else:
		return AST.ShiftCol.new(l[1])
	
func statement(tokens):
	if swap(tokens.duplicate()) != null:
		return swap(tokens)
	if replace(tokens.duplicate()) != null:
		return replace(tokens)
	if shift(tokens.duplicate()) != null:
		return shift(tokens)
	if take(tokens.duplicate()) != null:
		return take(tokens)
	if repeat(tokens) != null:
		return repeat(tokens)
	return null
	
func repeat(tokens):
	var tile
	if (tokens.size() <= 0): return null
	tile = tokens.pop_front()
	if (tile.letter_text != "x2"):
		return null
	var stmt = statement(tokens)
	if stmt == null: return null
	return AST.RepTwo.new(stmt)
	
func take(tokens):
	var tile
	if (tokens.size() <= 0): return null
	tile = tokens.pop_front()
	if (tile.letter_text != "take"):
		return null
	var c1 = col(tokens)
	if  c1 == null: return null
	var r1 = row(tokens)
	if  r1 == null: return null
	return AST.Take.new(Vector2i(c1, r1))
	
func replace(tokens):
	var tile
	if (tokens.size() <= 0): return null
	tile = tokens.pop_front()
	if (tile.letter_text != "replace"):
		return null
	var c1 = col(tokens)
	if  c1 == null: return null
	var r1 = row(tokens)
	
	if  r1 == null: return null
	if (tokens.size() <= 0): return null
	tile = tokens.pop_front()
	if (tile.letter_text != "with"):
		return null
	var t = tile(tokens)
	if t == null: return null
	return AST.Replace.new(Vector2i(c1, r1), t)
	
func parse(tokens):
	# Cheat for then to avoid manipulating grammar
	var splitStatements = []
	var currentStatement = []
	var parsedStatement
	for token in tokens:
		if token.letter_text == "then":
			parsedStatement = statement(currentStatement)
			if parsedStatement == null: return null
			splitStatements.append(parsedStatement)
			if (currentStatement.size() > 0): return null
			currentStatement = []
			continue
		currentStatement.append(token)
	parsedStatement = statement(currentStatement)
	if parsedStatement == null: return null
	splitStatements.append(parsedStatement)
	if (currentStatement.size() > 0): return null
	var final = AST.ASTNode.new()
	for s in splitStatements:
		print (final, s)
		final = AST.Then.new(final, s)
	return final
		
	
		
	
	
