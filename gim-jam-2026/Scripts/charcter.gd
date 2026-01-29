extends StaticBody2D

@export var dungeon: Sprite2D
@export var haunted: Sprite2D

func _ready() -> void:
	if Global.stage == Global.State.STAGE1:
		dungeon.visible = true
	else :
		haunted.visible = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Wall"):
		print("You Lose")
