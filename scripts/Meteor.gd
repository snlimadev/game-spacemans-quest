extends Node2D

var vel = -400
@onready var scene = get_tree().current_scene

func _ready():
	set_process(true)

func _process(delta):
	if scene.playingState:
		set_position(get_position() + Vector2(vel * delta, 0))
	else:
		queue_free()
	
	if get_position().x < -150:
		scene.score()
		queue_free()

func _on_meteor_area_body_entered(body):
	if body.get_name() == "Spaceman":
		scene.kill()
