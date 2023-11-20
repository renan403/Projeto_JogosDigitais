extends CharacterBody2D

const Fire := preload("res://Scenes/fire_dragon.tscn")
const SPEED := 500.0
const JUMP_VELOCITY := -1200.0
var is_Attacking := false
var is_jumping := false
var gravity := 2000 
var dir := 1
var command
var barra 

@onready var animation = $AnimatedSprite2D as AnimatedSprite2D
func Health(bar):
	barra = bar
func inicializaChampP1(initJg1):
	if initJg1:
		command = Global.listCommandP1
	pass
func inicializaChampP2(initJg2):
	if initJg2:
		command = Global.listCommandP2
	pass

func _on_ready():
	animation.scale.x = Global.flip2
	
func _physics_process(delta):
	var direction = Input.get_axis(command[0], command[1])
	if direction != 0:
		dir = direction
	if direction and !is_Attacking:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if !is_jumping:
			setAnim("walk")
		elif is_jumping and !is_Attacking:
			setAnim("jump")

	elif !is_Attacking:
		setAnim("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed(command[3]):
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
			
	if Input.is_action_just_pressed(command[4]) and is_on_floor():
		if !is_Attacking:
			punch()
			
#if Input.is_action_just_pressed(command[4]) and is_on_floor():
#	if !is_Attacking:
#		kick()	
			
	if Input.is_action_just_pressed(command[5]) and is_on_floor():
		if !is_Attacking:
			kickBike(dir)	
		

	if Input.is_action_just_pressed(command[2]) and is_on_floor() and !is_Attacking:
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false
	
	move_and_slide()
	

func attack():	
	if is_on_floor():
		setAnim("skill1")
	else:
		setAnim("jumpSkill")
	velocity.x = 0
	is_Attacking = true	

func punch():
	setAnim("punch")
	velocity.x = 0
	is_Attacking = true


func kick():
	setAnim("kick")
	velocity.x = 0
	is_Attacking = true

	
func kickBike(dir):
	if dir > 0:
		velocity.x = 1000
	else:
		velocity.x = -1000
	setAnim("bikeKick")
	is_Attacking = true
	
func setAnim(anim):
	animation.play(anim)


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "skill1": 
		is_Attacking = false
	if $AnimatedSprite2D.animation == "jumpSkill" :
		is_Attacking = false
	if  $AnimatedSprite2D.animation == "kick":
		is_Attacking = false
	if $AnimatedSprite2D.animation == "punch":
		is_Attacking = false
	if  $AnimatedSprite2D.animation == "bikeKick":
		is_Attacking = false
func _on_hit_box_area_entered(_area):
	barra.value -= lerp(-10,0,0.1)


func _on_timer_timeout():
	pass

func RenameInstance():
	var instanciaId = instance_from_id(41708160412)
	instanciaId.name = "SkillMelee"
