extends Node2D
var plat_script = load("res://palt.gd")
var plat_scene = preload("res://palt.tscn")
var number_of_plats = 10
var plat_speed = 0.5
var plat_positions = []
var vel = 0.001
var start_time = 0

var score : int 



func _ready():
	start_time = Time.get_ticks_usec()
	randomize()
	for i in range(number_of_plats):
		instance_platform()

func instance_platform():
	var random_position = Vector2(randf_range(-200, 1000), randf_range(-10, 90))
	while check_overlap(random_position):
		random_position = Vector2(randf_range(-200, 1000), randf_range(-10, 90))
	var platform = plat_scene.instantiate()
	platform.position = random_position
	platform.set_script(plat_script)
	platform.velocity = Vector2(-plat_speed * 90, 0)
	plat_positions.append(random_position)
	print(plat_positions)
	$Node2D.add_child(platform)


func check_overlap(pos):
	for p in plat_positions:
		if pos.distance_to(p) < 110:
			return true
	return false


var game_over: bool = false:
	get:
		return game_over
	set(v):
		game_over = v
		emit_signal("signal_game_over", game_over)

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)


signal toggle_game_paused(is_paused : bool)

signal signal_game_over(is_over : bool)

func _process(delta):
	var viewport_rect = get_viewport_rect().size
	var window_height = viewport_rect.y
	
	if Input.is_action_just_pressed("pause"):
		game_paused = !game_paused
		emit_signal("toggle_game_paused", game_paused)

	if game_paused:
		return
	
	if $Player.position.y > window_height+400:
		game_over = true
		emit_signal("signal_game_over", game_over)
	
	if game_over:
		$audioviz/mplayer.stop()
		return
	
	print(game_over)
	
	var elapsed_time = (Time.get_ticks_usec() - start_time) / 1000000.0
	
	if elapsed_time == 10:
		$Plat2.queue_free()
	else:
		$Plat2.position -= $Plat2.velocity * (delta + elapsed_time)
	
	
	for plat in $Node2D.get_children():
		if plat.getC() == $Player.getC() :
			plat.setc(1)
		else:
			plat.setc(0)
		if plat.position.x > -viewport_rect.x-200:
			
			plat.position += plat.velocity * (delta + vel)
			
		else:
			plat.position.x = viewport_rect.x+150
			plat.position.y = randf_range(-10, 80)
			plat._ready()
	
	
	print("Elapsed time: %.2f seconds" % elapsed_time)
		
	var initial_speed = 0.05
	var decay_factor = 0.1
	var time_since_deceleration = -1 * elapsed_time / 100
	
	vel = (initial_speed * (1 + pow(decay_factor, time_since_deceleration))) / 1.5
	
	score = int(elapsed_time)
	var Score_label = get_node("UI/Control/Score")
	Score_label.text = "Score: " + str(score) 







