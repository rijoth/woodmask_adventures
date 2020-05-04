extends Area2D

var timer = 0
var timer_wait_time = 0.5

var is_collided = false

	
func _on_Apple_area_entered(area: Area2D) -> void:
	is_collided = true
	$AnimatedSprite.play("anim_apple_destroy")


func _process(delta: float) -> void:
	if is_collided:
		timer += delta
		if (timer >= timer_wait_time):
			timer -= timer_wait_time
			queue_free()
	
	
