extends Node

var jogador = true
#Durante o jogo
var Map = 0
var saudeP1 = 100
var saudeP2 = 100
#Ultimo lutador selecionado 
var selected := ""

#Colisões do jogador 1 > 1 2 3 4
#Colisões do jogador 2 > 5 6 7 8
#Player 1
	# Definições para o player 1

var player1 := "Reptile"
var collisionLayerP1 = 1
var collisionMaskP1 = 5
var collisionLayerSkillP1 = 4
var collisionMaskSkillP1 = 5
var flip1 = 0
var listCommandP1 = ["ui_EsqPlayer1", "ui_DirPlayer1","ui_CimaPlayer1","ui_BaixoPlayer1",
					 "ui_AtkSocoAltoP1","ui_AtkSocoBaixoP1","ui_AtkChuteAltoP1","ui_AtkChuteBaixoP1"]
					#0-ui_EsqPlayer1 1-ui_DirPlayer1 2-ui_CimaPlayer1 3-ui_BaixoPlayer1 
					#4-ui_AtkSocoAltoP1 5-ui_AtkSocoBaixoP1 6-ui_AtkChuteAltoP1 7-ui_AtkChuteBaixoP1
#Player 2 
	# Definições para o player 2

var player2 := "LiuKang"
var collisionLayerP2 = 5
var collisionMaskP2 = 1
var collisionLayerSkillP2 = 8
var collisionMaskSkillP2 = 1
var flip2 = -1
var listCommandP2 = ["ui_EsqPlayer2", "ui_DirPlayer2","ui_CimaPlayer2","ui_BaixoPlayer2",
					 "ui_AtkSocoAltoP2","ui_AtkSocoBaixoP2","ui_AtkChuteAltoP2","ui_AtkChuteBaixoP2"]

#Fase 

#ThePit altura 600

func FaseAleat():
	var telaRandom = round(randf_range(1,2))
	if telaRandom == 1:
		Map = 750
		return preload("res://Scenes/the_pit.tscn")
	if telaRandom == 2:
		Map = 1000
		
		return preload("res://Scenes/the_armory.tscn")	
	#if telaRandom == 3:
	#	Map = 1000
	#	return preload("res://Scenes/DeadPool.tscn")
