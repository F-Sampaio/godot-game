extends Node


func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/start.grab_focus()
	
	

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/start.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/start.grab_focus()
	
	if $MarginContainer/VBoxContainer/VBoxContainer/exit.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/exit.grab_focus()
	 


func _on_start_pressed():
	get_tree().change_scene("res://StageOne.tscn")


func _on_exit_pressed():
	get_tree().quit()
