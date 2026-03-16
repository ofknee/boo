extends Area2D

@export var float_height: float = 3.0
@export var float_speed: float = 2.0

@onready var sprite = $AnimatedSprite2D

var start_y: float
var t: float = 0.0

func _ready():
	start_y = global_position.y
	sprite.play() 

func _process(delta):
	t += delta
	
	# floating motion
	global_position.y = start_y + sin(t * float_speed) * float_height
