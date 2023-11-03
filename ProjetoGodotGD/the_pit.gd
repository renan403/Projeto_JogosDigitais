extends StaticBody2D

@onready var animationJ = $AnimJohnnyCage as AnimatedSprite2D
@onready var animationB = $AnimBlaze as AnimatedSprite2D
@onready var ThemeScene = $AudioStreamPlayer as AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	ThemeScene.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_elta):
	animationB.play("idleBlaze")
	animationJ.play("idleJohnnyCage")
	
