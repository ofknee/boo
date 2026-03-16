extends CanvasLayer


func _ready() -> void:
	$ColorRect.modulate.a = 0.0
	$Sprite2D.modulate.a = 0.0
	Global.end_screen.connect(func():
		self.visible = true
		var t = create_tween().set_trans(Tween.TRANS_LINEAR).set_parallel(true)
		$ColorRect.modulate.a = 0.0
		$Sprite2D.modulate.a = 0.0
		t.tween_property($ColorRect, "modulate:a", 1.0, 1.0)
		t.tween_property($Sprite2D, "modulate:a", 1.0, 1.0).set_delay(0.5)
	)
