extends Control

var level
@onready var start = preload("res://start_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	level = get_node("/root/Level1")
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_level_1_toggle_game_paused(is_paused):
	if(is_paused):
		show()
		$Panel/Resume.grab_focus()
	else: 
		hide()

func _on_resume_pressed():
	level.game_paused = false

func _on_quit_pressed():
	get_tree().quit()


func _on_quit_to_menu_pressed():
	get_tree().change_scene_to_file(start)



