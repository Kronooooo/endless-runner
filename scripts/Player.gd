extends KinematicBody2D

var xSpeed = 400
var ySpeed = 900
var velocity = Vector2()
var minCameraX = 0

var deflecting = false
var canDeflect = true
var hasKey = false
var deflectRange = 0.1

onready var deflectTimer = $Deflect
onready var cooldown = $Cooldown
onready var ray = $RayCast2D

const GRAVITY = 2000
const deflectSide = [-1,1]

func _ready():
	set_physics_process(true)
		
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	getInput()
	velocity = move_and_slide(velocity, Vector2(0,-1))
	position.x = clamp(position.x,0,INF)

func getInput():
	if deflecting == false:
		if Input.is_action_pressed("left"):
			velocity.x = -xSpeed
		elif Input.is_action_pressed("right"):
			velocity.x = xSpeed
		else:
			velocity.x = 0
		if Input.is_action_just_pressed("jump") && is_on_floor():
			velocity.y = -ySpeed
		if Input.is_action_just_released("jump"):
			if velocity.y < -50:
				velocity.y = lerp(velocity.y,-50,0.6)
		if Input.is_action_just_pressed("deflect") && canDeflect:
			canDeflect = false
			deflecting = true
			deflectTimer.start()
			$Sprite.set_modulate(Color(0,0,0,1))
			
func deflect():
	randomize()
	var angleIncrement = cos((PI/2)*cooldown.get_time_left()/cooldown.get_wait_time())
	deflectSide.shuffle()
	var x = (get_angle_to(position-get_local_mouse_position()) + (angleIncrement * deflectRange)) * deflectSide[0]
	ray.set_cast_to(Vector2(-1,0).rotated(x).normalized() * 1000)
	ray.set_enabled(true)
	canDeflect = true
	yield(get_tree().create_timer(get_physics_process_delta_time()),"timeout")
	if ray.get_collider() != null:
		deflecting = false
		if "Enemy" in ray.get_collider().get_name():
			ray.get_collider().damage()
			ray.set_enabled(false)
		

func kill():
	get_tree().reload_current_scene()
	
func isDeflecting():
	return deflecting

func _on_Deflect_timeout():
	$Sprite.set_modulate(Color(1,1,1,1))
	deflecting = false
	cooldown.start()

func _on_Cooldown_timeout():
	canDeflect = true
	ray.set_enabled(false)
