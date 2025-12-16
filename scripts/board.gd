extends Node2D

@onready var tile_map = $TileMapLayer
	
# Converts pixel position to grid
func get_grid_coords(pixel_pos: Vector2):
	var local_pos = tile_map.to_local(pixel_pos)
	print ("local", local_pos)
	var map_pos = tile_map.local_to_map(local_pos)
	#map_pos.x += 6
	#map_pos.y *= -1
	#map_pos.y += 7
	return map_pos

# Converts grid to pixel center
func get_slot_center(grid_pos: Vector2i):
	#grid_pos.x -= 6
	#grid_pos.y -= 7
	#grid_pos.y *= -1
	var local_center = tile_map.map_to_local(grid_pos)
	print ("local2", local_center)
	return tile_map.to_global(local_center)
