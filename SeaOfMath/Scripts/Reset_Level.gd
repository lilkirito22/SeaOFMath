extends Node


func _ready():
	
	Global.points = 0

func _on_fallzone_body_entered(body):
	get_tree().reload_current_scene()
