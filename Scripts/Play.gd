extends Control

func _on_DialogueBox_update_background(background_id):
	var tex = ImageTexture.new()
	var img = Image.new()
	img.load("res://Art/1x/" + background_id + ".png")
	tex.create_from_image(img)
	
	$Background.set_expand(true)
	$Background.set_stretch_mode(TextureRect.STRETCH_SCALE)
	$Background.set_texture(tex)
	