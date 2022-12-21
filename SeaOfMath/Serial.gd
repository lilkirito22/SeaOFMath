extends Node

const serial_res = preload("res://bin/gdserial.gdns")
onready var serial_port = serial_res.new()

var is_port_open = false
var text = ""
signal afk(player)
signal esquerda(player)
signal pulo(player)
signal direita(player)
signal potenciometro(player, value)
signal joystick(player, x_value, y_value)


func _ready():
	open()
	pass


func _exit_tree():
	close()


func open():
	is_port_open = serial_port.open_port('COM3', 9600)
	print(is_port_open)


func write(text):
	serial_port.write_text(text)


func close():
	is_port_open = false
	serial_port.close_port()


func _process(delta):
	if is_port_open:
		var t = serial_port.read_text()
		
		if t.length() > 0:
			for c in t:
				if c == "\n":
					on_text_received(text)
					text = ""
				else:
					text+=c
			#print(t)
		


"""
* Função que trata o recebimento dos dados, seguindo o seguinte protocolo:
**** Botões -> Exemplo: "1 Sobe" (Player 1 sobe)
**** Potenciômetros -> Exemplo: "2 -7" (Player 2 desloque em direção a -7)
**** Joystick -> Exemplo: "1 5 -2" (Player 1 desloque na direção 5 em x e -2 em y)
"""
func on_text_received(text):
	
	var command_array = text.split(" ")
	#print(command_array)
	
	if len(command_array) < 2:
		return

	if str(command_array[0]) == "Esquerda":
		emit_signal("esquerda")
		
	elif command_array[0] == "Direita":
		emit_signal("direita")
		
	elif command_array[0] == "Pulou":
		emit_signal("pulo")
	elif command_array[0] == "Afk":
		emit_signal("afk")
	
	
			
		
		
	
	
