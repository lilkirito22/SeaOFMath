extends enemyBaseC4

func _process(delta):
	if $ray_wall.is_colliding():
		$texture.flip_h != $texture.flip_h
		$ray_wall.scale.x *= -1
		move_direction *= -1
		$anim.play("run")
