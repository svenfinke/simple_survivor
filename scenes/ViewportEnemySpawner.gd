extends Node2D

onready var pathPosition: PathFollow2D = get_node("%SpawnPosition")

export(Array, PackedScene) var enemyTypes: Array = []
# export(Array, PackedScene) var eliteEnemyTypes: Array = []
export(float) var spawnDelayInSeconds: float = .2
# export(float) var spawnElitesDelayInSeconds: float = 5

var timeout: float = 0

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if timeout <= 0:
		var enemy = enemyTypes[floor(rand_range(0, len(enemyTypes)))]
		
		GlobalUtil.instance_node(enemy, getRandomPositionOutsideViewport(), GlobalUtil.DefaultParent)
		timeout = spawnDelayInSeconds
	
	timeout -= delta

func getRandomPositionOutsideViewport() -> Vector2:
	pathPosition.unit_offset = randf()
	if !isValidTile(pathPosition.global_position):
		return getRandomPositionOutsideViewport()
	return pathPosition.global_position

func isValidTile(pos: Vector2) -> bool:
	var baseMap: TileMap = get_parent().get_node("%Base")
	
	var tilePos = baseMap.world_to_map(baseMap.to_local(pos))
	var cell = baseMap.get_cell(tilePos.x, tilePos.y)
	
	if cell != 0:
		return false
			
	return true
