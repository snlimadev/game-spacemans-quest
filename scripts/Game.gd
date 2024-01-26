extends Node2D

var points = 0
var playingState = true
@onready var spaceman = get_node("Spaceman")
@onready var pointsLabel = get_node("Score/PointsLabel")
@onready var credits = get_node("GameOverScreen/Credits")
@onready var showRankingButton = get_node("GameOverScreen/ShowRankingButton")
@onready var buttonsContainer = get_node("GameOverScreen/Buttons")
@onready var restartGameTimer = get_node("GameOverScreen/RestartGameTimer")
@onready var rankingWindow = get_node("RankingWindow")
@onready var positions = get_node("RankingWindow/RankingContainer/Positions")
@onready var players =  get_node("RankingWindow/RankingContainer/Players")
@onready var scores =  get_node("RankingWindow/RankingContainer/Scores")
@onready var showRankingTimer = get_node("RankingWindow/ShowRankingTimer")
@onready var loading = get_node("LoadingLabel")
@onready var scoreSound = get_node("Sound/ScoreSound")
@onready var hitSound = get_node("Sound/HitSound")
@onready var mainTheme = get_node("Sound/MainTheme")
@onready var submitScoreRequest = get_node("/root/Global/SubmitScore")
@onready var getRankingRequest = get_node("/root/Global/GetRanking")

func _ready():
	mainTheme.play()
	
func kill():
	restartGameTimer.start()
	submitScoreRequest.submitScore(points)
	Input.vibrate_handheld()
	mainTheme.stop()
	hitSound.play()
	playingState = false
	spaceman.process_mode = 4 # Mode: Disabled
	spaceman.hide()
	credits.show()
	loading.show()
	
func score():
	scoreSound.play()
	points += 1
	pointsLabel.set_text(str(points))

func _on_limits_body_entered(body):
	if body.get_name() == "Spaceman":
		kill()

func getTopScores():
	if Global.ranking != []:
		var arrPositions = ["RANK. |"]
		var arrPlayers = ["PLAYER"]
		var arrScores = ["| SCORE"]

		for item in Global.ranking:
			arrPositions.append(str(item["position"]))
			arrPlayers.append(str(item["player"]))
			arrScores.append(str(item["score"]))

		var strPositions = ""
		var strPlayers = ""
		var strScores = ""

		for i in range(arrPositions.size()):
			strPositions += str(arrPositions[i])
			strPlayers += str(arrPlayers[i])
			strScores += str(arrScores[i])

			if i < arrPositions.size() - 1:
				strPositions += "\n"
				strPlayers += "\n"
				strScores += "\n"

		positions.text = strPositions
		players.text = strPlayers
		scores.text = strScores

func _on_show_ranking_button_gui_input(showRankingEvent):
	if showRankingEvent is InputEventScreenTouch:
		if showRankingEvent.pressed:
			showRankingTimer.start()
			getRankingRequest.getRanking()
			showRankingButton.hide()
			buttonsContainer.hide()
			loading.show()

func _on_show_ranking_timer_timeout():
	getTopScores()
	loading.hide()
	rankingWindow.show()

func closeModal():
	rankingWindow.hide()
	showRankingButton.show()
	buttonsContainer.show()

func _on_ranking_window_close_requested():
	closeModal()

func _on_back_button_gui_input(backButtonEvent):
	if backButtonEvent is InputEventScreenTouch:
		if backButtonEvent.pressed:
			closeModal()

func _on_restart_button_gui_input(restartEvent):
	if restartEvent is InputEventScreenTouch:
		if restartEvent.pressed:
			get_tree().reload_current_scene()

func _on_restart_game_timer_timeout():
	loading.hide()
	buttonsContainer.show()
	
	if Global.player != "" && Global.token != "":
		showRankingButton.show()

func _on_quit_button_gui_input(quitEvent):
	if quitEvent is InputEventScreenTouch:
		if quitEvent.pressed:
			get_tree().quit()
