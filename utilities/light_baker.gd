@tool
extends Node

@export var save_path : String = "res://assets/images/baked_light.png"
@onready var vp : SubViewport = $SubViewportContainer/SubViewport
#@onready var sprite : ColorRect = $SubViewportContainer/SubViewport/Sprite2D

@export_tool_button("Bake Light Texture")
var bake = _bake

func _bake():
	# force one frame to update shader
	#vp.render_target_update_mode = SubViewport.UPDATE_ONCE
	await get_tree().process_frame

	var img = vp.get_texture().get_image()
	print(img)
	img.save_png(save_path)
	var tex = ResourceLoader.load(save_path) as Texture2D
	print("Baked light saved to ", save_path)
