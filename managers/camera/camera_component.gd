class_name CameraComponent extends Node

func shake(intensity: float, duration: float) -> void:
	for node: Node in get_tree().get_nodes_in_group(CameraManager.GROUP):
		if (node is CameraManager):
			(node as CameraManager).shake(intensity, duration)

func zoom(amount: Vector2, tween_duration: float) -> void:
	for node: Node in get_tree().get_nodes_in_group(CameraManager.GROUP):
		if (node is CameraManager):
			(node as CameraManager).zoom(amount, tween_duration)
			
func zoom2(node2d: Node2D, amount: Vector2, tween_duration: float) -> void:
	get_viewport().get_camera_2d().global_position = node2d.global_position
	for node: Node in get_tree().get_nodes_in_group(CameraManager.GROUP):
		if (node is CameraManager):
			(node as CameraManager).zoom(amount, tween_duration)
