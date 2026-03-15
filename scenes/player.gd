extends PlatformerController2D
class_name Player

var can_dash := false

# Movement is done by parent, code here is for logic like attacking and stuff
func _ready():
	super()
	Global.player_ref = self

func _handle_dashing():
	if can_dash: super()
