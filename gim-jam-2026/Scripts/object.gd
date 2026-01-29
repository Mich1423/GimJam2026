extends CharacterBody2D

@export var snap_size := 32
@export var gucci:bool = false
@export var button: Button
@export var sprite: Sprite2D
@export var breakable: Sprite2D

var dragging := false
var offset := Vector2.ZERO

var rotated := false

const MOVE_INTERVAL := 0.1

var move_speed := 1200.0
var target_position := Vector2.ZERO
var move_timer := 0.0

func _ready() -> void:
	target_position = global_position.snapped(Vector2(snap_size, snap_size))

func _physics_process(delta: float) -> void:
	move_timer -= delta
	if gucci == true:
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider() is CharacterBody2D:
				_break()
				gucci = false

	
	if dragging and move_timer <= 0.0:
		var raw_target = get_global_mouse_position() - offset
		var grid_target = raw_target.snapped(Vector2(snap_size, snap_size))
		var diff = grid_target - target_position

		var candidate = target_position

		if abs(diff.x) > abs(diff.y):
			if diff.x > 0:
				candidate.x += snap_size
			elif diff.x < 0:
				candidate.x -= snap_size
		elif abs(diff.y) > 0:
			if diff.y > 0:
				candidate.y += snap_size
			elif diff.y < 0:
				candidate.y -= snap_size

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

func _break():
	Global.min_score_level_1 -= 1
	button.visible =  false
	sprite.visible =  false
	breakable.visible =  true


func _on_button_button_down() -> void:
	dragging = true
	offset = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false

func exit() -> void:
	AudioManager.play_sfx("collect")
	Global.score += 1
	queue_free()
