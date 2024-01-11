extends Node2D

var points = 0
var playingState = true
@onready var spaceman = get_node("Spaceman")
@onready var pointsLabel = get_node("Score/PointsLabel")
@onready var gameOverScreen = get_node("GameOverScreen")
@onready var scoreSound = get_node("Sound/ScoreSound")
@onready var hitSound = get_node("Sound/HitSound")
@onready var mainTheme = get_node("Sound/MainTheme")

func _ready():
	mainTheme.play()
	
func kill():
	Input.vibrate_handheld()
	mainTheme.stop()
	hitSound.play()
	playingState = false
	spaceman.process_mode = 4 # Mode: Disabled
	spaceman.hide()
	gameOverScreen.show()
	
func score():
	scoreSound.play()
	points += 1
	pointsLabel.set_text(str(points))

func _on_limits_body_entered(body):
	if body.get_name() == "Spaceman":
		kill()

func _on_restart_button_gui_input(restartEvent):
	if restartEvent is InputEventScreenTouch:
		if restartEvent.pressed:
			get_tree().reload_current_scene()

func _on_quit_button_gui_input(quitEvent):
	if quitEvent is InputEventScreenTouch:
		if quitEvent.pressed:
			get_tree().quit()
