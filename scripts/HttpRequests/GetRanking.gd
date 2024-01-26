extends Node

func _ready():
	$HTTPRequest.request_completed.connect(_on_get_ranking_request_completed)

func getRanking():
	if Global.player != "" && Global.token != "":
		var url = "https://api-game-leaderboards.vercel.app/get_ranking"
		var params = "?platform=android&game=spaceman&top=10"
		var authHeader = "Authorization: Bearer " + Global.token
		var headers = ["Content-Type: application/json", authHeader]

		$HTTPRequest.request(url + params, headers, HTTPClient.METHOD_GET)

func _on_get_ranking_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		Global.ranking = json["ranking"]
		print("Ranking data received")
