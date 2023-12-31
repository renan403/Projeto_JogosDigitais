extends CharacterBody2D

const FireBall := preload("res://Assets/Fighters/Ryu/Scene/fire_ball.tscn")
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
var colisaoHurtLayer
var colisaoHurtMask
var colisaoLayerEnemy
var colisaoMaskEnemy
var dead

var flip

@onready var animation = $AnimationPlayer as AnimationPlayer
@onready var sprite = $Sprite as Sprite2D
@onready var colisionHitBox  = $HitBox/CollisionHitBox  as CollisionShape2D
@onready var colision  = $Collision as CollisionShape2D

func Health(bar):
	barra = bar
func inicializaChampP1(initJg1):
	if initJg1:
		dir = 1
		flip = Global.flip1
		command = Global.listCommandP1
		
		set_collision_layer_value(Global.collisionLayerP1,true)
		for i in Global.collisionMaskP1:
			set_collision_mask_value(i,true)
		
		colisaoHurtLayer = Global.collisionHurtLayerP1
		colisaoHurtMask = Global.collisionHurtMaskP1
		
		$HitBox.set_collision_layer_value(Global.collisionHitLayerP1, true) 
		$HitBox.set_collision_mask_value(Global.collisionHitMaskP1, true) 
		
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
		
		$HitBox.set_collision_layer_value(Global.collisionHitLayerP2, true) 
		$HitBox.set_collision_mask_value(Global.collisionHitMaskP2, true) 

		colisaoLayerEnemy = Global.collisionHitLayerP2
		colisaoMaskEnemy = Global.collisionHitMaskP2
		
		flip = Global.flip2
	pass

func _on_ready():	
	
	$HurtBox.set_collision_layer_value(colisaoHurtLayer, true) 
	$HurtBox.set_collision_mask_value(colisaoHurtMask,true)

	var IDget = get_node(".").get_children()[1].get_instance_id()
	instanciaId = instance_from_id(IDget)
	sprite.flip_h = flip
	
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
				setAnim("Walk")
			elif is_jumping and !is_Attacking:
				if velocity.x != 0:
					setAnim("JumpF")
		elif !is_Attacking:
			if is_jumping:
				setAnim("NeutralJump")
			else:
				setAnim("Idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_on_floor():
			velocity.y += gravity * delta

		# ----------------------------------------------------------------------------------------------------------	
		if Input.is_action_pressed(command[3]) and is_on_floor() and !is_Attacking:
			setAnim("Def")
			velocity.x = 0
			in_def = true
		else:
			in_def = false
		if is_on_floor() and !is_Attacking:
			if Input.is_action_just_pressed(command[4]) and velocity.x != 0:
				setAnim("SkillFireBall")
				PreencherVarAtk(0,0)
			elif Input.is_action_just_pressed(command[4]):
				setAnim("HighPunch")
				PreencherVarAtk(-53.5,29.75)
			if Input.is_action_just_pressed(command[5]) and velocity.x != 0:
				velocity.y += -1000
				setAnim("Shoryuken")
				colisionHitBox.position.y = -29.5
				PreencherVarAtk(0,0)
			elif Input.is_action_just_pressed(command[5]):
				setAnim("LowPunch")
				PreencherVarAtk(-32.5,49.5)
			if Input.is_action_just_pressed(command[6]) and velocity.x != 0:
				chuteGiratorio(dir)
				PreencherVarAtk(0,0)
			elif Input.is_action_just_pressed(command[6]):
				setAnim("HighKick")
				PreencherVarAtk(-45,49.75)
			if Input.is_action_just_pressed(command[7]):
				setAnim("LowKick")
				PreencherVarAtk(11,32.25)
			
			
		if Input.is_action_just_pressed(command[2]) and is_on_floor() and !is_Attacking and !in_def:
			velocity.y = JUMP_VELOCITY	
			is_jumping = true
		elif is_on_floor():
			is_jumping = false	

		move_and_slide()

func setAnim(anim):
	animation.play(anim)
	
func PreencherVarAtk(Position_Y,Position_X):
	velocity.x = 0
	colisionHitBox.position.y = Position_Y
	if dir == 1:
		colisionHitBox.position.x = Position_X
	else:
		colisionHitBox.position.x = (Position_X * -1)
	is_Attacking = true

func skillFire():
	var skill := FireBall.instantiate()
	
	skill.set_collision_layer_value(colisaoLayerEnemy,true)
	skill.set_collision_mask_value(colisaoMaskEnemy,true)
	
	get_parent().add_child(skill)
	skill.setDirection(dir)
	# x = 24 y = -33
	$Marker.position.x = 58.25
	$Marker.position.y = -17
	if $Marker.position.x > 0 and dir == -1:
		$Marker.position.x *= -1
	elif $Marker.position.x < 0 and dir == 1:
		$Marker.position.x *= -1
	skill.position = $Marker.global_position
	is_Attacking = true
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "HighPunch":
		is_Attacking = false
	if anim_name == "LowPunch":
		is_Attacking = false
	if anim_name == "HighKick":
		is_Attacking = false
	if anim_name == "Shoryuken":
		is_Attacking = false
	if anim_name == "LowKick":
		is_Attacking = false
	if anim_name == "Tatsumaki":
		is_Attacking = false
	if anim_name == "SkillFireBall":
		skillFire()
		is_Attacking = false
	if anim_name == "Falling":
		dead = true
		$Timer.start()
		
func _on_hurt_box_body_entered(body):
	print(body)
	print("body ryu")
	#barra.value -= 15

func _on_hurt_box_area_entered(_area):
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

var venc 

func chuteGiratorio(_dir):
	if _dir > 0:
		#position.y = 850
		velocity.x -= -1000
	else:
		#position.y = 500
		velocity.x -= 1000
	setAnim("Tatsumaki")


func _on_timer_timeout():
	$Timer.stop()
	if Global.player1 == "Ryu":
		venc = Global.player2
	else:
		venc = Global.player1
	Global.playerWin(venc) 
		
	
