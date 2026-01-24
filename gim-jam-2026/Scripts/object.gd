extends Sprite2D

var dragging := false
var of := Vector2.ZERO

var snap := 32

func _process(_delta: float) -> void:
	if not dragging:
		return
	
	var newPos = get_global_mouse_position() - of
	position = Vector2(snapped(newPos.x, snap), snapped(newPos.y, snap))

func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
