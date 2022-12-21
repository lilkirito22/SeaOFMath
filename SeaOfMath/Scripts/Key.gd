extends Area2D
export var door : NodePath

func _on_body_entered(body):
	get_node(door).get_node("barreira").set_collision_mask_bit(0,0)
	get_node(door).get_node("texture").visible = false
	queue_free()
