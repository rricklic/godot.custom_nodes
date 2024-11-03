class_name HealthComponent extends Node

signal signal_no_health

@export var health: int = 100
@export var max_health: int = 100

func add(amount: int) -> void:
	health = clamp(health + amount, 0, max_health)
	if (health == 0):
		signal_no_health.emit()
