extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_jumping = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = $AnimatedSprite2D as AnimatedSprite2D

func _ready():
	animation.scale.x = -1 #faz animação iniciar para esquerda
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if !is_jumping:
			animation.play("run")
	elif is_jumping:
		animation.play("jump")
	else:
		animation.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

