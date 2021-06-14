extends KinematicBody2D

var speed = 200
var directions = [-1,1]
var direction
var velocity = Vector2(0,0)
var target
var hp = 1

const GRAVITY = 2000
const MAXLENGTH = 2000

onready var ray = $RayCast2D
onready var timer = $Timer
onready var charge = $RayCast2D/ChargeUp
onready var beam = $RayCast2D/Beam
onready var tween = $RayCast2D/Tween

func _ready():
	set_physics_process(true)
	directions.shuffle()
	direction = directions[0]
	
func _physics_process(delta):
	velocity.x = direction * speed
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity,Vector2(0,-1))
	if is_on_wall():
		direction = -direction
	if target != null:
		aim(target,delta)
	else:
		timer.stop()
		if direction == 0:
			directions.shuffle()
			direction = directions[0]
	if hp <= 0:
		call_deferred("free")
	
func aim(body,delta):
	ray.set_enabled(true)
	ray.cast_to = (body.global_position-ray.global_position).normalized() * MAXLENGTH
	yield(get_tree().create_timer(delta),"timeout")
	if ray.get_collider() != null:
		if "Player" in ray.get_collider().get_name():
			if timer.is_stopped() == true:
				direction = 0
				timer.start(1)
				charge.emitting = true
				
	if timer.time_left < 0.1:
		yield(get_tree().create_timer(delta),"timeout")
		beam.add_point(ray.cast_to)
		beam.width = 10
		beam.visible = true
		$Sprite.set_modulate(Color(0,1,0,1))
	else:
		$Sprite.set_modulate(Color(1,1,1,1))
		beam.width = 10
		beam.visible = false
		
func damage():
	hp -= 1
	
func _on_Lava_Detection_area_entered(area):
	if "lava" in area.get_name().to_lower():
		direction = -direction

func _on_Area2D_body_entered(body):
	if "Player" in body.get_name():
		target = body

func _on_Area2D_body_exited(body):
	if "Player" in body.get_name():
		target = null
		directions.shuffle()
		direction = directions[0]
		ray.set_enabled(false)

func _on_Timer_timeout():
	if "Player" in ray.get_collider().get_name():
		if ray.get_collider().isDeflecting() == false:
			ray.get_collider().kill()
		else:
			ray.get_collider().deflect()
	ray.set_enabled(false)
	beam.clear_points()
		
func _on_Area2D2_body_entered(body):
	if "Lava" in body.get_name():
		position.x += 64
		position.y -= 20
