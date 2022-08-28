extends Resource
class_name Shuriken

var projectile = preload("res://prefab/weapons/Shuriken.tscn")
var player = null

var cooldown: float = 1.0
var currentCooldown: float = 0.0
var num_projectiles: int = 3

func process(delta) -> void:
	currentCooldown -= delta
	
	if currentCooldown <= 0:
		shoot()
		currentCooldown = cooldown

func shoot() -> void:
	var angle = rand_range(0,360)
	for n in num_projectiles:
		var projectile_instance = projectile.instance()
		projectile_instance.angle = angle
		GlobalUtil.instance_node(projectile_instance, player.global_position, GlobalUtil.DefaultParent)
		angle -= 1
