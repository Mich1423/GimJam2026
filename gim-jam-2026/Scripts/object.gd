extends Node2D
class_name GridObject

const TILE_SIZE := Vector2(16,16)

@export var detect_area: Area2D

func _ready():
	print(name, " detect_area = ", detect_area)


func move_grid(dir: Vector2):
	global_position += dir * TILE_SIZE

func try_move(dir: Vector2) -> bool:
	

	var bodies = detect_area.get_overlapping_bodies()

	if bodies.is_empty():
		move_grid(dir)
		return true

	for body in bodies:
		if body == self:
			continue

		if body is GridObject:
			if body.try_move(dir):
				move_grid(dir)
				return true

	return false
