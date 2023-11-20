extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/btnVersus.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func LoadsPlayer1():
	return "LiuKang"
func LoadsPlayer2():
	return "Play"

func _on_btn_versus_pressed():
	get_tree().change_scene_to_file("res://Scenes/selecao_champs.tscn")

	
func _on_btn_sair_pressed():
	get_tree().quit()


func _on_btn_controls_pressed():
	var control = load("res://Scenes/controls.tscn").instantiate()
	get_tree().current_scene.add_child(control)
