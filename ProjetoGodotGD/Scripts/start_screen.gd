extends Control

var state = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/btnVersus.grab_focus()
	$Control/barra.hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func _on_btn_versus_pressed():
	get_tree().change_scene_to_file("res://Scenes/selecao_champs.tscn")

	
func _on_btn_sair_pressed():
	get_tree().quit()


func _on_btn_controls_pressed():
	var control = load("res://Scenes/controls.tscn").instantiate()
	get_tree().current_scene.add_child(control)


func _on_btn_credit_pressed():
	var credit = load("res://Scenes/credit.tscn").instantiate()
	get_tree().current_scene.add_child(credit)



func _on_btn_sound_pressed():
	var bus_idx = AudioServer.get_bus_index("Master")
	if state == false:
		$Control/barra.show()
		state = true
		AudioServer.set_bus_mute(bus_idx, true)
	elif state == true:
		$Control/barra.hide()
		state = false
		AudioServer.set_bus_mute(bus_idx, false)
