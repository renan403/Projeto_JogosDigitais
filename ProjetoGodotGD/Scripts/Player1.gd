extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -1200.0
var is_Attacking = false
var is_jumping = false
var gravity = 2000
var command 
var barra 
var collision
var masks = Global.collisionMaskP2
@onready var animation = $AnimatedSprite2D as AnimatedSprite2D

func _on_ready():
	animation.scale.x = Global.flip2
	set_collision_layer_value(collision,true)
	for mask in masks:
		set_collision_mask_value(mask,true)
	
func Health(bar):
	barra = bar
func inicializaChampP1(initJg1):
	if initJg1:
		collision = Global.collisionLayerP1
		command = Global.listCommandP1
	pass
func inicializaChampP2(initJg2):
	if initJg2:
		collision = Global.collisionLayerP2
		command = Global.listCommandP2
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	updateAnim()
	move_and_slide()

func updateAnim():
	if Input.is_action_just_pressed(command[3]) and is_on_floor():
		attack()
	else:
		if Input.is_action_just_pressed(command[2]) and is_on_floor() and !is_Attacking:
			velocity.y = JUMP_VELOCITY
			is_jumping = true
		elif is_on_floor():
			is_jumping = false
		var direction = Input.get_axis(command[0], command[1])
		if direction and !is_Attacking:
			velocity.x = direction * SPEED
			animation.scale.x = direction
			if !is_jumping:
				animation.play("run")
		elif is_jumping and !is_Attacking:
			animation.play("jump")
		elif !is_Attacking:
			animation.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)

func attack():
	animation.play("rangeAtk")
	var direction = Input.get_axis(command[0], command[1])
	velocity.x = lerp(direction * SPEED,velocity.x,0.1)
	is_Attacking = true

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "rangeAtk":
		is_Attacking = false

func _on_hit_box_area_entered(area):
	print(area)
	if area.name == "FireDragon":
		barra.value -= 15
