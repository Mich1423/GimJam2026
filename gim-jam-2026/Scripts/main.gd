extends Node2D

@export var score_label: Label

var last_score_value := 0

func _ready() -> void:
	# Initialize stored value
	last_score_value = Global.score
	_update_score_label()

func _process(_delta: float) -> void:
	# Check for change
	if Global.score == last_score_value:
		return
	
	last_score_value = Global.score
	_update_score_label()

func _update_score_label() -> void:
	score_label.text = str(Global.score)
