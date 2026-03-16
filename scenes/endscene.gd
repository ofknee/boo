extends CanvasLayer

@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _ready() -> void:
	$ColorRect.modulate.a = 0.0
	$Sprite2D.modulate.a = 0.0
	rich_text_label.modulate.a = 0.0
	Global.end_screen.connect(func():
		self.visible = true
		var t = create_tween().set_trans(Tween.TRANS_LINEAR).set_parallel(true)
		$ColorRect.modulate.a = 0.0
		$Sprite2D.modulate.a = 0.0
		rich_text_label.modulate.a = 0.0
		t.tween_property($ColorRect, "modulate:a", 1.0, 1.0)
		t.tween_property($Sprite2D, "modulate:a", 1.0, 1.0).set_delay(0.5)
		t.tween_property(rich_text_label, "modulate:a", 1.0, 1.0)
	)
