extends StaticBody2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		if body.hasKey == true:
			queue_free()
			body.hasKey = false
