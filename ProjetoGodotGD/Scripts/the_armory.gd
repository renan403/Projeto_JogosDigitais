extends StaticBody2D

@onready var tst = $Audio as AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$LavaRight.play("default")
	$LavaLeft.play("default")
	$Audio.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
