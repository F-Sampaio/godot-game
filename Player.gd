extends KinematicBody2D

const SPEED = 1
const JUMP_SPEED = -350
const GRAVITY = 20
const FLOOR = Vector2(0, -1)
const FIRE_BALL = preload("res://FireBall.tscn")

var velocity = Vector2()
var on_ground = false
var is_dead = false
var Enemy = preload("res://Enemy.gd").new()


	

func _physics_process(delta):
	
	if is_dead == false:
		if Input.is_action_pressed("ui_right"):
			velocity.x += SPEED
			$AnimatedSprite.play("Running")
			$AnimatedSprite.flip_h = false
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= SPEED
			$AnimatedSprite.play("Running")
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		else:
			velocity.x = 0
			if on_ground == true:
				$AnimatedSprite.play("Idle")
		
		if Input.is_action_pressed("ui_up"):
			if on_ground == true:
				velocity.y = JUMP_SPEED
				on_ground = false
	
		if Input.is_action_just_pressed("ui_shoot"):
			if is_on_floor():
				velocity.x = 0
	
			var fireball = FIRE_BALL.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fire_direction(1)
			else:
				fireball.set_fire_direction(-1)

			get_parent().add_child(fireball)
			fireball.global_position = $Position2D.global_position

		velocity.y += GRAVITY
		
		if is_on_floor():
			on_ground = true
		else:
			on_ground = false
			$AnimatedSprite.play("Jump")
			
		velocity = move_and_slide(velocity, FLOOR)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					on_dead()
	
func on_dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play("Dead")
	$CollisionShape2D.disabled = true
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Menu.tscn") 
