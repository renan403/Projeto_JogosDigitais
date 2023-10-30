extends Area2D

const speed := 1000
var velocity := Vector2.ZERO
var direction := 1
var animar = true
@onready var anim = $AnimatedSprite2D as AnimatedSprite2D

func _ready():
	pass

func _process(delta):
	anim.play("fogo")
	if animar:		
		
		animar = false
	velocity.x = speed * delta * direction
	translate(velocity)

func setDirecao(dir):
	direction = dir
	if direction == 1:
		anim.flip_h = false		
	else:
		$CollisionShape2D.position.x = $CollisionShape2D.position.x *-1
		anim.flip_h = true
func preAnim():
	anim.play("prefogo")
func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "prefogo":
		anim.play("fogo")


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(_body):
	queue_free()
