extends CanvasLayer

const CHAR_READ_RATE = 0.05

@onready var textbox_container = $textboxcontainer
@onready var start_symbol = $textboxcontainer/MarginContainer/HBoxContainer/start
@onready var end_symbol = $textboxcontainer/MarginContainer/HBoxContainer/end
@onready var label = $textboxcontainer/MarginContainer/HBoxContainer/label

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue: Array[String] = []
var tween: Tween

func _ready():
	print("Starting state: State.READY")
	hide_textbox()
	queue_text("All I ever wanted was to see the moon.")
	queue_text("Our ancestors left earth crystals to help you.")
	queue_text("They shall be your checkpoint. Should you die, you will respawn at your last touched crystal.")


func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()

		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				if tween:
					tween.kill()
				end_symbol.text = "enter"
				change_state(State.FINISHED)

		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text: String):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.visible_ratio = 0.0
	
	change_state(State.READING)
	show_textbox()

	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, next_text.length() * CHAR_READ_RATE)

	await tween.finished
	end_symbol.text = "v"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
