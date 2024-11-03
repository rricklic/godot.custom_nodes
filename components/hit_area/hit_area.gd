class_name HitArea extends Area2D

#
# Area that causes effects to be detected by HurtAreas
#

enum Faction {
	NONE,
	PLAYER,
	ENEMY
}

@export var faction: Faction
@export var effect: HitAreaEffect

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func disable(duration: float = 0) -> void:
	collision_shape_2d.disabled = true
	if (duration > 0):
		get_tree().create_timer(duration).timeout.connect(enable)

func enable() -> void:
	collision_shape_2d.disabled = false
