extends PlatformerController2D
class_name Player

# Movement is done by parent, code here is for logic like attacking and stuff
func _ready():
	super()
	Global.player_ref = self
