extends Node2D
class_name Game

signal _move_command

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		emit_signal("_move_command", event.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
