extends StaticBody2D

var Wall = load("res://scenes/Wall.tscn")
var wall1
var wall2

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		if body.hasKey == true:
			$"door collision".queue_free()
			$Sprite.queue_free()
			body.hasKey = false


func _on_Area2D2_body_entered(body):
	if body.get_name() == "Player":
		wall1 = Wall.instance()
		call_deferred("add_child",wall1)
		wall2 = Wall.instance()
		wall2.position.y -= 64
		call_deferred("add_child",wall2)
