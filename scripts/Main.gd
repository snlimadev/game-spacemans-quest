extends Node2D

var username = env.username
var password = env.password
@onready var enterNameContainer = get_node("EnterNameContainer")
@onready var startGameContainer = get_node("StartGameContainer")
@onready var loadingLabel = get_node("LoadingGameLabel")
@onready var loadingTimer = get_node("LoadingGameTimer")
@onready var input = get_node("EnterNameContainer/EnterNameInput")
@onready var regenerateTokenTimer = get_node("/root/Global/RegenerateToken")
@onready var authRequest = get_node("/root/Global/Auth")

func _on_start_game_button_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			loadingTimer.start()
			Global.player = input.text.strip_edges()
			authRequest.auth()
			enterNameContainer.hide()
			startGameContainer.hide()
			loadingLabel.show()

func _on_loading_game_timer_timeout():
	regenerateTokenTimer.start()
	get_tree().change_scene_to_file("res://scenes/game_node.tscn")
