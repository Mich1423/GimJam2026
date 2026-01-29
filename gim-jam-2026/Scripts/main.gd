extends Node2D

@export var score_label: Label
@export_file_path("*.tscn") var main_menu: String
@export_file_path("*.tscn") var stage2: String
@export var stage = Global.stage
var last_score_value := 0

func _ready() -> void:
	print("Main menu path:", main_menu)
	# Initialize stored value
	last_score_value = Global.score
	_update_score_label()
	if Global.stage == Global.State.STAGE1:
		AudioManager.play_music("Dungeon")
	elif Global.stage == Global.State.STAGE2:
		AudioManager.play_music("House")


func _process(_delta: float) -> void:
	# Check for change
	if Global.score == last_score_value:
		return
	
	last_score_value = Global.score
	_update_score_label()
	
	if Global.score == Global.min_score_level_1 and stage == Global.State.STAGE1:
		print("Stage 1 Clear")
		Global.score = 0
		Global.stage = Global.State.STAGE2
		get_tree().change_scene_to_file(stage2)
	elif Global.score == Global.min_score_level_1 and stage==Global.State.STAGE2:
		print("Stage 2 Clear")
		Global.score = 0
		Global.stage = Global.State.STAGE1
		get_tree().change_scene_to_file(main_menu)

func _update_score_label() -> void:
	score_label.text = str(Global.score)
