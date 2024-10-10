extends ItemList
@onready var item_icon: TextureRect = $"../ItemIcon"
@onready var label: Label = $"../Label"

func add_slot(ID = "0"):
	var item_texture = load("res://Assets/" + ItemData.get_texture_name(ID))
	var item_name = ItemData.get_item_name(ID)
	add_item(item_name, item_texture)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Inventory"):
		visible = !visible
		item_icon.visible = !item_icon.visible
		label.visible = !label.visible
		if visible == true and item_count > 0:
			grab_focus()
			select(0)

func _on_item_selected(index: int) -> void:
	if get_selected_items().size() > 0:
		var item_name = get_item_text(get_selected_items()[0])
		var ID = ItemData.find_item_key_by_name(item_name)
		item_icon.texture = load("res://Assets/" + ItemData.get_texture_name(ID))
		label.text = ItemData.get_item_description(ID)
