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
	var at_target = global_position.distance_to(target_position) < 1.0

	move_timer -= delta
	if dragging and at_target and move_timer <= 0.0:
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

		# Collision check
		if not is_position_blocked(candidate):
			target_position = candidate

		move_timer = MOVE_INTERVAL

	# Smooth movement toward target
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

func is_position_blocked(pos: Vector2) -> bool:
	var space = get_world_2d().direct_space_state
	
	var query = PhysicsShapeQueryParameters2D.new()
	
	query.shape = $CollisionShape2D.shape
	query.transform = Transform2D(0, pos)
	
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = collision_mask
	
	var results = space.intersect_shape(query, 1)
	return results.size() > 0
