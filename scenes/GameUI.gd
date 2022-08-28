extends Control

var player: Player

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	pass

func _process(_delta):
	if player:
		$HealthBar.value = player.health
		$HealthBar.max_value = player.maxHealth
		$ExpBar.value = player.experience
