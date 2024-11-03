class_name CameraManager extends Node

const GROUP: StringName = "CameraManager"

var noise: FastNoiseLite = FastNoiseLite.new()

func _ready() -> void:
	add_to_group(GROUP)

func shake(intensity: float, duration: float) -> void:
	var camera: Camera2D = get_viewport().get_camera_2d()
	if (camera == null):
		return
	var tween: Tween = create_tween()
	tween.tween_method(_apply_shake.bind(camera), intensity, 0, duration)
	camera.offset.x = 0
	camera.offset.y = 0
	
func _apply_shake(intensity: float, camera: Camera2D) -> void:
	var offset: float = noise.get_noise_1d(Time.get_ticks_msec()) * intensity
	camera.offset.x = offset
	camera.offset.y = offset

func zoom(amount: Vector2, tween_duration: float) -> void:
	var camera: Camera2D = get_viewport().get_camera_2d()
	if (camera == null):
		return
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(camera, "zoom", amount, tween_duration)
