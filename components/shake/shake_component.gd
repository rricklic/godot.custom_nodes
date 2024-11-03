class_name ShakeComponent extends Node

# Math for Game Programmers: Juicing Your Cameras With Math 
# https://www.youtube.com/watch?v=tu-Qe66AvtY&t=949s
# 09:54 - equations
# 14:00 - noise vs random
# 15:25 - take away

# Trauma based screen shake
# directional and rotational based
# time scaled
# linear trauma recovery with adjustable factor value recovery_factor
# linear, quadratic, or cubic shake factor based on trauma
# target must have 
#   offset: Vector2
#   angle_offset: float

enum ShakeCalculation {
	TRAUMA,
	TRAUMA_SQUARED,
	TRAUMA_CUBED
}

@export var noise: FastNoiseLite = FastNoiseLite.new()
@export var noise_speed: float = 1000.0
@export var max_angle: float = 15.0 ## degrees
@export var max_offset: float = 50.0 ## pixels
@export var shake_calculation: ShakeCalculation = ShakeCalculation.TRAUMA_SQUARED
@export var recovery_factor: float = 1.0
@export var target: Node

var trauma: float = 0.0 # 0.0 to 1.0
var time: float = 0.0
var _calc_shake: Callable = func(): return trauma

func _ready() -> void:
	if (target == null):
		target = owner

	if (shake_calculation == ShakeCalculation.TRAUMA_SQUARED):
		_calc_shake = _calc_shake_squared
	elif (shake_calculation == ShakeCalculation.TRAUMA_CUBED):
		_calc_shake = _calc_shake_cubed

func apply_trauma(amount: float) -> void:
	trauma = clamp(trauma + amount, 0, 1)
	
func recover_from_trauma(delta: float) -> void:
	trauma = clamp(trauma - delta, 0, 1)

func _physics_process(delta: float) -> void:
	time += delta
	var shake: float = _calc_shake.call()
	target.global_rotation_degrees = max_angle * shake * _get_noise(0) # TODO: make owner.angle_offset
	target.offset.x = max_offset * shake * _get_noise(1)
	target.offset.y = max_offset * shake * _get_noise(2)
	recover_from_trauma(delta)

func _calc_shake_squared() -> float:
	return trauma * trauma

func _calc_shake_cubed() -> float:
	return trauma * trauma * trauma

func _get_noise(seed: int) -> float:
	noise.seed = seed
	return noise.get_noise_1d(time * noise_speed)
	
# TODO: remove, for debugging
func _unhandled_key_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("ui_up")):
		apply_trauma(1.0)
	elif (Input.is_action_just_pressed("ui_down")):
		apply_trauma(0.75)
	elif (Input.is_action_just_pressed("ui_left")):
		apply_trauma(0.5)
	elif (Input.is_action_just_pressed("ui_right")):
		apply_trauma(0.25)
	elif (Input.is_action_just_pressed("ui_accept")):
		apply_trauma(0.1)
