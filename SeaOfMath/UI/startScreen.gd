extends Control

func _ready():
	$controls/startBtn.grab_focus()
	
func _on_startBtn_pressed():
	get_tree().change_scene("res://Levels/Tutorial.tscn")
