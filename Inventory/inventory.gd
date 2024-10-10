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
		
		#Formata a string para ficar apresentavel
		add_item(item_name, item_texture)
	return -1
func _ready() -> void:
	monta()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Inventory"):
		visible = !visible
		item_icon.visible = !item_icon.visible
		label.visible = !label.visible
		clear()
		if visible == true:
			monta()
			if item_count > 0:
				grab_focus()
				select(0)
				_on_item_selected(0)
			else:
				item_icon.texture = null
				label.text = "Inventário Vazio!"

func _on_item_selected(index: int) -> void:
	if get_selected_items().size() > 0:
		var item_name = get_item_text(get_selected_items()[0])
		item_name = formatar_string(item_name)
		
		var ID = ItemData.find_item_key_by_name(item_name)
		item_icon.texture = load("res://Assets/" + ItemData.get_texture_name(ID))
		label.text = ItemData.get_item_description(ID)
		
func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var item_name = get_item_text(get_selected_items()[0]) 
	item_name = formatar_string(item_name)
	
	var ID = ItemData.find_item_key_by_name(item_name)
	if ItemData.get_item_agrupa(ID):
		ItemData.exclui_item(ID)
		var new = ItemData.get_item_name(ID) + " X" + str(ItemData.get_item_qtd(ID))
		set_item_text(get_selected_items()[0], new)
		if ItemData.get_item_qtd(ID) == 0:
			remove_item(get_selected_items()[0])
	else:
		ItemData.exclui_item(ID)
		remove_item(get_selected_items()[0])
func monta():
	for itens in ItemData.content:
		if ItemData.content[itens]["Qtd"] > 0:
			if ItemData.content[itens]["Agrupa"]:
				add_slot(itens)
			else:
				for i in range(ItemData.content[itens]["Qtd"]):
					add_slot(itens)
func formatar_string(old: String):
	var pos = old.find(" X")  # Encontra a posição de " X"
	if pos != -1:
		return old.substr(0, pos)  # Retorna a parte da string antes de " X"
	return old  # Se " X" não for encontrado, retorna a string original
