extends KinematicBody2D

export var damage: int = 10
export var health: int = 20
export var speed: int = 50
export var knockback: float = 0.0

var target: Node2D = null
var velocity: Vector2 = Vector2.ZERO
var lastVelocity: Vector2 = Vector2.ZERO

func _on_DetectionRadius_body_entered(body) -> void:
	if body.is_in_group("Player"):
		target = body

func _on_LoseRadius_body_exited(body):
	if body.is_in_group("Player"):
		target = null	

func _physics_process(delta) -> void:
	velocity = Vector2.ZERO
	
	if !target:
		return
	
	var angle = get_angle_to(target.global_position)
	
	velocity.x = cos(angle)
	velocity.y = sin(angle)
	
	if velocity != Vector2.ZERO:
		lastVelocity = velocity
		
	$AnimationTree.set('parameters/Walk/blend_position', lastVelocity)
	
	manage_collision(move_and_collide(velocity * speed * delta))

func manage_collision(collider: KinematicCollision2D) -> void:
	if !collider:
		return
	
	if !collider.collider.is_in_group("Player"):
		return
		
	collider.collider.hit(damage, knockback)

func hit(damage: float) -> void:
	health -= damage
	if health <= 0:
		queue_free()
