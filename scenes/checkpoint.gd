@tool
extends Node2D
class_name Checkpoint

@export_subgroup("Nodes", "n_")
@export var n_sprite : AnimatedSprite2D
@export var n_area : Area2D
@export var dur := 0.5
@export_tool_button("Test anim") var action_checkpoint = _checkpointed
var t : Tween
func _ready() -> void:
	n_area.body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node2D) -> void:
	if body is not Player: return
	_checkpointed()

func _checkpointed() -> void:
	if t and t.is_running(): t.kill()
	t = create_tween().set_trans(Tween.TRANS_SINE).set_loops(2)
	t.tween_property(n_sprite, "modulate", Color.WHITE * 1.3, dur)
	t.tween_property(n_sprite, "modulate", Color.WHITE, dur)
	t.tween_callback(func(): print("Going"))
	if not Engine.is_editor_hint():
		CheckpointManager.register_checkpoint(self)
