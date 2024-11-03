class_name ProjectileSpawner extends Node2D

@export var texture: Texture
@export var spawn_to_node: Node
@export var projectile_scene: PackedScene
@export var max_rotational_offset: float = 0.025
@onready var spawn_point: Marker2D = $SpawnPoint

# TODO: export resource
var kickback: float
var kickback_recovery: float

func _ready() -> void:
	get_tree().create_timer(0.25).timeout.connect(_on_timer_timeout)

func spawn() -> void:
	var projectile: Node = projectile_scene.instantiate()
	projectile.global_position = spawn_point.global_position
	projectile.global_rotation = global_rotation + randf_range(-max_rotational_offset, max_rotational_offset)
	projectile.z_index = z_index -1
	# TODO: which is better...
	#spawn_to_node.add_child.call_deferred(projectile)
	spawn_to_node.call_deferred("add_child", projectile)

func _on_timer_timeout() -> void:
	spawn()
	get_tree().create_timer(0.25).timeout.connect(_on_timer_timeout)
