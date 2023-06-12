extends Control

@onready var level = get_node("/root/Level1")
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if level.game_over:
		$Panel/FinalScore.text = "[center]Score: [/center]" + str(level.score)


func _on_level_1_signal_game_over(is_over):
	if(is_over):
		show()
	else:
		hide()

func _on_restart_pressed():
	get_tree().reload_current_scene()


func _on_start_menu_pressed():
	get_tree().change_scene_to_file("res://start_screen.tscn")


func _on_quit_pressed():
	get_tree().quit()
