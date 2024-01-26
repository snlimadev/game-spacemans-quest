extends Node

var player = ""
var token = ""
var ranking = []

func _on_regenerate_token_timeout():
	if player != "" && token != "":
		get_node("Auth").auth()
