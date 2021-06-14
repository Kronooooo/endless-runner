extends Area2D

# var a = 2
# var b = "text"

func _ready():
	pass

func _on_Lava_body_entered(body):
	if body.get_name() == "Player":
		body.kill()
	
	if "Enemy" in body.get_name():
		body.position.x += 64
		body.position.y -= 20
