extends CharacterBody2D

const Fire := preload("res://Scenes/fire_dragon.tscn")
const SPEED = 500.0
const JUMP_VELOCITY = -1200.0
var is_Attacking= false
var is_jumping = false
var gravity =2000 #ProjectSettings.get_setting("physics/2d/default_gravity")
var dir = 1
@onready var animation = $AnimatedSprite2D as AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_axis("ui_EsqPlayer1", "ui_DirPlayer1")
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
		
	if Input.is_action_just_pressed("ui_ataqueDistancia"):
		var skill = Fire.instantiate()
		get_parent().add_child(skill)
		skill.setDirecao(dir)		
		if $SkillDragonFloor.position.x > 0 and dir == -1:
			$SkillDragonFloor.position.x *= -1
		elif $SkillDragonFloor.position.x < 0 and dir == 1:
			$SkillDragonFloor.position.x *= -1
		skill.position = $SkillDragonFloor.global_position
		attack()
		
	if Input.is_action_just_pressed("ui_PuloPlayer1") and is_on_floor() and !is_Attacking:
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
func setAnim(anim):
	animation.play(anim)


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "skill1" or $AnimatedSprite2D.animation == "jumpSkill":
		is_Attacking = false
		
