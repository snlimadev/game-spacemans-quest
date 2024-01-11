extends RigidBody2D

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			on_touch()
		
func on_touch():
	get_node("JetpackSound").play()
	apply_central_impulse(Vector2(0, -750))
