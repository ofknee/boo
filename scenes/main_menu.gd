extends MenuBase
class_name MainMenu


@export var buttons : Array[Button] = []
var dur := 1.0
var tweenables : Array[Tweenable]
var t : Tween

func _ready() -> void:
	for button in buttons:
		if not button: continue
		button.pressed.connect(_on_but_pressed.bind(button.name))
	tweenables = MenuBase.get_all_tweenables(self)
	start_anim()


func start_anim():
	if t and t.is_running(): t.kill()
	t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT).set_parallel(true)
	for tweenable in MainMenu.get_all_tweenables(self):
		tweenable.par.global_position = tweenable.og_gl_pos
		t.tween_property(tweenable.par, "global_position", tweenable.get_final_global_pos(), dur)

func end_anim():
	if t and t.is_running(): t.kill()
	t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT).set_parallel(true)
	for tweenable in MainMenu.get_all_tweenables(self):
		tweenable.par.global_position = tweenable.get_final_global_pos()
		t.tween_property(tweenable.par, "global_position", tweenable.og_gl_pos, dur)


func _on_but_pressed(button_name:String):
	print("Button pressed, name is: %s" % button_name)
	match button_name.to_lower():
		"play":
			Global.go_to_main()
		"settings":
			pass
		"explanation":
			pass
		"quit":
			get_tree().quit()
