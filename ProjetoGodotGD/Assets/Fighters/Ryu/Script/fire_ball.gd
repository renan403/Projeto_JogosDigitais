extends Area2D

const speed := 600
var velocity := Vector2.ZERO
var direction := 1
var animar = true

@onready var anim = $AnimationPlayer as AnimationPlayer
@onready var sprite = $Sprite as Sprite2D

func _ready():
	anim.play("Fire")

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
		#$Collision.position.x = $Collision.position.x *-1
		sprite.flip_h = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	print(body)
	queue_free()

func _on_area_entered(area):
	anim.play("Explode")
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Explode":
		queue_free()
