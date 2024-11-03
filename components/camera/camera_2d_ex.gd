class_name Camera2DEx extends Camera2D

enum FollowMode {
	NONE,
	GLUED,
	SIMPLE,
	GROUP,
	PATH,
	FRAME
}

@export var follow_target: Node2D
@export var follow_mode: FollowMode
@export var follow_damping: Vector2
@export var deadzone_width: float
@export var deadzone_height: float
@export var bounds: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (bounds):
		var collision_shape_2d: CollisionShape2D = bounds.get_child(0)
		var rect: Rect2 = collision_shape_2d.shape.get_rect()
		limit_top = rect.position.y + collision_shape_2d.global_position.y
		limit_bottom = rect.position.y + rect.size.y + collision_shape_2d.global_position.y
		limit_left = rect.position.x + collision_shape_2d.global_position.x
		limit_right = rect.position.x + rect.size.x + collision_shape_2d.global_position.x



func _physics_process(delta: float) -> void:
	if (follow_target):
		global_position = follow_target.global_position
