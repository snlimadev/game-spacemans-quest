extends Node

func _ready():
	$HTTPRequest.request_completed.connect(_on_auth_request_completed)

func auth():
	if Global.player != "" && env.username != "" && env.password != "":
		var url = "https://api-game-leaderboards.vercel.app/auth"
		var headers = ["Content-Type: application/json"]
		var dataToSend = {
			"username": env.username,
			"password": env.password
		}
		var json = JSON.stringify(dataToSend)

		$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)

func _on_auth_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		Global.token = json["access_token"]
		print("Token received")
