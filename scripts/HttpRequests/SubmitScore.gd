extends Node

func _ready():
	$HTTPRequest.request_completed.connect(_on_submit_request_completed)
	
func submitScore(score):
	if Global.player != "" && Global.token != "" && score > 0:
		var url = "https://api-game-leaderboards.vercel.app/submit_score"
		var authHeader = "Authorization: Bearer " + Global.token
		var headers = ["Content-Type: application/json", authHeader]
		var dataToSend = {
			"player": Global.player,
			"score": score,
			"platform": "android",
			"game": "spaceman"
		}
		var json = JSON.stringify(dataToSend)

		$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)

func _on_submit_request_completed(_result, response_code, _headers, _body):
	if response_code == 200:
		print("Score submitted")
