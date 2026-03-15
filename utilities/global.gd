extends Node

var player_ref : Player

const MAIN = preload("res://scenes/main.tscn")
func go_to_main():
	get_tree().change_scene_to_packed(MAIN)
