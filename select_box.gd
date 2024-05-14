extends Node2D
class_name SelectBox

var dragging = false;
var selected_units = [];
var drag_start = Vector2.ZERO;
var drag_end = Vector2.ZERO
var select_rect = RectangleShape2D.new();

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Later check if there's no command being issued
			dragging = true
			drag_start = event.position
		# If the mouse is released and is dragging, stop dragging
		elif dragging:
			dragging = false
			queue_redraw()
			drag_end = event.position
			select_rect.extents = abs(drag_end - drag_start)
			select_units()	
			
	if event is InputEventMouseMotion and dragging:
		queue_redraw()

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), Color.YELLOW, false, 2.0)	

func select_units():
	var space = get_world_2d().direct_space_state
	
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = select_rect
	query.collision_mask = 2  # Units are on collision layer 2
	query.transform = Transform2D(0, abs(drag_end + drag_start) / 2)
	
	var old_selected_units = selected_units
	var new_selected_units = space.intersect_shape(query)
	
	if new_selected_units.size() > 0:
		selected_units = new_selected_units
		for unit in old_selected_units:
			unit.collider.selected = false
		for unit in selected_units:
			unit.collider.selected = true
	
	drag_start = Vector2.ZERO
	drag_end = Vector2.ZERO
		

