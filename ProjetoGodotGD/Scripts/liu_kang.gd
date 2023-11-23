extends CharacterBody2D

const Fire := preload("res://Scenes/fire_dragon.tscn")
const SPEED := 500.0
const JUMP_VELOCITY := -1200.0
var is_Attacking := false
var is_jumping := false
var isCombo= false
var gravity := 2000 
var dir := 1
var command
var barra 

var colisaoMask
var colisaoLayer
var colisaoLayerEnemy
var colisaoMaskEnemy
var flipD

var sequencia = []
var moves = {
	"bikeKick1" : ["Direita", "Chute"],
	"bikeKick2" : ["Esquerda", "Chute"],
	"frontPunch1" : ["Direita", "Soco"],
	"frontPunch2" : ["Esquerda", "Soco"],
	"fireDragon" : ["Soco", "Chute"]
}

@export var tempoProCombo: float = 0.3
var special = null
@onready var timerCombo = $TimerCombo as Timer
@onready var HitBox = $HitBoxLK as Area2D
@onready var colHitBox = $HitBoxLK/CollisionShape2D as CollisionShape2D

@onready var animation = $AnimatedSprite2D as AnimatedSprite2D
@onready var anima = $AnimatedSprite2D/AnimationPlayer as AnimationPlayer

func Health(bar):
	barra = bar
func inicializaChampP1(initJg1):
	if initJg1:
		command = Global.listCommandP1
		colisaoLayer = Global.collisionLayerP1
		colisaoMask = Global.collisionMaskP1
		colisaoLayerEnemy = Global.collisionLayerSkillP1
		colisaoMaskEnemy = Global.collisionMaskSkillP1
	pass
func inicializaChampP2(initJg2):
	if initJg2:
		command = Global.listCommandP2
		colisaoLayer = Global.collisionLayerP2
		colisaoMask = Global.collisionMaskP2
		colisaoLayerEnemy = Global.collisionLayerP2
		colisaoMaskEnemy = Global.collisionMaskSkillP2
	pass

func _on_ready():
	$HitBoxLK.collision_layer = colisaoLayer
	$HitBoxLK.set_collision_mask_value(colisaoMask,true)
	colHitBox.disabled = true
	pass




func _physics_process(delta):
	var  direction  =	Input.get_axis(command[0], command[1])
	if direction != 0:
		dir = direction
	if direction and !is_Attacking:
		velocity.x = direction * SPEED
		animation.scale.x = float(direction)
		if direction < 0:
			colHitBox.position.x = -22.75
		else:
			colHitBox.position.x = 22.75
			
		if !is_jumping:
			setAnim("walk")
		elif is_jumping and !is_Attacking:
			setAnim("jumpMov")
		

	elif !is_Attacking:
		if is_jumping:
			setAnim("jumpSt")
		else:
			setAnim("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if not is_on_floor():
		velocity.y += gravity * delta
			
	
	if special == "bikeKick1":
			kickBike(dir)
	elif special == "bikeKick2":
			kickBike(dir)
	elif special == "frontPunch1":
			frontPunch(dir)
	elif special == "frontPunch2":
			frontPunch(dir)
	elif special == "fireDragon":
			FireDragon()#não está saíndo  de forma conssitente
	elif Input.is_action_just_pressed(command[5]) and !is_jumping and special == null and !is_Attacking:
		punch()	
	elif Input.is_action_just_pressed(command[6]) and !is_jumping and special == null and !is_Attacking:
		kick()
			
		

	if Input.is_action_just_pressed(command[2]) and is_on_floor() and !is_Attacking:
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
	elif is_on_floor():
		is_jumping = false

	move_and_slide()
	
func sequenciaCheck(sequencia_combo : Array):#checa a sequencia de inputs e procura no dicionario e movimento caso ache irá atribuir o nome do golpe
	for move_name in moves.keys():
		if sequencia_combo == moves[move_name]:
			isCombo = true
			special = move_name
			print(special)

func sequenciaInputs(action : String):#recebe as sequencias de inputs e armazena no array
	sequencia.push_back(action)
	print(sequencia)

func attack():
	if is_on_floor():
		setAnim("skill1")
	else:
		setAnim("jumpSkill")
	velocity.x = 0
	is_Attacking = true	


func FireDragon():
	if !is_Attacking:
		var skill = Fire.instantiate()
		get_parent().add_child(skill)
		skill.setDirecao(dir)		
		if $SkillDragon.position.x > 0 and dir == -1:
			$SkillDragon.position.x *= -1
		elif $SkillDragon.position.x < 0 and dir == 1:
			$SkillDragon.position.x *= -1
		skill.position = $SkillDragon.global_position
		is_Attacking = true
		attack()


func punch():
	setAnim("punch")
	velocity.x = 0
	colHitBox.position.y = -35.5
	is_Attacking = true


func kick():
	setAnim("kick")
	velocity.x = 0
	colHitBox.position.y = 25
	is_Attacking = true

	
func kickBike(dir):
	if dir > 0:
		velocity.x = 1500
	else:
		velocity.x = -1500
	setAnim("bikeKick")
	colHitBox.position.y = 0
	is_Attacking = true

	
func frontPunch(dir):
	setAnim("frontPunch")
	if dir > 0:
		velocity.x = 10000
	else:
		velocity.x = -10000
	colHitBox.position.y = -30
	is_Attacking = true
	
func setAnim(anim):
	#animation.play(anim)
	anima.play(anim)

	

func _on_hit_box_area_entered(_area):
	barra.value -= lerp(-10,0,0.1)


func RenameInstance():
	var instanciaId = instance_from_id(41708160412)
	instanciaId.name = "SkillMelee"

	



	

func _input(event):#converte os inputs em string para armazenar no array
	
	if not event is InputEvent or not event.is_pressed():
		return

	if event.is_action_pressed(command[0]):
		sequenciaInputs("Esquerda")
	elif event.is_action_pressed(command[1]):
		sequenciaInputs("Direita")
	elif event.is_action_pressed(command[2]):
		sequenciaInputs("Cima")
	elif event.is_action_pressed(command[3]):
		sequenciaInputs("Baixo")
	elif event.is_action_pressed(command[5]):
		sequenciaInputs("Soco")
	elif event.is_action_pressed(command[6]):
		sequenciaInputs("Chute")
		
	timerCombo.start(tempoProCombo)
		

func _on_timer_combo_timeout():#timeout para resetar o array e fazer e chama a checagem
	sequenciaCheck(sequencia)
	sequencia.clear()


func _on_animation_player_animation_finished(anim_name):
	print($AnimatedSprite2D.animation)
	if anim_name == "skill1" or anim_name == "jumpSkill" or anim_name == "jumpSkill" or anim_name == "kick" or anim_name == "bikeKick" or anim_name == "frontPunch" or anim_name == "punch" or anim_name == "jumpMov" or anim_name == "jumpSt":
		is_Attacking = false
		special = null

func _on_animated_sprite_2d_animation_finished():
	print($AnimatedSprite2D.animation)
	if $AnimatedSprite2D.animation == "skill1" or $AnimatedSprite2D.animation == "jumpSkill" or $AnimatedSprite2D.animation == "punch" or  $AnimatedSprite2D.animation == "kick" or $AnimatedSprite2D.animation == "bikeKick" or $AnimatedSprite2D.animation == "FrontPunch":
		is_Attacking = false
		special = null
		isCombo = false


#func _on_area_2d_area_entered(area):
	#barra.value -= lerp(-10,0,0.1)


func _on_skill_melee_area_entered(area):
	print("area test lk")
	barra.value -= 15
