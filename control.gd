extends Control

@onready var v_box_container: VBoxContainer = $Saves/VBoxContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var load_container: VBoxContainer = $Load/VBoxContainer
var cena = "res://Inventory/teste.tscn"

enum STATE { MAIN, LOAD, SAVE }
var ui_state = STATE.MAIN
func _ready() -> void:
	for child in v_box_container.get_children():
		var existe = FileAccess.file_exists("res://Autoload/Save" + str(child.name) + ".json")
		if existe:
			child.text = "Save " + str(child.name)
		else:
			child.text = "[SLOT]"
	for child in load_container.get_children():
		var existe = FileAccess.file_exists("res://Autoload/Save" + str(child.name) + ".json")
		if existe:
			child.text = "Load Save " + str(child.name)
		else:
			child.text = "EMPTY"



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and not animation_player.is_playing():
		match ui_state:
			STATE.LOAD:
				ui_state = STATE.MAIN
				animation_player.play("load_get_out")
			STATE.SAVE:
				ui_state = STATE.MAIN
				animation_player.play("save_get_out")
			STATE.MAIN:
				if visible == true:
					visible = false
				else:
					visible = true


func _on_button_2_pressed() -> void:
	if !animation_player.is_playing():
		ui_state = STATE.SAVE
		animation_player.play("save_get_in")


func _on_button_pressed() -> void:
	if !animation_player.is_playing():
		ui_state = STATE.LOAD
		animation_player.play("load_get_in")




func SAVE(num : int) -> void:
	var existe = FileAccess.file_exists("res://Autoload/Save" + str(1) + ".json")
	ItemData.cria_save(num)
	ItemData.carrega_inv(num)
	ItemData.save_atual = num
	get_tree().change_scene_to_packed(load(cena))

func LOAD(num) -> void:
	var existe = FileAccess.file_exists("res://Autoload/Save" + str(num) + ".json")
	if existe:
		ItemData.carrega_inv(num)
		ItemData.save_atual = num
		get_tree().change_scene_to_packed(load(cena))
