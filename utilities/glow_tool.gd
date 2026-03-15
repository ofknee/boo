@tool
extends Node

@export var path : String = "res://assets/tileset/vegetation.png"
@export var output_path : String = "res://assets/tileset/tileset_glow.png"
@export var threshold : float = 0.05 # how close a pixel has to be to the pink
@export var glow_multiplier : float = 3.0 # how much to brighten the pixel

@export_tool_button("Get glow") var action_glow = _get_glow

var target_pink : Color = Color(0.545, 0.427, 0.612)

func _get_glow():
	var tex : Texture2D = load(path)
	var img : Image = tex.get_image()
	#img.lock()
	for y in range(img.get_height()):
		for x in range(img.get_width()):
			var color := img.get_pixel(x, y)
			var dist = sqrt(
				pow(color.r - target_pink.r, 2) +
				pow(color.g - target_pink.g, 2) +
				pow(color.b - target_pink.b, 2)
			)
			if dist <= threshold:
				color *= glow_multiplier
				img.set_pixel(x, y, color)
	#img.unlock()
	img.save_png(output_path)
	var _img = ResourceLoader.load(output_path) as ImageTexture
	print("Pink pixels boosted and saved to ", output_path)
