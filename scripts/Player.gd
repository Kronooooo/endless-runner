extends KinematicBody2D

var xSpeed = 400
var ySpeed = 1000
var velocity = Vector2()
var minCameraX = 0

var hasKey = false

const GRAVITY = 2000

func _ready():
	set_physics_process(true)
		
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	getInput()
	velocity = move_and_slide(velocity, Vector2(0,-1))
	position.x = clamp(position.x,get_node("Camera2D").position.x+10,position.x+30)
	if $Camera2D.position.x > minCameraX:
		$Camera2D.limit_left = $Camera2D.position.x
		minCameraX = $Camera2D.position.x


func getInput():
	if Input.is_action_pressed("ui_left"):
		velocity.x = -xSpeed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = xSpeed
	else:
		velocity.x = 0
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -ySpeed

func kill():
	get_tree().reload_current_scene()
