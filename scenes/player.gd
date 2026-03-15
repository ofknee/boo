extends PlatformerController2D
class_name Player

@export_subgroup("Nodes", "n_")
@export var n_flashlight_pivot : Node2D
@export var n_flashlight : PointLight2D
@export var flashlight_on := true
var can_dash := false

# Movement is done by parent, code here is for logic like attacking and stuff
func _ready():
	super()
	Global.player_ref = self

func _process(_delta):
	if flashlight_on:
		var dir = n_flashlight_pivot.get_angle_to(get_global_mouse_position())
		n_flashlight_pivot.global_rotation = lerp(n_flashlight_pivot.global_rotation, n_flashlight_pivot.global_rotation+dir, 0.2)
		n_flashlight.show()
	else:
		n_flashlight.hide()

func _on_death():
	CheckpointManager.teleport_player()

func _handle_dashing():
	if can_dash: super()
