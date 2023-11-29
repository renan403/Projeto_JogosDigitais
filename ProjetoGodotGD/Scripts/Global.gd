extends Node

var jogador = true
#Durante o jogo
var Map = 0
var saudeP1 = 100
var saudeP2 = 100
#Ultimo lutador selecionado 
var selected := ""
var vencedor := ""
#Colisões do jogador 1 > 1 2 3 4
#Colisões do jogador 2 > 5 6 7 8
#Player 1
	# Definições para o player 1

var player1 := "Ryu"
var player1Win = player1
var collisionLayerP1 = 1
var collisionMaskP1 = 3

var collisionHurtLayerP1 = 9
var collisionHurtMaskP1 = 8

var collisionHitLayerP1 = 4
var collisionHitMaskP1 = 13

var flip1 = 0
var listCommandP1 = ["ui_EsqPlayer1", "ui_DirPlayer1","ui_CimaPlayer1","ui_BaixoPlayer1",
					 "ui_AtkSocoAltoP1","ui_AtkSocoBaixoP1","ui_AtkChuteAltoP1","ui_AtkChuteBaixoP1"]
					#0-ui_EsqPlayer1 1-ui_DirPlayer1 2-ui_CimaPlayer1 3-ui_BaixoPlayer1 
					#4-ui_AtkSocoAltoP1 5-ui_AtkSocoBaixoP1 6-ui_AtkChuteAltoP1 7-ui_AtkChuteBaixoP1
#Player 2 
	# Definições para o player 2

var player2 := "Reptile"
var player2Win = player2
var collisionLayerP2 = 5
var collisionMaskP2 = 7

var collisionHurtLayerP2 = 13
var collisionHurtMaskP2 = 4

var collisionHitLayerP2 = 8
var collisionHitMaskP2 = 9

var flip2 = -1
var listCommandP2 = ["ui_EsqPlayer2", "ui_DirPlayer2","ui_CimaPlayer2","ui_BaixoPlayer2",
					 "ui_AtkSocoAltoP2","ui_AtkSocoBaixoP2","ui_AtkChuteAltoP2","ui_AtkChuteBaixoP2"]

#Fase 

#ThePit altura 600
var con = 0

func playerWin(player):
	if con < 1:
		con += 1
		print("player global")
		print(player)
		
		
		vencedor = player
		get_tree().change_scene_to_file("res://Scenes/win.tscn")
	pass
	
	
func FaseAleat():
	var telaRandom = round(randf_range(1,3))
	if telaRandom == 1:
		Map = 750
		return preload("res://Scenes/the_pit.tscn")
	if telaRandom == 2:
		Map = 1000
		return preload("res://Scenes/the_armory.tscn")	
	if telaRandom == 3:
		Map = 1000
		return preload("res://Scenes/DeadPool.tscn")
