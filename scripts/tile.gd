@tool
extends Area2D

@onready var shadow = $Shadow
@onready var visual = $BlockBg
@onready var label = $Label

var dragging = false
var selectable = true
var prevPos
var originalPos
var top_left = Vector2i(0,0)

@export var letter_text: String = "A":
	set(value):
		letter_text = value
		# This ensures the label exists before we try to change it
		var label = get_node_or_null("BlockBg/Label")
		if label:
			label.text = value
			rescale_text()

func _input_event(_viewport, event, _shape_idx):
	# Detect Mouse Down
	if (selectable == false): return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		
		if event.pressed:
			prevPos = global_position
			dragging = true
			z_index += 20
			visual.position -= Vector2(10, 10)
			# Makes sure that no more tiles below get dragged
			shadow.visible = true
		else:
			if (dragging == false): return
			dragging = false
			shadow.visible = false
			z_index -= 20
			visual.position += Vector2(10, 10)
			if (not snap_to_grid()):
				global_position = prevPos
		get_viewport().set_input_as_handled()

func _ready():
	prevPos = global_position 
	originalPos = global_position
	rescale_text()

func _process(_delta):
	if dragging:
		
		global_position = get_global_mouse_position()

func snap_to_grid():
	var board = get_tree().root.find_child("Board", true, false)
	
	if board:
		var mouse_pos = get_global_mouse_position()
		
		var grid_pos = board.get_grid_coords(mouse_pos)
		
		if (not board.isValidGridPos(grid_pos, self)):
			return false
		
		var global_center = board.get_slot_center(grid_pos)
		
		global_position = global_center
		
		var prev_grid_pos = board.get_grid_coords(prevPos)
		board.remove(prev_grid_pos - top_left)
		prevPos = global_position
		board.place(grid_pos - top_left, self)
		
		return true
	return false
		
func rescale_text():
	var label = get_node_or_null("BlockBg/Label")
	if label:
		var max_width = 50 # The width of your wooden tile (minus some padding)
		
		# Reset scale first
		label.scale = Vector2(1, 1)
		label.pivot_offset = label.size / 2
		
		# Check if the label is too wide
		if label.size.x > max_width:
			var new_scale = max_width / label.size.x
			label.scale = Vector2(new_scale, new_scale)
