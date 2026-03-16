extends Node

var player_ref : Player :
	set(v):
		player_ref = v
		CheckpointManager.register_player(v)

const MAIN = preload("res://scenes/main.tscn")
func go_to_main():
	get_tree().change_scene_to_packed(MAIN)

signal end_screen
var has_ended := false
