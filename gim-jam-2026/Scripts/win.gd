extends Control

@export_file_path("*.tscn") var main_menu: String

func _ready() -> void:
	if Global.condition == 0:
		AudioManager.play_music("win")
	else:
		AudioManager.play_music("lose")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu)
