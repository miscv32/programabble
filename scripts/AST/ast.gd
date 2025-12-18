class_name AST


class ASTNode extends RefCounted:
	func execute(board):
		pass

class ShiftRow extends ASTNode:
	var row
	
	func _init(_row):
		row = _row
		
	func execute(board):
		board.shiftRow(row)
		print ("Shift row")
		
class ShiftCol extends ASTNode:
	var col
	
	func _init(_col):
		col = _col
		
	func execute(board):
		board.shiftCol(col)
		print ("Shift column")
		
class Swap extends ASTNode:
	var posBefore
	var posAfter
	
	func _init(_before, _after):
		posBefore = _before
		posAfter = _after
		
	func execute(board):
		board.swap(posBefore, posAfter)
		print ("Swaparoo")
		
class Take extends ASTNode:
	var pos
	
	func _init(_pos):
		pos = _pos
		
	func execute(board):
		board.deleteAt(pos)
		print ("Take")
		
class Replace extends ASTNode:
	var pos
	var tile
	
	func _init(_pos, _tile):
		pos = _pos
		tile = _tile
		
	func execute(board):
		print ("Replace")
		
class RepTwo extends ASTNode:
	var stmt
	
	func _init(_stmt):
		stmt = _stmt
		
	func execute(board):
		stmt.execute(board)
		stmt.execute(board)
		
class Then extends ASTNode:
	var stmt1
	var stmt2
	
	func _init(_stmt1, _stmt2):
		stmt1 = _stmt1
		stmt2 = _stmt2
		
	func execute(board):
		stmt1.execute(board)
		stmt2.execute(board)
