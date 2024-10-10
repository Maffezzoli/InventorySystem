extends Node
var save_atual : int
var template_content = {}
var content : Dictionary


func _ready() -> void:
	carrega_template()
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
	
func carrega_template():
	var file = FileAccess.open("res://Autoload/Inventory.json", FileAccess.READ)
	template_content = JSON.parse_string(file.get_as_text())
	file.close()
	
func carrega_inv(num):
	var save_path = "res://Autoload/Save" + str(num) + ".json"
	var file = FileAccess.open(save_path, FileAccess.READ)
	content = JSON.parse_string(file.get_as_text())
	file.close()
	
func exclui_item(ID = "0"):
	if content[ID]['Qtd'] > 0:
		content[ID]['Qtd'] -= 1
		
func salva_inv(num):
	var save_path = "res://Autoload/Save" + str(num) + ".json"
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var string = JSON.stringify(content)
	file.store_string(string)
	file.close()

func cria_save(num):
	var save_path = "res://Autoload/Save" + str(num) + ".json"
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var string = JSON.stringify(template_content)
	print(string)
	file.store_string(string)
	file.close()
