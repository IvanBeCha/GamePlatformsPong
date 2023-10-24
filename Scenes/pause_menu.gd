extends Control

@onready var main = $"../../"

func _on_resumir_pressed():
	main.pauseMenu()

func _on_salir_pressed():
	get_tree().quit()
