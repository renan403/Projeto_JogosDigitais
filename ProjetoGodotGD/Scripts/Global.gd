extends Node

var jogador = true
#Durante o jogo
var saudeP1 = 100
var saudeP2 = 100
#Ultimo lutador selecionado 
var selected := ""

#Colisões do jogador 1 > 1 2 3 4
#Colisões do jogador 2 > 5 6 7 8
#Player 1
	# Definições para o player 1

var player1 := "LiuKang"
var collisionLayerP1 = 1
var collisionMaskP1 = 1
var flip1 = 1
var listCommandP1 = ["ui_EsqPlayer1", "ui_DirPlayer1","ui_CimaPlayer1","ui_atkDistP1"]

#Player 2 
	# Definições para o player 2

var player2 := "Play"
var collisionLayerP2 =5
var collisionMaskP2 = [1,3]
var flip2 = -1
var listCommandP2 = ["ui_left", "ui_right","ui_up","ui_atkDistP2"]

#Fase 

#ThePit altura 600

func FaseAleat():
	var telaRandom = round(randf_range(1,2))
	if telaRandom == 1:
		return preload("res://Scenes/the_pit.tscn")
	if telaRandom == 2:
		return preload("res://Scenes/DeadPool.tscn")
