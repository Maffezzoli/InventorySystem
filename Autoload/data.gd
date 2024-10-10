extends Node

var content : Dictionary

func _ready() -> void:
	carrega_inv()
func get_texture_name(ID = "0"):
	return content[ID]["Texture"]
	
func get_item_name(ID = "0"):
	return content[ID]["Name"]
	
func get_item_description(ID = "0"):
	return content[ID]["Description"]

func get_item_qtd(ID = "0"):
	return content[ID]["Qtd"]
func get_item_agrupa(ID = "0"):
	return content[ID]["Agrupa"]
func find_item_key_by_name(name_: String) -> String:
	for key in content.keys():
		var item = content[key]
		if item.get("Name") == name_:
			return key  # Retorna a chave do item
	return ""  # Retorna uma string vazia se não encontrar
func carrega_inv():
	var file = FileAccess.open("res://Autoload/Inventory.json", FileAccess.READ)
	content = JSON.parse_string(file.get_as_text())
	file.close()
func exclui_item(ID = "0"):
	if content[ID]['Qtd'] > 0:
		content[ID]['Qtd'] -= 1
func salva_inv():
	var file = FileAccess.open("res://Autoload/Inventory.json", FileAccess.WRITE)
	var string = JSON.stringify(content)
	file.store_string(string)
	file.close()
