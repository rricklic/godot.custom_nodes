class_name GrowMovementComponent extends Node

@export var duration: float = 0.5
@export var delay: float = 0.0
@export var ease_type: Tween.EaseType = Tween.EaseType.EASE_OUT
@export var transition_type: Tween.TransitionType = Tween.TransitionType.TRANS_SPRING

func _ready() -> void:
	owner.scale = Vector2(0, 0)
	get_tree().create_timer(delay).timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	var tween: Tween = create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(transition_type)
	tween.tween_property(owner, "scale", Vector2.ONE, duration)
