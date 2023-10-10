extends Node2D

@onready var camera := $Camera2D as Camera2D
@onready var p1 = preload("res://Scenes/player_1.tscn")
@onready var p2 = preload("res://Scenes/player_2.tscn")
@onready var cen = preload("res://Scenes/DeadPool.tscn")
var lutador = {"player1": preload("res://Scenes/player_1.tscn")}
var player1 = null
var player2 = null 
var cena = null
var startMenu = preload("res://Scenes/start_screen.tscn").instantiate()

func _ready():
	
	loadCena()
	LoadPlayer1(startMenu.LoadsPlayer1())
	LoadPlayer2(startMenu.LoadsPlayer2())

func loadCena():
	cena = cen.instantiate()
	cena.position= Vector2(1500,250)
	self.add_child(cena)
	
func LoadPlayer1(lutador):
	player1  = p1.instantiate()
	player1.position = Vector2(1000,600)
	self.add_child(player1)
	camera.add_players($Player1)
	
func LoadPlayer2(lutador):
	player2  = p2.instantiate()
	player2.position = Vector2(2000,600)
	self.add_child(player2)
	camera.add_players($Player2)
