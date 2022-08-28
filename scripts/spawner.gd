extends Node

export(float) var spawnDelay: float = 0.5
export(Array, PackedScene) var enemyTypes = []
export(int) var maximumEnemies: int = 10

var spawnTimer: float = 0.0
var currentEnemies: int = 0

func _on_Area2D_body_entered(body) -> void:
	if body.is_in_group("Enemy"):
		currentEnemies += 1

func _on_Area2D_body_exited(body) -> void:
	if body.is_in_group("Enemy"):
		currentEnemies -= 1

func _process(delta) -> void:
	spawnTimer -= delta
	
	if spawnTimer <= 0 && currentEnemies < maximumEnemies:
		spawn_enemy()
		spawnTimer = spawnDelay
		
func spawn_enemy() -> void:
	GlobalUtil.instance_node(get_random_enemy(), get_random_position(), GlobalUtil.DefaultParent)
	pass

func get_random_enemy() -> PackedScene:
	var index: int = 0
	return enemyTypes[index]

func get_random_position() -> Vector2:
	var colshape: CollisionShape2D = $Area2D/CollisionShape2D
	var area: Area2D = $Area2D
	var positionInArea: Vector2 = Vector2.ZERO
	
	var centerpos = colshape.global_position
	var size = Vector2(colshape.shape.radius, colshape.shape.radius)
	
	positionInArea.x = (randi() % int(size.x)) - (size.x/2) + centerpos.x
	positionInArea.y = (randi() % int(size.y)) - (size.y/2) + centerpos.y
	
	return positionInArea
