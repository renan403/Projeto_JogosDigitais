extends Node

var PlayerDir
var Player : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
