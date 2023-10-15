extends Camera2D

@export var move_speed = 0.5
@export var zoom_speed = 0.2
@export var min_zoom = 1
@export var max_zoom = 0.7
@export var margin = Vector2(100,25)

var players = []

@onready var screen_size = get_viewport().get_visible_rect().size

func add_players(player):
	if not player in players:
		players.append(player)

func remove_player(player):
	if player in players:
		players.erase(player)
		
func _process(_delta):
	if !players:
		return 
	var pos = Vector2.ZERO
	for player in players:
		pos += player.position
	pos /= players.size()	
	position = lerp(position,pos,move_speed)
	var rect = Rect2(position, Vector2.ONE)
	
	for player in players:
		rect = rect.expand(player.position)
	rect = rect.grow_individual(margin.x,margin.y,margin.x,margin.y)
	
	var _distance = max(rect.size.x, rect.size.y)
	var zoom_range
	if rect.size.x > rect.size.y * screen_size.aspect():
		zoom_range = clamp(rect.size.x / screen_size.x, min_zoom, max_zoom)	
	else:
		zoom_range = clamp(rect.size.y / screen_size.y , min_zoom, max_zoom)
	zoom = lerp(zoom, Vector2.ONE * zoom_range, zoom_speed)
	
	
	
