class_name MathUtil extends RefCounted

# https://www.youtube.com/watch?v=LSNQuFEDOyQ&t=20s - Lerp smoothing is broken 

# decay: 1 to 25 (slow to fast)
func exp_decay(from: float, to: float, decay: float, delta: float) -> float:
	return to + (from - to) * exp(-decay * delta)

func move_to_value(from: float, to: float, speed: float, delta: float) -> float:
	var distance: float = to - from
	var step_distance: float = speed * delta
	if (step_distance >= abs(distance)):
		return to
	return from + sign(distance) * step_distance

func move_to_point(from: Vector2, to: Vector2, speed: float, delta: float) -> Vector2:
	var distance: Vector2 = to - from
	var step_distance: float = speed * delta
	if (step_distance >= distance.length()):
		return to
	return from + distance.normalized() * step_distance
