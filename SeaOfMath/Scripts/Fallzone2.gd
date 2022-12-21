extends Area2D

func _ready():
	Global.points = 0

func _on_fallzone2_body_entered(body):
	get_tree().reload_current_scene()
