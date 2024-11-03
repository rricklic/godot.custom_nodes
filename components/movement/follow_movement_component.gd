class_name FollowMovementController extends Node

enum FollowMode {
	SNAP
}

@export var target: Node2D
@export var follow_mode: FollowMode = FollowMode.SNAP

func _ready() -> void:
	process_priority = 1

func _physics_process(delta: float) -> void:
	if (target):
		owner.global_position = target.global_position
		print("follow:" + str(owner.global_position))
