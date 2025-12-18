class_name AST


class ASTNode extends RefCounted:
	func execute():
		pass

class ShiftRow extends ASTNode:
	var row
	
	func _init(_row):
		row = _row
		
	func execute():
		print ("Shift row")
		
class ShiftCol extends ASTNode:
	var col
	
	func _init(_col):
		col = _col
		
	func execute():
		print ("Shift column")
		
class Swap extends ASTNode:
	var posBefore
	var posAfter
	
	func _init(_before, _after):
		posBefore = _before
		posAfter = _after
		
	func execute():
		print ("Swaparoo")
		
class Take extends ASTNode:
	var pos
	
	func _init(_pos):
		pos = _pos
		
	func execute():
		print ("Take")
		
class Replace extends ASTNode:
	var pos
	var tile
	
	func _init(_pos, _tile):
		pos = _pos
		tile = _tile
		
	func execute():
		print ("Replace")
		
class RepTwo extends ASTNode:
	var stmt
	
	func _init(_stmt):
		stmt = _stmt
		
	func execute():
		stmt.execute()
		stmt.execute()
		
class Then extends ASTNode:
	var stmt1
	var stmt2
	
	func _init(_stmt1, _stmt2):
		stmt1 = _stmt1
		stmt2 = _stmt2
		
	func execute():
		stmt1.execute()
		stmt2.execute()
