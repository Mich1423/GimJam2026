extends GridObject

@export_enum("Atas", "Bawah", "Kanan", "Kiri") var letak := 0
@export var timer: Timer
@export var timeout: float = 1.0

var direction: Vector2

func _ready():
	timer.wait_time = timeout
	timer.start()

	match letak:
		0: direction = Vector2.DOWN
		1: direction = Vector2.UP
		2: direction = Vector2.LEFT
		3: direction = Vector2.RIGHT

func _on_timer_timeout():
	try_move(direction)
