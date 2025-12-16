@tool
extends Area2D

@onready var shadow = $Shadow
@onready var visual = $BlockBg
@onready var label = $Label
var dragging = false

@export var letter_text: String = "A":
	set(value):
		letter_text = value
		# This ensures the label exists before we try to change it
		var label = get_node_or_null("BlockBg/Label") 
		label.text = value
		rescale_text()

func _input_event(_viewport, event, _shape_idx):
	# Detect Mouse Down
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			z_index += 20
			visual.position -= Vector2(10, 10)
			
			shadow.visible = true
		else:
			dragging = false
			shadow.visible = false
			z_index -= 20
			visual.position += Vector2(10, 10)
			snap_to_grid()

func _ready():
	rescale_text()

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position()

func snap_to_grid():
	# 1. Find the TileMapLayer in your main scene
	# This assumes your TileMapLayer is named "Board" in the main scene
	var board = get_tree().root.find_child("Board", true, false)
	
	if board:
		# 2. Get the mouse position relative to the board
		var mouse_pos = board.get_local_mouse_position()
		
		# 3. Calculate which grid cell the mouse is in (e.g., Vector2i(3, 5))
		var grid_pos = board.get_grid_coords(mouse_pos)
		
		# 4. Find the center of that cell in pixels
		var cell_center_local = board.get_slot_center(grid_pos)
		
		# 5. Snap the tile to that exact spot
		global_position = board.to_global(cell_center_local)
		
func rescale_text():
	var label = get_node_or_null("BlockBg/Label") 
	var max_width = 50 # The width of your wooden tile (minus some padding)
	
	# Reset scale first
	label.scale = Vector2(1, 1)
	label.pivot_offset = label.size / 2
	
	# Check if the label is too wide
	if label.size.x > max_width:
		var new_scale = max_width / label.size.x
		label.scale = Vector2(new_scale, new_scale)
		
	# Re-center the label after scaling
	#label.pivot_offset = label.size / 2
	#label.position = Vector2.ZERO # Assuming your Area2D root is at 0,0
