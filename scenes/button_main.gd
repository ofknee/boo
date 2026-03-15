@tool
extends Button
class_name ButtonMain
@export_subgroup("Nodes", "node_")
@export var node_title_label : RichTextLabel
@export var node_selector : Panel
@export var node_bg : Panel
@export var title : String = "Title" :
	set(v):
		if title == v: return
		title = v
		_update_title()
var dur := 0.5
var t : Tween
var selector_og_pos : Vector2 = Vector2.ZERO

func _update_title()->void:
	if node_title_label:
		node_title_label.text = title
	self.name = title

func _ready() -> void:
	_update_title()
	self.pivot_offset_ratio = Vector2.ONE/2
	await self.resized
	await get_tree().process_frame
	await get_tree().process_frame
	selector_og_pos = node_selector.position
	node_title_label.pivot_offset_ratio = Vector2.ONE/2
	node_bg.pivot_offset_ratio = Vector2.ONE/2
	_unhover()

func _selector_final_pos() -> Vector2:
	return selector_og_pos + Vector2.LEFT * 700
	

func _on_pressed() -> void:
	if t and t.is_running(): t.kill()
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	t = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
	t.tween_property(node_title_label, "scale", Vector2.ONE , dur/7.)
	t.tween_property(node_bg, "scale", Vector2.ONE , dur/7.)
	t.chain()
	t.tween_property(node_title_label, "scale", Vector2.ONE * 1.1, dur/7.)
	t.tween_property(node_bg, "scale", Vector2.ONE * 1.1, dur/7.)

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_MOUSE_ENTER:
			_hover()
		NOTIFICATION_MOUSE_EXIT:
			_unhover()

func _hover() -> void:
	if t and t.is_running(): t.kill()
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	t = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
	t.tween_property(node_selector, "position", selector_og_pos, dur)
	t.tween_property(node_title_label, "scale", Vector2.ONE * 1.1, dur)
	t.tween_property(node_bg, "scale", Vector2.ONE * 1.1, dur)

func _unhover() -> void:
	if t and t.is_running(): t.kill()
	self.mouse_default_cursor_shape = Control.CURSOR_ARROW
	t = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).set_parallel(true)
	t.tween_property(node_selector, "position", _selector_final_pos(), dur)
	t.tween_property(node_title_label, "scale", Vector2.ONE , dur)
	t.tween_property(node_bg, "scale", Vector2.ONE , dur)
