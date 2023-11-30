extends CharacterBody2D

const Acid := preload("res://Assets/Fighters/Reptile/Scene/acido.tscn")
const AcidBall := preload("res://Assets/Fighters/Reptile/Scene/acid_ball.tscn")
const SPEED := 500.0
const JUMP_VELOCITY := -1200.0
var is_Attacking := false
var is_jumping := false
var in_def := false
var gravity := 2000 
var dir := 1
var command
var barra 
var instanciaId
var colisaoMask
var colisaoLayer
var colisaoLayerEnemy
var colisaoMaskEnemy
var colisaoHurtLayer
var colisaoHurtMask
var flipD
var dead
@onready var animation = $AnimationPlayer as AnimationPlayer
@onready var sprite = $Sprite as Sprite2D
@onready var colisionHitBox  = $HitBoxReptile/CollisionHitBox  as CollisionShape2D
@onready var colision  = $Collision as CollisionShape2D
@onready var reptile = $"."

func Health(bar):
	barra = bar
func inicializaChampP1(initJg1):
	if initJg1:
		dir = 1
		flipD = Global.flip1
		command = Global.listCommandP1
		
		set_collision_layer_value(Global.collisionLayerP1,true)
		for i in Global.collisionMaskP1:
			set_collision_mask_value(i,true)
		
		colisaoHurtLayer = Global.collisionHurtLayerP1
		colisaoHurtMask = Global.collisionHurtMaskP1
		
		$HitBoxReptile.set_collision_layer_value(Global.collisionHitLayerP1, true) 
		$HitBoxReptile.set_collision_mask_value(Global.collisionHitMaskP1, true) 
		
		colisaoLayerEnemy = Global.collisionHitLayerP1
		colisaoMaskEnemy = Global.collisionHitMaskP1
		
	pass
func inicializaChampP2(initJg2):
	if initJg2:
		dir = -1
		command = Global.listCommandP2

		set_collision_layer_value(Global.collisionLayerP2,true)
		for i in Global.collisionMaskP2:
			set_collision_mask_value(i,true)

		colisaoHurtLayer = Global.collisionHurtLayerP2
		colisaoHurtMask = Global.collisionHurtMaskP2
		
		$HitBoxReptile.set_collision_layer_value(Global.collisionHitLayerP2, true) 
		$HitBoxReptile.set_collision_mask_value(Global.collisionHitMaskP2, true) 

		colisaoLayerEnemy = Global.collisionHitLayerP2
		colisaoMaskEnemy = Global.collisionHitMaskP2
		
		flipD = Global.flip2
	pass

func _on_ready():

	$HurtBoxRep.set_collision_layer_value(colisaoHurtLayer, true)
	$HurtBoxRep.set_collision_mask_value(colisaoHurtMask, true)
	sprite.flip_h = flipD
	var IDget = get_node(".").get_children()[3].get_instance_id()
	instanciaId = instance_from_id(IDget)

func _physics_process(delta):
	if barra.value == 0 :
		if !dead:
			setAnim("Falling")
		pass
	else:
		var direction = Input.get_axis(command[0], command[1])
		if direction != 0:
			dir = direction
		if direction and !is_Attacking and !in_def:
			velocity.x = direction * SPEED
			if direction == -1:
				colisionHitBox.position.x = -26
			else:
				colisionHitBox.position.x = 26
			sprite.flip_h = false if direction == 1 else true
			if !is_jumping:	
				setAnim("walk")
			elif is_jumping and !is_Attacking:
				print(is_jumping)
				if velocity.x != 0:
					setAnim("Jump")
		elif !is_Attacking:
			if is_jumping:
				setAnim("NeutralJump")
			else:
				setAnim("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_on_floor():
			velocity.y += gravity * delta

		### ------------------------------------------  Ataques ---------------------------------------  ###
		if Input.is_action_pressed(command[3]) and is_on_floor() and !is_Attacking:
			setAnim("Defense")
			velocity.x = 0	
			in_def = true
		else:
			in_def = false	
		if is_on_floor() and !is_Attacking:
			if Input.is_action_just_pressed(command[4]) and velocity.x != 0:
				setAnim("SphereOfForce")
				PreencherVarAtk(0)
			elif Input.is_action_just_pressed(command[4]):
				setAnim("highPunch")
				PreencherVarAtk(-46)
			if Input.is_action_just_pressed(command[5]) and velocity.x != 0:
				setAnim("Spit")
				skillAcid()
				PreencherVarAtk(0)
			elif Input.is_action_just_pressed(command[5]):
				setAnim("mediumPunch")
				PreencherVarAtk(-27)
			if Input.is_action_just_pressed(command[6]):
				setAnim("HighKick")
				PreencherVarAtk(-45)
			if Input.is_action_just_pressed(command[7]):
				setAnim("LowKick")
				PreencherVarAtk(-22)
			
		if Input.is_action_just_pressed(command[2]) and is_on_floor() and !is_Attacking and !in_def:
			velocity.y = JUMP_VELOCITY	
			is_jumping = true
		elif is_on_floor():
			is_jumping = false	

		move_and_slide()

###  ------------------------------------------- Funções  ---------------------------------------  ###

func setAnim(anim):
	animation.play(anim)
	
func skillAcid():
	var skill := Acid.instantiate()
	skill.set_collision_layer_value(colisaoLayerEnemy,true)
	skill.set_collision_mask_value(colisaoMaskEnemy,true)
	get_parent().add_child(skill)
	skill.setDirection(dir)
	# x = 24 y = -33
	$Marker.position.x = 24
	$Marker.position.y = -33
	if $Marker.position.x > 0 and dir == -1:
		$Marker.position.x *= -1
	elif $Marker.position.x < 0 and dir == 1:
		$Marker.position.x *= -1
	skill.position = $Marker.global_position
	is_Attacking = true
	
func skillAcidBall():
	#x = 24 y = -13
	var skill := AcidBall.instantiate()
	skill.set_collision_layer_value(colisaoLayerEnemy,true)
	skill.set_collision_mask_value(colisaoMaskEnemy,true)
	get_parent().add_child(skill)
	skill.setDirection(dir)
	$Marker.position.x = 24
	$Marker.position.y = -13
	if $Marker.position.x > 0 and dir == -1:
		$Marker.position.x *= -1
	elif $Marker.position.x < 0 and dir == 1:
		$Marker.position.x *= -1
	skill.position = $Marker.global_position
	is_Attacking = true
		
func PreencherVarAtk(Position_Y):
	velocity.x = 0
	colisionHitBox.position.y = Position_Y
	is_Attacking = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "highPunch":
		is_Attacking = false
	if anim_name == "mediumPunch":
		is_Attacking = false
	if anim_name == "HighKick":
		is_Attacking = false
	if anim_name == "LowKick":
		is_Attacking = false
	if anim_name == "Spit":
		is_Attacking = false
	if anim_name == "SphereOfForce":
		skillAcidBall()
		is_Attacking = false
		
	if anim_name == "Falling":
		dead = true	
		$Timer.start()
		
				
func RenameInstance():
	instanciaId.name = "HitBox"


func _on_hurt_box_rep_area_entered(_area):
	print(_area)
	if _area.name == "HitBox":
		if in_def:
			barra.value -= 5
		else:
			barra.value -= 15
	else:
		if in_def:
			barra.value -= 7
		else:
			barra.value -= 30


func _on_hurt_box_rep_body_entered(body):
	pass

var venc 
func _on_timer_timeout():
	$Timer.stop()
	print("time out")
	if Global.player1 == "Reptile":
		venc = Global.player2
	else:
		venc = Global.player1
	Global.playerWin(venc) 
