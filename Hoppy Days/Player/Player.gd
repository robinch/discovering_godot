extends KinematicBody2D

const SPEED = 1500
const GRAVITY = 300
const UP = Vector2(0,-1)
const JUMP_SPEED = 5000	

var motion = Vector2(0,0)

signal animate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)

func apply_gravity():
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY
	
func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED
	
func move():
	var is_left_pressed = Input.is_action_pressed("left")
	var is_right_pressed = Input.is_action_pressed("right")
	
	if is_left_pressed and not is_right_pressed:
		motion.x = -SPEED
	elif is_right_pressed and not is_left_pressed:
		motion.x = SPEED
	else:
		motion.x = 0

func animate():
	emit_signal("animate", motion)
