extends Control

var plat_script = preload("res://palt.gd")
var plat_scene = preload("res://palt.tscn")
const Baloon = preload("res://balloon.tscn")
var plat_positions = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var baloon: Node = Baloon.instantiate()
	$Node2D2.add_child(baloon)
	baloon.start(load("res://tutorial.dialogue"), "main")
	
	for i in range(4):
		instance_platform()


func instance_platform():
	var platform = plat_scene.instantiate()
	var random_position = Vector2(randf_range(200, 1000), 347)
	while check_overlap(random_position):
		random_position = Vector2(randf_range(200, 1000), 347)
	platform.position = random_position
	platform.set_script(plat_script)
	plat_positions.append(random_position)
	$Node2D.add_child(platform)
	

func check_overlap(pos):
	for p in plat_positions:
		if pos.distance_to(p) < 150:
			return true
	return false

var game_pause : bool = false:
	get:
		return game_pause
	set(value):
		game_pause = value
		get_tree().paused = game_pause
		emit_signal("game_paused", game_pause)


signal game_paused(is_paused : bool)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("ui_left"):
		global.left = true
	
	if Input.is_action_pressed("jump"):
		global.jump = true
	
	if Input.is_action_pressed("ui_right"):
		global.right = true
	
	if Input.is_action_pressed("blue"):
		global.blue = true
	
	if Input.is_action_pressed("red"):
		global.red = true
	
	if Input.is_action_pressed("yellow"):
		global.yellow = true
	
	
	var viewport_rect = get_viewport_rect().size
	var window_height = viewport_rect.y
	
	if Input.is_action_just_pressed("pause"):
		game_pause = !game_pause
		emit_signal("game_paused", game_pause)

	if game_pause:
		return
	
	if $Player.position.y > window_height+400:
		get_tree().reload_current_scene()
		
	for plat in $Node2D.get_children():
		if plat.getC() == $Player.getC() :
			plat.setc(1)
		else:
			plat.setc(0)


