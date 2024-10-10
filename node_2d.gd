extends Node2D

@onready var inv = preload("res://Inventory/teste.tscn")
@onready var ui: CanvasLayer = $UI

# Called when the node enters the scene tree for the first time.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Inventory"):
		var inst = inv.instantiate()
		if ui.get_child_count() == 0:
			ui.add_child(inst)
