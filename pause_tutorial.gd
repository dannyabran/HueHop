extends Control

var tutorial
# Called when the node enters the scene tree for the first time.
func _ready():
	tutorial = get_node("/root/Tutorial")
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_tutorial_game_paused(is_paused):
	if(is_paused):
		show()
		$Panel/VBoxContainer/Restart.grab_focus()
	else: 
		hide()

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_quit_to_menu_pressed():
	get_tree().change_scene_to_file("res://start_screen.tscn")



