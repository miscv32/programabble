extends Node2D

@onready var tile_map = $TileMapLayer
	
# Converts pixel position to grid
func get_grid_coords(pixel_pos: Vector2):
	var local_pos = tile_map.to_local(pixel_pos)
	return tile_map.local_to_map(local_pos + Vector2(0, -20))

# Converts grid to pixel center
func get_slot_center(grid_pos: Vector2i):
	var local_center = tile_map.map_to_local(grid_pos)
	return tile_map.to_global(local_center) + Vector2(-3, 25)
