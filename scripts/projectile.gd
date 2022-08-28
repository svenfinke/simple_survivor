extends KinematicBody2D

export(float) var damage: float = 10
export(int) var speed: int = 200
export(int) var angle: int = 0

func do_collision(collision: KinematicCollision2D) -> void:
	if !collision:
		return
		
	if collision.collider.is_in_group("Enemy"):
		collision.collider.hit(damage)
		queue_free()
		
func _physics_process(delta) -> void:
	do_collision(move_and_collide(Vector2(cos(angle),sin(angle)) * delta * speed))
