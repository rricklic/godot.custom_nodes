class_name WigglePolygon extends Polygon2D

@export var max_offset: int = 10
@export var duration: float = 0.1

var points: PackedVector2Array = []

@onready var timer: Timer = $Timer

func _ready() -> void:
	points = polygon.duplicate()
	timer.timeout.connect(_on_timeout)
	timer.start(duration)

func _on_timeout() -> void:
	var new_polygon: PackedVector2Array = []
	for point: Vector2 in points:
		new_polygon.push_back(Vector2(
			point.x + randi_range(-max_offset, max_offset),
			point.y + randi_range(-max_offset, max_offset)))
	var tween: Tween = create_tween()
	tween.tween_property(self, "polygon", new_polygon, duration)
