extends Area2D


func _ready():
	pass


func _on_Key_body_entered(body):
	if body.get_name() == "Player":
		body.hasKey = true
		visible = false
		call_deferred("free")
