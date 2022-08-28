extends Node2D

onready var backgroundMap: TileMap = get_node("%Background")
onready var baseMap: TileMap = get_node("%Base")
onready var objectsMap: TileMap = get_node("%Objects")
onready var player: Player = get_node("%Player")

var baseNoise: OpenSimplexNoise
var objectNoise: OpenSimplexNoise
var renderSize: Vector2 = Vector2(100,100)
var renderOffset: Vector2 = Vector2(50,50)
var baseCap: float = 0.3
var spawnerCap: float = 0.01
var count: int = 20
var tileSize: int = 8

func _ready():
	# randomize()
	GlobalUtil.DefaultParent = self
	var intSeed = randi()
	
	# Generate base noise for terrain
	baseNoise = OpenSimplexNoise.new()
	baseNoise.seed = intSeed
	baseNoise.octaves = 1.0
	baseNoise.period = 20
	
	# Generate noise for object placement
	objectNoise = OpenSimplexNoise.new()
	objectNoise.seed = intSeed
	objectNoise.octaves = 1.0
	objectNoise.period = 20
	objectNoise.persistence = 1
	
func _process(delta):
	var playerPosition = baseMap.world_to_map(player.position)
	var boundaries = generateTileBoundary(playerPosition)
	
	if count % 20 == 0:
		drawAutoTiles(baseMap, [0, 0], boundaries, baseNoise, -1,-0.3)
		# drawAutoTiles(objectsMap, [3,40], boundaries, objectNoise, -.8, -.6)
		# drawStaticTiles(backgroundMap, 1, boundaries)
	
	count += 1
	
func drawAutoTiles(tileMap: TileMap, tileIndex: Array, boundaries, noise: OpenSimplexNoise, noiseMin: float, noiseMax: float):
	for i in boundaries:
		var tile = tileMap.get_cell(i.x, i.y)
		var hasTile = tile > -1
		if !hasTile: 
			var a = noise.get_noise_2d(i.x, i.y)
			if a <= noiseMax && a >= noiseMin:
				tileMap.set_cell(i.x, i.y, rand_range(tileIndex[0], tileIndex[1]))
				tileMap.update_bitmask_area(Vector2(i.x, i.y))

func drawStaticTiles(tileMap: TileMap, tileIndex: int, boundaries):
	for i in boundaries:
		var tile = tileMap.get_cell(i.x, i.y)
		var hasTile = tile > -1
		if !hasTile: tileMap.set_cell(i.x, i.y, tileIndex)

func generateTileBoundary(pos) -> Dictionary:
	var boundaries = [pos]
	
	for x in 48:
		for y in 28:
			boundaries.append({
				"x": pos.x + x,
				"y": pos.y + y
			})
			boundaries.append({
				"x": pos.x + x,
				"y": pos.y - y
			})
			boundaries.append({
				"x": pos.x - x,
				"y": pos.y + y
			})
			boundaries.append({
				"x": pos.x - x,
				"y": pos.y - y
			})
	
	return boundaries
