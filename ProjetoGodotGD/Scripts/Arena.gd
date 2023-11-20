extends Node2D

@onready var camera := $Camera2D as Camera2D

var player1 = null
var player2 = null 
var cena = null

var lutador = {"LiuKang": preload("res://Scenes/liu_kang.tscn"),
			   "Play"   : preload("res://Scenes/player_1.tscn"),
			   "Reptile": preload("res://Assets/Fighters/Reptile/Scene/reptile.tscn")}

var startMenu = preload("res://Scenes/start_screen.tscn").instantiate()
var selection = preload("res://Scenes/selecao_champs.tscn").instantiate()

func _ready():
	loadCena()
	LoadPlayer1()
	LoadPlayer2()
	
func loadCena():
	cena = Global.FaseAleat().instantiate()
	#The pit 1500 - 600
	cena.position = Vector2(1500,600)
	self.add_child(cena)
	
func LoadPlayer1():
	player1 = lutador[Global.player1].instantiate()
	player1.inicializaChampP1(true) 
	player1.Health($HUD/HP_p1/ProgressBarP1)
	$HUD/HP_p1/ProgressBarP1/Label.text = Global.player1
	player1.position = Vector2(1000,Global.Map)
	self.add_child(player1) 
	camera.add_players(player1)
	
func LoadPlayer2():
	player2 = lutador[Global.player2].instantiate()
	player2.inicializaChampP2(true)
	player2.Health($HUD/HP_p2/ProgressBarP2)
	$HUD/HP_p2/ProgressBarP2/Label.text = Global.player2
	player2.position = Vector2(2000,Global.Map)
	self.add_child(player2)
	camera.add_players(player2)
