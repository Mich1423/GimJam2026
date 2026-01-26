extends CharacterBody2D

var move_speed := 1200.0
const TILE_SET:Vector2 = Vector2(32,32)

@export_enum("Atas", "Bawah") var letak := 0
@export_group("Timer")
@export var timer: Timer
@export var timeout: float

var direction: Vector2
var target_position: Vector2
var moving: bool = false

func _ready() -> void:
	timer.wait_time = timeout
	timer.start()
	match letak:
		0:
			direction = transform.y
		1:
			direction = -transform.y

	# init target_pos
	target_position = global_position

func _on_timer_timeout() -> void:
	# set new target
	target_position = global_position + direction * TILE_SET
	moving = true

func _physics_process(delta: float) -> void:
	if moving:
		# calculate direction toward target
		var to_target = (target_position - global_position).normalized()

		# velocity toward target
		velocity = to_target * move_speed

		# if close enough to target, snap and stop
		if global_position.distance_to(target_position) < move_speed * delta:
			global_position = target_position
			velocity = Vector2.ZERO
			moving = false

		move_and_slide()
	else:
		velocity = Vector2.ZERO
		move_and_slide()
