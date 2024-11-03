class_name MouseLookAtComponent extends Node

@export_category("Movement")
@export var rotation_speed: float = 90.0 ## degrees per second

var _mouse_position: Vector2 = Vector2.ZERO

# TODO: different easing
func _rotate_to(target_position: Vector2, delta: float) -> void:
	var direction: Vector2 = (target_position - owner.global_position).normalized()
	var angle_to = owner.transform.x.angle_to(direction)
	# var rotation_factor: float = velocity / speed # TODO
	var rotation_factor: float = 1.0 # the percentage of full speed; rotation slows are velocity slows
	owner.rotate(sign(angle_to) * min(delta * rotation_speed * rotation_factor * delta, abs(angle_to)))
	
func _physics_process(delta: float) -> void:
	if (_mouse_position.distance_squared_to(owner.global_position) < 10):
		return
	
	_rotate_to(_mouse_position, delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_position = event.position
