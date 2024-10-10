extends Sprite2D

func _ready() -> void:
	set_property("2")

func set_property(ID = "0"):
	texture = load("res://Assets/" + ItemData.get_texture_name(ID))
