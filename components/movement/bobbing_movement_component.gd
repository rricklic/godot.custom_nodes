class_name BobbingMovementComponent extends Node

# Offset of owner is adjusted such that the node appears to bob up-and-down
# Uses: dropped items to appear floating, UI menu items

@export var amplitude: float = 20.0 ## pixels
@export var frequency: float = 1.5

var time: float = 0.0

func _physics_process(delta: float) -> void:
	time += delta * frequency
	owner.offset = Vector2(0, sin(time) * amplitude)
