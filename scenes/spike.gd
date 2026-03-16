extends Area2D
class_name Spike

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node2D) ->void:
	if body is not Player: return
	var player = body as Player
	player.kill()
