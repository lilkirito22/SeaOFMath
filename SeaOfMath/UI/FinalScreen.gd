extends Control

func _ready():
	$controls/ReStartBtn.grab_focus()

func _on_ReStartBtn_pressed():
	get_tree().change_scene("res://UI/startScreen.tscn")
