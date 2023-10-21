extends Control

var Liukang="res://Scenes/liu_kang.tscn"
var Shaokahn="res://Scenes/player_2.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func goToScene():
	get_tree().change_scene_to_file("res://Main.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_liu_kang_button_pressed():
	Global.PlayerDir = Liukang
	goToScene()

func _on_shao_kang_button_pressed():
	Global.PlayerDir = Shaokahn
	goToScene()
