extends KinematicBody2D

export var speed = 64
var velocity = Vector2.ZERO
var move_direction = -1

func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction
	velocity.y = 0
	
	if move_direction == 1:
		$texture.flip_h = true
	else:
		$texture.flip_h = false
		
	_set_animation()
	
	velocity = move_and_slide(velocity)
	
func _set_animation():
	var anim = "idle"
	var anim2 = "noWind"
	
	if $ray_wall.is_colliding():
		anim = "idle"
		anim2="transitionNoWind"
		yield(get_tree().create_timer(0.2), "timeout")
		anim2 = "noWind"
	elif velocity.x != 0:
		anim = "idle"
		anim2 = "transitionWind"
		yield(get_tree().create_timer(0.2), "timeout")
		anim2 = "wind"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)
