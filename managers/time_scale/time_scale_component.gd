class_name TimeScaleComponent extends Node

func set_time_scale(time_scale: float, tween_duration: float) -> void:
	for node: Node in get_tree().get_nodes_in_group(TimeScaleManager.GROUP):
		if (node is TimeScaleManager):
			(node as TimeScaleManager).set_time_scale(time_scale, tween_duration)

func apply_hit_stop(duration: float) -> void:
	for node: Node in get_tree().get_nodes_in_group(TimeScaleManager.GROUP):
		if (node is TimeScaleManager):
			(node as TimeScaleManager).apply_hit_stop(duration)
