extends KinematicBody2D

export (int) var speed = 6000
export (int) var jump_speed = -400
export (int) var gravity = 800

var velocity = Vector2.ZERO
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25


func get_input(dt:float):
	var dir = 0
		
	if Input.is_action_pressed("move_left"):
		dir -=1
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		dir +=1
		$AnimatedSprite.flip_h = false
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed * dt, acceleration)
		if velocity.y == 0:
			$AnimatedSprite.play("SMD_run")
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		$AnimatedSprite.play("SMD_idle")
		
func _physics_process(delta: float) -> void:
	get_input(delta)
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			$AnimatedSprite.play("SMD_jump")
			


