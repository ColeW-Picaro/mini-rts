extends Camera2D

#edge
@export_range(0,1000) var edge_margin: float = 25
@export_range(20,40, 0.5) var edge_speed: float = 30

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_edge_move(delta)
	pass

func _edge_move(delta: float) -> void:

	var velocity = Vector2()
	var viewport = get_viewport()
	var visible_rect = viewport.get_visible_rect()

	var m_pos = viewport.get_mouse_position()

	if m_pos.x < edge_margin:
		velocity.x = lerp(
			velocity.x,
			velocity.x - abs(m_pos.x - edge_margin)/edge_margin * edge_speed, 
			edge_speed * delta 
		)
	elif m_pos.x > visible_rect.size.x - edge_margin:
		velocity.x = lerp(
			velocity.x,
			velocity.x + abs(m_pos.x - visible_rect.size.x + edge_margin)/edge_margin * edge_speed, 
			edge_speed * delta 
		)
	if m_pos.y < edge_margin:
		velocity.y = lerp(
			velocity.y,
			velocity.y - abs(m_pos.y - edge_margin)/edge_margin * edge_speed, 
			edge_speed * delta 
		)
	elif m_pos.y > visible_rect.size.y - edge_margin:
		velocity.y = lerp(
			velocity.y,
			velocity.y + abs(m_pos.y - visible_rect.size.y + edge_margin)/edge_margin * edge_speed, 
			edge_speed * delta 
		)
	global_translate(velocity)
