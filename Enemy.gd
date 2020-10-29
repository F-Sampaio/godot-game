extends KinematicBody2D

const GRAVITY = 1
const SPEED = 10
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1
var is_Dead = false

func _ready():
	pass

func dead():
	is_Dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.disabled = true
	$Timer.start()

func _physics_process(delta):
	if is_Dead == false:
		velocity.x = SPEED * direction
		$AnimatedSprite.play("walk")	
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead
				dead()
				
func _on_Timer_timeout():
	queue_free()
