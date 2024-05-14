extends CharacterBody2D
class_name Unit

var selected = false
var speed = 200
var move_target = self.position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.selected:
		self.rotation_degrees = 180
	else:
		self.rotation_degrees = 0

func _physics_process(delta):
	velocity = position.direction_to(move_target) * speed
	# look_at(target)
	if position.distance_to(move_target) > 10:
		move_and_slide()

func _on_game__move_command(destination: Vector2):
	if selected:
		move_target = destination
