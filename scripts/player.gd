extends KinematicBody2D
class_name Player

# onready var  animation_mode = $AnimationTree.get("parameters/playback")

export var speed: int = 150
export var health: int = 50
export var maxHealth: int = 50
export var immunityTimeInSeconds: float = 2
export var experience: int = 0

var immunityTimer: float = 0
var lastVelocity: Vector2 = Vector2.ZERO
var weapons: Array

func _ready() -> void:
	weapons.append(Shuriken.new())
	
	for weapon in weapons:
		weapon.player = self

func _physics_process(_delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1.0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1.0
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1.0
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1.0
		
	velocity = velocity.normalized()
	
	# if velocity != Vector2.ZERO:
	#	lastVelocity = velocity
	#	animation_mode.travel("Walk")
#	else:
#		animation_mode.travel("Idle")
	
	# $AnimationTree.set('parameters/Walk/blend_position', lastVelocity)
	# $AnimationTree.set('parameters/Hit/blend_position', lastVelocity)

	move_and_slide(velocity * speed)

func _process(delta):
	immunityTimer -= delta
	for weapon in weapons:
		weapon.process(delta)

func hit(dmg: int, knockback: float = 0.0) -> void:
	if immunityTimer >= 0:
		return
		
	health -= dmg
	immunityTimer = immunityTimeInSeconds
	# animation_mode.travel("Hit")
