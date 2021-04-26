extends StaticBody2D

var used = false

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player" && used == false:
		used = true
		get_parent().generateTerrain()
