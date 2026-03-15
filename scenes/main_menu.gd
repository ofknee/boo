extends MenuBase
class_name MainMenu


@export var buttons : Array[Button] = []
var tweenables : Array[Tweenable]

func _ready() -> void:
	for button in buttons:
		button.pressed.connect(_on_but_pressed.bind(button.name))
	tweenables = MenuBase.get_all_tweenables(self)
	start_anim()


func start_anim():
	pass

func end_anim():
	pass


func _on_but_pressed(button_name:String):
	print("Button pressed, name is: %s" % button_name)
	match button_name.to_lower():
		"play":
			#get_tree().change_scene_to_packed(SELECT_MENU)
			pass
		"settings":
			pass
		"explanation":
			pass
		"quit":
			get_tree().quit()
