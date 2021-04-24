extends Area2D

# var a = 2
# var b = "text"

func _ready():
	pass

func _on_Lava_body_entered(body):
	if body.get_name() == "Player":
		body.kill()
