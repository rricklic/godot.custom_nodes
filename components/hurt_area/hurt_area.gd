class_name HurtArea extends Area2D

#
# Area that receives signals from HitAreas and emits the effect (damage, freeze,
# poision, etc...)
#

signal signal_hurt_area_entered

@export var faction: HitArea.Faction

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)

# TODO: instead of conditionals, control with collision layer/mask
func _on_area_entered(hit_area: HitArea) -> void:
	if (hit_area == null || hit_area.effect == null):
		return

	if (faction == HitArea.Faction.NONE || faction != hit_area.faction):
		signal_hurt_area_entered.emit(hit_area.effect)

func disable(duration: float = 0) -> void:
	collision_shape_2d.disabled = true
	if (duration > 0):
		get_tree().create_timer(duration).timeout.connect(enable)

func enable() -> void:
	collision_shape_2d.disabled = false
