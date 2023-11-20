extends Area2D

const speed := 1200
var velocity := Vector2.ZERO
var direction := 1
var animar = true

@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var sprite = $Sprite as Sprite2D

func _ready():
	anim.play("Spit")

func _process(delta):
	if animar:
		animar = false
	velocity.x = speed * delta * direction
	translate(velocity)

func setDirection(dir):
	if dir == 1:
		sprite.flip_h = false
	else:
		direction = dir
		$Collision.position.x = $Collision.position.x *-1
		sprite.flip_h = true

func _on_area_entered(area):
	print(area)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	print(body)
	queue_free()
