extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var c = 0
var col=1

var final_score = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $Sprite
var has_jumped = false

func setc(val:int):
	col=val
func _process(delta):
	
	set_collision_layer(1)
	set_collision_mask(1)
		
func _physics_process(delta):
	
	
	if Input.is_action_just_pressed("blue"):
		global.blue = true
		c = 1
		$Sprite.modulate = Color(0,0,1)
	if Input.is_action_just_pressed("red"):
		global.red = true
		c = 2
		$Sprite.modulate = Color(1,0,0)
	if Input.is_action_just_pressed("yellow"):
		global.yellow = true
		c = 3
		$Sprite.modulate = Color(1,1,0)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if(velocity.y <= 0):
			animated_sprite.animation = "jump"
		else:
			animated_sprite.animation = "fall"
	else:
		if(velocity.x == 0):
			animated_sprite.animation = "idle"
		else:
			animated_sprite.animation = "run"
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Jumpin.play();

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if(velocity.x < 0):
			animated_sprite.flip_h = true
		elif(velocity.x > 0):
			animated_sprite.flip_h = false
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
# Get the height of the game window
	var window_size = get_viewport_rect().size
	var window_height = window_size.y
	
	move_and_slide()

func getC() -> int:
	return c

func getFS() -> int:
	return final_score


