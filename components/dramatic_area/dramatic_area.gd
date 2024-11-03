class_name DramaticArea extends Area2D

const GROUP: StringName = "DramaticArea"

@export var slowmo_time_scale: float = 0.5
@export var time_scale_tween_duration: float = 0.1
@export var zoom_in_amount: Vector2 = Vector2(1.5, 1.5)
@export var zoom_tween_duration: float = 0.1

@onready var time_scale_component: TimeScaleComponent = $TimeScaleComponent
@onready var camera_component: CameraComponent = $CameraComponent
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	add_to_group(GROUP)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_area_entered(area: Area2D) -> void:
	time_scale_component.set_time_scale(slowmo_time_scale, time_scale_tween_duration)
	camera_component.zoom2(area, zoom_in_amount, zoom_tween_duration)
	
func _on_area_exited(area: Area2D) -> void:
	time_scale_component.set_time_scale(1.0, time_scale_tween_duration)
	camera_component.zoom2(area, Vector2.ONE, zoom_tween_duration)

func _on_body_entered(body: Node2D) -> void:
	time_scale_component.set_time_scale(slowmo_time_scale, time_scale_tween_duration)
	camera_component.zoom2(body, zoom_in_amount, zoom_tween_duration)
	
func _on_body_exited(body: Node2D) -> void:
	time_scale_component.set_time_scale(1.0, time_scale_tween_duration)
	camera_component.zoom2(body, Vector2.ONE, zoom_tween_duration)

func disable() -> void:
	collision_shape_2d.disabled = true
	
func enable() -> void:
	collision_shape_2d.disabled = false
