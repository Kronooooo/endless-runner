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
