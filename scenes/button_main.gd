@tool
extends Button
class_name ButtonMain
@export_subgroup("Nodes", "node_")
@export var node_title_label : RichTextLabel
@export var title : String = "Title" :
	set(v):
		if title == v: return
		title = v
		_update_title()
var dur := 0.7
var t : Tween

func _update_title()->void:
	if node_title_label:
		node_title_label.text = title
	self.name = title

func _ready() -> void:
	_update_title()
	self.pivot_offset_ratio = Vector2.ONE/2

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_MOUSE_ENTER:
			_hover()
		NOTIFICATION_MOUSE_EXIT:
			_unhover()

func _hover() -> void:
	if t and t.is_running(): t.kill()
	t = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
	t.tween_property(self, "scale", Vector2.ONE * 1.1, dur)

func _unhover() -> void:
	if t and t.is_running(): t.kill()
	t = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
	t.tween_property(self, "scale", Vector2.ONE, dur)
