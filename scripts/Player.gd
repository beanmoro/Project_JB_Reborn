extends KinematicBody2D

#Constantes
const GRAVITY = 25
const MAX_VSPEED = 1000

#Variables
var jump_force = 500
var speed = 30

var respawn_holder = 0

var vspd = 0
var hspd = 0

var n_jump = 1
var max_jumps = 1

var keys = 0

var checkpoint_coord = Vector2()

var is_grounded = false
var is_jumping = false

var dead = false

onready var camera = $Camera2D

func _ready():
	pass

func _physics_process(delta):
	process_input()
	
	if !dead:
		$Sprite.show()
		process_movement()
	else:
		if $Light2D.energy > 0:
			$Light2D.energy-= 0.01
		$Sprite.hide()


func process_movement():
	
	is_grounded = is_on_floor()
	
	if !is_grounded:
		if vspd < MAX_VSPEED:
			vspd += GRAVITY
		else:
			vspd = MAX_VSPEED
	elif is_grounded && !Input.is_action_just_pressed("mb_left"):
		vspd = 0
		n_jump = max_jumps
	
	if is_jumping && vspd >= 0:
		is_jumping = false
		
	if is_on_ceiling():
		vspd = 0
		
	var snap = Vector2.DOWN * 16 if !is_jumping else Vector2.ZERO
	move_and_slide_with_snap(Vector2(hspd * speed, vspd), snap, Vector2(0, -1))


func process_input():
	
	if Input.get_accelerometer().x < -0.1 && camera.rotation_degrees > -20:
		camera.rotation_degrees -= 1*abs(Input.get_accelerometer().x)
	elif Input.get_accelerometer().x > 0.1 && camera.rotation_degrees < 20:
		 camera.rotation_degrees += 1*abs(Input.get_accelerometer().x)
	
	if abs(Input.get_accelerometer().x) > 0.1 && abs(hspd) < 10:
		hspd = 2*Input.get_accelerometer().x
	elif abs(hspd) > 0.1:
		hspd *= 0.8
	else:
		hspd = 0
	
	if Input.is_action_just_pressed("mb_left") && n_jump > 0:
		vspd -= jump_force
		is_jumping = true
		n_jump -= 1
	
	if dead && Input.is_action_pressed("mb_left"):
		if respawn_holder > 30:
			respawn()
			respawn_holder = 0
		else:
			respawn_holder+=0.5

func kill():
	dead = true

func respawn():
	position = checkpoint_coord
	$Light2D.energy = 2.5
	keys = $"/root/Global".savedkeys
	var doors = get_tree().get_nodes_in_group("door_group")
	for door in doors:
		if !door.insured :
			door.repos()
	
	var keys = get_tree().get_nodes_in_group("key_group")
	for key in keys:
		if !key.insured :
			key.repos()
	
	dead = false