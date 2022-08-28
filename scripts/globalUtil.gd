extends Node

var DefaultParent : Node = null

func instance_node(scene, location: Vector2, parent: Node) -> Node:
	var node_instance
	
	if !parent:
		return null
	
	if !scene:
		return null
		
	if !scene.has_method("move_and_collide"):
		node_instance = scene.instance()
	else:
		node_instance = scene
		
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
