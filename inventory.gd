extends ItemList
@onready var item_icon: TextureRect = $"../ItemIcon"
@onready var label: Label = $"../Label"

func add_slot(ID = "0"):
	var item_texture = load("res://Assets/" + ItemData.get_texture_name(ID))
	var item_name
	if ItemData.get_item_qtd(ID) > 0:
		if !ItemData.get_item_agrupa(ID):
			item_name = ItemData.get_item_name(ID)
		else:
			item_name = ItemData.get_item_name(ID) + " X" + str(ItemData.get_item_qtd(ID))
		add_item(item_name, item_texture)
	return -1
func _ready() -> void:
	monta()
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
		item_name = busca_nome(item_name)
		var ID = ItemData.find_item_key_by_name(item_name)
		item_icon.texture = load("res://Assets/" + ItemData.get_texture_name(ID))
		label.text = ItemData.get_item_description(ID)
func monta():
	for itens in ItemData.content:
		if ItemData.content[itens]["Qtd"] > 0:
			if ItemData.content[itens]["Agrupa"]:
				add_slot(itens)
			else:
				for i in range(ItemData.content[itens]["Qtd"]):
					add_slot(itens)
func busca_nome(old: String):
	var new : String
	for i in old:
		if i == " ":
			return new
		new += i
	return new
