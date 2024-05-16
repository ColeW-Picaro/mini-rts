extends Control
class_name SelectBox

var isDragging = false;
var selected_units = [];
var start = Vector2.ZERO;
var end = Vector2.ZERO
var mouse_pos = Vector2.ZERO
var global_mouse_pos = Vector2.ZERO
var select_rect = RectangleShape2D.new();

func _process(delta):
	if Input.is_action_just_pressed("LeftClick"):
		isDragging = true
		start = global_mouse_pos
		global_mouse_pos = get_global_mouse_position()
		pass
	if isDragging:
		end = global_mouse_pos
		draw_select_box()
		pass
	if Input.is_action_just_released("LeftClick"):
		isDragging = false
		end = global_mouse_pos
		select_units()
		draw_select_box()
		pass
		
func _unhandled_input(event):
	if event is InputEventMouse:
		mouse_pos = event.position
		global_mouse_pos = get_global_mouse_position()

func draw_select_box():
	self.size = Vector2(abs(start.x - end.x), abs(start.y - end.y)) * int(isDragging)
	self.position = Vector2(min(start.x, end.x), min(start.y, end.y))
		

func select_units():
	select_rect.size = self.size
	var space = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = select_rect
	query.collision_mask = 2  # Units are on collision layer 2
	query.transform = Transform2D(0, abs(end + start) / 2)
	print(query.transform)
	
	var old_selected_units = selected_units
	var new_selected_units = space.intersect_shape(query)
	
	if new_selected_units.size() > 0:
		selected_units = new_selected_units
		for unit in old_selected_units:
			unit.collider.selected = false
		for unit in selected_units:
			unit.collider.selected = true

