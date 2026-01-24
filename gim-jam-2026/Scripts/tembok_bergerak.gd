extends Node2D

const TILE_SET: Vector2 = Vector2(16,16)

@export_enum("Atas", "Bawah", "Kanan", "Kiri") var letak := 0

@export_group("Timer")
@export var timer: Timer
@export var timeout: int

var direction
var move_dir: Vector2

func _ready():
	timer.wait_time = timeout
	timer.start()
	if letak == 2 || letak == 3:
		rotation_degrees = 90
	match letak:
		0:
			direction = Vector2.DOWN
		1:
			direction = Vector2.UP
		2:
			direction = Vector2.LEFT
		3:
			direction = Vector2.RIGHT


func _on_timer_timeout() -> void:
	global_position += direction * TILE_SET
