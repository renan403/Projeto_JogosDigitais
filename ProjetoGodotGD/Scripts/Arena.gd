extends Node2D

@onready var camera := $Camera2D as Camera2D

var player1 = null
var player2 = null 
var cena = null

var stages = {"DeadPool":preload("res://Scenes/DeadPool.tscn")}

var lutador = {"LiuKang": preload("res://Scenes/liu_kang.tscn"),
"Play":preload("res://Scenes/player_1.tscn")}



var startMenu = preload("res://Scenes/start_screen.tscn").instantiate()

func _ready():
	
	loadCena("DeadPool")
	LoadPlayer1(startMenu.LoadsPlayer1())
	LoadPlayer2(startMenu.LoadsPlayer2())
func loadCena(stage):
	
	cena = stages[stage].instantiate()
	cena.position= Vector2(1500,250)
	self.add_child(cena)
	
func LoadPlayer1(Champ):
	player1 = load(Global.PlayerDir).instantiate()
	player1.position = Vector2(1000,600)
	self.add_child(player1)
	camera.add_players(player1)
	
func LoadPlayer2(Champ):
	player2  = lutador[Champ].instantiate()
	player2.position = Vector2(2000,600)
	self.add_child(player2)
	camera.add_players(player2)
