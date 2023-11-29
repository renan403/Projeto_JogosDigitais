extends Control
var p1 = false
var p2 = false

func _ready():
	pass

func _process(_delta):	
	if p1 and p2:
		GoTo_PrincipalScene()

func SelectionPlayer1():
	Global.player1 = Global.selected
	ChangeColor()
	p1 = true
	
func SelectionPlayer2():
	Global.player2 = Global.selected
	ChangeColor()
	p2 = true

func _on_liu_kang_pressed():
	Global.selected = "LiuKang"
	return SelectionPlayer1() if !p1 else SelectionPlayer2()
	
func _on_reptile_pressed():
	Global.selected = "Reptile"
	return SelectionPlayer1() if !p1 else SelectionPlayer2()

func _on_ryu_pressed():
	Global.selected = "Ryu"
	return SelectionPlayer1() if !p1 else SelectionPlayer2()
		
func GoTo_PrincipalScene():
	get_tree().change_scene_to_file("res://Arena.tscn")
	
func ChangeColor():
	var cor = StyleBoxFlat.new()
	cor.border_color = Color.BLUE
	cor.border_width_bottom = 4
	cor.border_width_left = 4
	cor.border_width_top = 4
	cor.border_width_right = 4
	$LiuKang.add_theme_stylebox_override("hover", cor)
	$Reptile.add_theme_stylebox_override("hover", cor)
	$Ryu.add_theme_stylebox_override("hover", cor)




