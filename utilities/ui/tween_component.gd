@tool
#class_name Tweenable
extends Node

@export var property: String = "scale"
@export var target_value: Variant = Vector2.ONE * 1.1
@export var duration: float = 0.2
@export var transition: Tween.TransitionType = Tween.TRANS_SPRING
@export var tween_ease: Tween.EaseType = Tween.EASE_OUT

## Optional pivot control
@export var custom_pivot: Vector2 = Vector2(0.5, 0.5)

var parent_control: Control
var original_value: Variant


func _ready():
	parent_control = get_parent() as Control
	
	if parent_control == null:
		push_warning("Tweenable must be a child of Control")
		return
	
	await get_tree().process_frame
	
	# store starting value
	original_value = parent_control.get(property)

	# pivot setup
	parent_control.pivot_offset = parent_control.size * custom_pivot

	parent_control.mouse_entered.connect(_hover_enter)
	parent_control.mouse_exited.connect(_hover_exit)


func _hover_enter():
	_tween_to(target_value)


func _hover_exit():
	_tween_to(original_value)


func _tween_to(value: Variant):
	if parent_control.get(property) == value:
		return
	
	var t := create_tween()
	t.tween_property(parent_control, property, value, duration)\
		.set_trans(transition)\
		.set_ease(tween_ease)
