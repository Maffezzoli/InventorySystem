extends Sprite2D

func _ready():
	# Recorta a imagem de acordo com a região
	var cropped_image = self.texture.get_image().get_region(region_rect)
	# Salva a imagem como PNG
	cropped_image.save_png("res://output_frame.png")
