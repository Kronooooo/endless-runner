extends Node2D

func _ready():
	pass

func _on_Start_Button_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_Settings_Button_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_Exit_Button_pressed():
	get_tree().quit()
