extends Node2D
onready var platform = $ship
onready var tween = $Tween

export var speed = 5.0
export var horizontal = true
export var distance = 500

const WAIT_DURATION = 1.0

func _ready():
	_start_tween()

func _start_tween():
	var move_direction = Vector2.RIGHT * distance if horizontal else Vector2.UP * distance
	var duration = move_direction.length() / float(speed * 16)
	tween.interpolate_property(
		platform, "position", Vector2.ZERO, move_direction, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, WAIT_DURATION
	)
	tween.interpolate_property(
		platform, "position", move_direction, Vector2.ZERO, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + WAIT_DURATION * 2
	)
	tween.start()

func _on_Area2D_body_entered(body):
	$ship/texture.flip_h = false
	$ship/sail/texture2.flip_h = false

func _on_Area2D_body_exited(body):
	$ship/texture.flip_h = true
	$ship/sail/texture2.flip_h = true
