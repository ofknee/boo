extends Area2D


@onready var textbox = get_node("/root/Main/textbox")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		textbox.queue_text("Best turn back now, brave wandered.")
		textbox.queue_text("The night is perennial and perpetual. The light is but illusory and conceptual.")
