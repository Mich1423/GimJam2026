extends Node2D

const TILE_SET:Vector2 = Vector2(16,16)

@export_enum("Atas", "Bawah", "Kanan", "Kiri") var letak := 0
@export_group("Timer")
@export var timer: Timer
@export var timeout:float

var direction: Vector2

func _ready() -> void:
	timer.wait_time = timeout
	timer.start()
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
