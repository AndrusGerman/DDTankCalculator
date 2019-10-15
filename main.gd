extends Control

# Declare member variables here. Examples:
# var a = 2
var viento_favor = false
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_callculate_angule()
	pass # Replace with function body.

var y = 0
var yn = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bordless = OS.window_borderless
	if (bordless):
		OS.window_size.y = y
	elif (yn !=0):
		OS.window_size.y = yn
	pass


func _disabled_borde():
	if (OS.window_borderless):
		yn = OS.window_size.y
	y = OS.window_size.y
	OS.window_borderless = !OS.window_borderless

	pass # Replace with function body.


func _on_invert_pressed():
	var node = get_node("VBoxContainer/HBoxContainer")
	var childrens = get_node("VBoxContainer/HBoxContainer").get_children()
	for x in childrens:
		node.remove_child(x)
	var count = len(childrens)
	for y in range(count):
		node.add_child(childrens[count-1])
		count = count -1
	pass # Replace with function body.


func _callculate_angule():
	var childrens = get_node("VBoxContainer/HBoxContainer").get_children()
	for x in childrens:
		var name  = x.name
		var num = 90 - int(name)
		num += _get_value_viento()
		x.text = name + ":"+String(num)
	pass

func _on_viento_favor_pressed():
	viento_favor = !viento_favor
	get_node("VBoxContainer/HBoxContainer2/viento_fafor").text = "VientoFavor: "+ String(viento_favor)
	_callculate_angule()
	pass # Replace with function body.

func _get_value_viento():
	if (!viento_favor):
		return _get_viento()*2
	if (viento_favor):
		return _get_viento()*-2
	pass

func _get_viento():
	return int(get_node("VBoxContainer/HBoxContainer2/viento").text)
	pass

func _on_viento_text_entered(new_text):
	_callculate_angule()
	print(new_text)
	pass # Replace with function body.


func _on_INFO_pressed():
	OS.alert("Gracias por usar DDTNKC. Att: AndrusGerman (andrusaleman@gmail.com)")
	pass # Replace with function body.
