extends CharacterBody2D

var dragging := false
var offset := Vector2.ZERO

const SNAP_SIZE := 32
const MOVE_INTERVAL := 0.1

var move_speed := 1200.0
var target_position := Vector2.ZERO
var move_timer := 0.0

func _ready() -> void:
	target_position = global_position.snapped(Vector2(SNAP_SIZE, SNAP_SIZE))

func _physics_process(delta: float) -> void:
	move_timer -= delta

	if dragging and move_timer <= 0.0:
		var raw_target = get_global_mouse_position() - offset
		var grid_target = raw_target.snapped(Vector2(SNAP_SIZE, SNAP_SIZE))
		var diff = grid_target - target_position

		var candidate = target_position

		if abs(diff.x) > abs(diff.y):
			if diff.x > 0:
				candidate.x += SNAP_SIZE
			elif diff.x < 0:
				candidate.x -= SNAP_SIZE
		elif abs(diff.y) > 0:
			if diff.y > 0:
				candidate.y += SNAP_SIZE
			elif diff.y < 0:
				candidate.y -= SNAP_SIZE

		if candidate != target_position:
			target_position = candidate
			AudioManager.play_sfx("move")
			move_timer = MOVE_INTERVAL

	# Smooth movement to target
	var to_target = target_position - global_position
	if to_target.length() > 1.0:
		velocity = to_target * move_speed * delta 
	else:
		velocity = Vector2.ZERO
		global_position = target_position

	move_and_slide()

func _on_button_button_down() -> void:
	dragging = true
	offset = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false

func exit() -> void:
	AudioManager.play_sfx("collect")
	Global.score += 1
	queue_free()
