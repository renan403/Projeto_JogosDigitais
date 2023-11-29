extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	print()
	$Label.text = Global.vencedor + " " + "Venceu"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_selection_pressed():
	get_tree().change_scene_to_file("res://Scenes/selecao_champs.tscn")
