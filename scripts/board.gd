extends Node2D

@onready var tile_map = $TileMapLayer

var onBoard = {}
	
# Converts pixel position to grid
func get_grid_coords(pixel_pos: Vector2):
	var local_pos = tile_map.to_local(pixel_pos)
	var map_pos = tile_map.local_to_map(local_pos)
	map_pos.y *= -1
	map_pos.y += 8
	return map_pos

# Converts grid to pixel center
func get_slot_center(grid_pos: Vector2i):
	grid_pos.y -= 8
	grid_pos.y *= -1
	var local_center = tile_map.map_to_local(grid_pos)
	return tile_map.to_global(local_center)
	
func place(gridPos, tile_ref): # Pass 'self' from the tile
	onBoard[gridPos] = tile_ref
		
func isValidGridPos(gridPos, requesting_tile):
	# Check if someone ELSE is in this spot
	if onBoard.has(gridPos) and onBoard[gridPos] != requesting_tile: 
		return false
	# Bounds check
	return 0 <= gridPos.x and gridPos.x <= 8 and 0 <= gridPos.y and gridPos.y <= 8
		
func remove(gridPos):
	onBoard.erase(gridPos)
		
