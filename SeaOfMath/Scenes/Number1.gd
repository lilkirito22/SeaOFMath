extends Area2D

var vidaNumero = 2
func _ready():
	pass
	


func _on_Area2D_body_entered(body):
	if body.name == "Player":
			$AudioErrado.play()
			vidaNumero -= 1
	if vidaNumero < 1:
		queue_free()		
