extends Node2D

var vel = -400
var rotation_speed = 15 if randi_range(0, 1) == 0 else -15
@onready var scene = get_tree().current_scene

func _ready():
	set_process(true)

func _process(delta):
	if scene.playingState:
		set_position(get_position() + Vector2(vel * delta, 0))
		rotation_degrees += rotation_speed * delta
	else:
		queue_free()
	
	if get_position().x < -150:
		scene.score()
		queue_free()

func _on_meteor_area_body_entered(body):
	if body.get_name() == "Spaceman":
		scene.kill()
