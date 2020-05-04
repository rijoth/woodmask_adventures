extends KinematicBody2D

export (int) var speed = 2500
export (int) var jump_speed = -400
export (int) var gravity = 800

export var dir = -1

export var health = 2

var velocity = Vector2.ZERO
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

func enemy_move(dt:float):
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed * dt, acceleration)
	if dir < 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true

func _on_CollisionDetector_area_entered(area: Area2D) -> void:
	#check for the collision detector i implemented by name
	var col = area.get_name()
	if col.find("CollisionDetector") != -1 :
		dir = dir * -1

func _on_StompDetector_area_entered(area: Area2D) -> void:
	var col = area.get_name()
	if col.find("PlayerCollisionDetector") != -1 :
		health = health - 1
	if health <=0:
		queue_free()
	else:
		$AnimatedSprite.play("Spig_run")
		speed = speed + 4000


func _physics_process(delta: float) -> void:
	enemy_move(delta)
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.UP)
	




