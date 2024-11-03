class_name GroundColliderComponent extends CharacterBody2D

@export var ground_layer: int = 1
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var collision: KinematicCollision2D

func _ready() -> void:
	collision_layer = 0
	collision_mask = ground_layer
	process_priority = 2

func _physics_process(delta: float) -> void:
	collision = move_and_collide(Vector2.ZERO, true)
	if (collision):
		var tween: Tween = create_tween()
		tween.tween_property(owner, "offset:y", -200, 0.1)
	else:
		var tween: Tween = create_tween()
		tween.tween_property(owner, "offset:y", 0, 0.1)

func _draw() -> void:
	if (collision):
		var collision_position: Vector2 = collision.get_position() - global_position
		draw_circle(collision_position, 10, Color.WHITE, true)
		#draw_line(collision.get_position(), collision.get_normal(), Color.WHITE, 2.0)

		#draw_circle(collision.get_normal(), 10, Color.CYAN, true)
		#draw_line(collision.get_normal() * -collision.get_depth(), collision.get_normal(), Color.CYAN, 2.0)
		#draw_circle(collision.get_normal() * -collision.get_depth(), 10, Color.DARK_CYAN, true)

		pass
