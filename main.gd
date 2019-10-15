extends Control

# Declare member variables here. Examples:
# var a = 2
var viento_direction = 0
var on_click_num = 0
var favor_viento = false
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_callculate_angule()
	get_node("VBoxContainer/HBoxContainer2/-1viento").connect("pressed",self,"change_viento",[-1])
	get_node("VBoxContainer/HBoxContainer2/-01viento").connect("pressed",self,"change_viento",[-0.1])

	get_node("VBoxContainer/HBoxContainer2/+1viento").connect("pressed",self,"change_viento",[1])
	get_node("VBoxContainer/HBoxContainer2/+01viento").connect("pressed",self,"change_viento",[0.1])
	
	var childs = get_node("VBoxContainer/HBoxContainer").get_children()
	for x in childs:
		x.connect("pressed",self,"_callculate_on_click",[int(x.name)-1])
	pass # Replace with function body.
func _callculate_on_click(val):
	on_click_num = val
	_callculate_angule()
	pass


func change_viento(val):
	var newViento = _get_viento() + val
	set_viento(newViento)
	pass
func set_viento(val):
	get_node("VBoxContainer/HBoxContainer2/viento").text = String(val)
	_callculate_angule()
	pass
	
var y = 0
var yn = 0
var changeN = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bordless = OS.window_borderless
	if (bordless):
		changeN = false
		OS.window_size.y = y
	elif (yn !=0):
		if (changeN == false):
			changeN = true
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
	_viento_direction_invert()
	pass # Replace with function body.


func _callculate_angule():
	var childrens = get_node("VBoxContainer/HBoxContainer").get_children()
	for x in childrens:
		var name  = (int(x.name) - on_click_num)
		var num = 90 - name
		var numRound = round(num + _get_value_viento())
		if (name<= 0):
			x.text = ""
		else:
			x.text = String(name) + ":"+String(numRound)
	pass
	
func _viento_direction_invert():
	if (viento_direction  == 0):
		get_node("VBoxContainer/HBoxContainer2/viento_direction").text = "<-"
		viento_direction = 1
	else:
		get_node("VBoxContainer/HBoxContainer2/viento_direction").text = "->"
		viento_direction = 0
	pass

func _on_viento_favor_pressed():
	_viento_direction_invert()
	
	var primer =  int(get_node("VBoxContainer/HBoxContainer").get_children()[0].name)
	if (primer == 1):
		if (viento_direction == 1):
			favor_viento = true
		else:
			favor_viento = false
	elif (primer == 10):
		if (viento_direction == 0):
			favor_viento = true
		else:
			favor_viento = false
	_callculate_angule()
	pass # Replace with function body.

func _get_value_viento():
	if (!favor_viento):
		return _get_viento()*2
	if (favor_viento):
		return _get_viento()*-2
	pass

func _get_viento():
	return float(get_node("VBoxContainer/HBoxContainer2/viento").text)
	pass

func _on_viento_text_entered(new_text):
	_callculate_angule()
	pass # Replace with function body.


func _on_INFO_pressed():
	OS.alert("Gracias por usar DDTNKC. Att: AndrusGerman (andrusaleman@gmail.com)")
	pass # Replace with function body.


func _on_Reset_pressed():
	on_click_num = 0
	set_viento(0)
	pass # Replace with function body.
