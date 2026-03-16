extends Area2D
class_name Sign


@onready var textbox = get_node("/root/Main/textbox")
@onready var label: RichTextLabel = $RichTextLabel
@export var text_arr : Array[String] = []
var interactable := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	label.visible_ratio = 0.0
	await get_tree().process_frame
	Global.player_ref.interact.connect(_on_interact)


func _tween_label(forwards:bool=true) -> void:
	var t = create_tween().set_ease(Tween.EASE_OUT)
	if forwards:
		t.tween_property(label, "visible_ratio", 1.0, 0.3)
	else:
		t.tween_property(label, "visible_ratio", 0.0, 0.3)

func _on_interact() -> void:
	if interactable:
		for text in text_arr:
			textbox.queue_text(text)
	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		interactable = true
		_tween_label(true)
func _on_body_exited(body:Node2D):
	print("Exited")
	if body is Player:
		interactable = false
		_tween_label(false)
		
