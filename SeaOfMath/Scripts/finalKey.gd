extends Area2D
export var doorFinal : NodePath

func _on_finalKey_body_entered(body):
	get_node(doorFinal).get_node("barreira").set_collision_mask_bit(0,0)
	get_node(doorFinal).get_node("texture").visible = false
	queue_free()
