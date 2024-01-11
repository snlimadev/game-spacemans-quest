extends Marker2D

@onready var meteor = preload("res://scenes/meteor.tscn")

func _ready():
	randomize()

func _on_timer_timeout():
	var newMeteor = meteor.instantiate()
	newMeteor.rotation = randi_range(1, 360)
	newMeteor.set_position(get_position() + Vector2(0, randi_range(-600, 600)))
	get_owner().add_child(newMeteor)
