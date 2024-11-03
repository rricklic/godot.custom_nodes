class_name ProjectileSpawnerComponent extends Node

@export var spawn_to_node: Node
@export var projectile_scene: PackedScene

func spawn() -> void:
	var projectile: Node = projectile_scene.instantiate()
	projectile.direction = owner.rotation
	projectile.global_position = owner.global_position
	projectile.global_rotation = owner.global.rotation
	# TODO: which is better...
	#spawn_to_node.add_child.call_deferred(projectile)
	spawn_to_node.call_deferred("add_child", projectile)
