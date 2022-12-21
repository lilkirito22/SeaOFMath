extends KinematicBody2D

var UP = Vector2.UP
var velocity = Vector2()
var move_speed = 600
var gravity = 1200
var jump_force = -900
var is_grounded

var player_health = 3
var max_health = 3

var hurted = false
var knockback_dir = 1
var knockback_int = 600
var control_r = 0
var control_l = 0
var control_jump = 0


onready var raycasts = $raycasts

signal change_life(player_health)


func _ready() -> void:
	Global.set("player", self)
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/Holder"), "on_change_life")
	emit_signal("change_life", max_health)
	Serial.connect("esquerda", self, "_on_esquerda")
	Serial.connect("direita", self, "_on_direita")
	Serial.connect("afk", self, "_on_afk")
	Serial.connect("pulo", self, "_on_pulo")
	
	
	
func _on_esquerda():
	control_l = 1
	control_r = 0
	
func _on_direita():
	control_r = 1
	control_l = 0
func _on_afk():
	control_r = 0
	control_l = 0
func _on_pulo():
	if  is_grounded:
		velocity.y = jump_force / 2
		$AudioPulo.play()

	
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = 0
	
	if !hurted:
		_get_input()
		
	velocity = move_and_slide(velocity, UP)
	
	is_grounded = _check_is_ground()
	
	_set_animation()
	
func _get_input():
	velocity.x = 0
	var move_direction = control_r - control_l
	velocity.x =  lerp(velocity.x, move_speed * move_direction, 0.2)
	print(move_direction)
	
	
	if move_direction !=0:
		$sprite.scale.x = move_direction
		knockback_dir = move_direction
		

func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false
	
func _set_animation():
	var anim = "idle"
	
	if !is_grounded:
		anim = "jump"
		
		
	elif velocity.x != 0:
		anim = "run"
	
	if velocity.y > 0 and !is_grounded:
		anim = "fall"
	
	if hurted:
		anim = "hit"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)


func knockback():
	if $right.is_colliding():
		velocity.x = -knockback_dir * knockback_int
		
	if $left.is_colliding():
		velocity.x = knockback_dir * knockback_int
		
	velocity = move_and_slide(velocity)
	
func _on_hurtbox_body_entered(body):
	player_health -= 1
	hurted = true
	emit_signal("change_life", player_health)
	knockback()
	get_node("hurtbox/collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5),"timeout")
	get_node("hurtbox/collision").set_deferred("disabled", false)
	hurted = false
	if player_health < 1:
		queue_free()
		get_tree().reload_current_scene()


func _on_hurtbox_area_entered(area):
	player_health -= 1
	hurted = true
	emit_signal("change_life", player_health)
	knockback()
	get_node("hurtbox/collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5),"timeout")
	get_node("hurtbox/collision").set_deferred("disabled", false)
	hurted = false
	if player_health < 1:
		queue_free()
		get_tree().reload_current_scene()
