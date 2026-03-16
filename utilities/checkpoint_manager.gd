extends Node

var latest_checkpoint : Checkpoint = null

func register_checkpoint(cp:Checkpoint) -> void:
	if cp == latest_checkpoint: return
	latest_checkpoint = cp

func teleport_player():
	print("Teleporting player to checkpoint")
	if latest_checkpoint:
		Global.player_ref.global_position = latest_checkpoint.global_position
	else:
		#TODO Add the spawnpoint
		Global.player_ref.global_position = Vector2.ZERO
