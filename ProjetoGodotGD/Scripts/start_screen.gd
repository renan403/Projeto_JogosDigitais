extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$controls/btnVersus.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func LoadsPlayer1():
	return "testvce"
func LoadsPlayer2():
	return "testvce"

func _on_btn_versus_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")

	
func _on_btn_sair_pressed():
	get_tree().quit()


func _on_btn_controls_pressed():
	var control = load("res://Scenes/controls.tscn").instantiate()
	get_tree().current_scene.add_child(control)
