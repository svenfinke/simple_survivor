extends Node2D

onready var demoScene : PackedScene = preload("res://scenes/ProcedurallyGenerated.tscn")

func _on_Button_pressed():
	get_tree().change_scene_to(demoScene)
	
