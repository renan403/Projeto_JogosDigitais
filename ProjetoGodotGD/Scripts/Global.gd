extends Node

var jogador = true

#Ultimo lutador selecionado 
var selected := ""

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
var collisionLayerP2 =1
var collisionMaskP2 = 1
var flip2 = -1
var listCommandP2 = ["ui_left", "ui_right","ui_up","ui_atkDistP2"]

#Fase 

func FaseAleat():
	return preload("res://Scenes/DeadPool.tscn")
