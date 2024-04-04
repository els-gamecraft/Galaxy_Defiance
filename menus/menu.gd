extends Control


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("touch"):
		get_tree().change_scene_to_file("res://Scenes/world.tscn")
	
	
