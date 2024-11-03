class_name Player extends CharacterBody2D

const SPEED = 300.0

@export var projectile_scene: PackedScene = preload("res://scenes/projectile/projectile.tscn")

@onready var camera_component: CameraComponent = $CameraComponent
@onready var time_scale_component: TimeScaleComponent = $TimeScaleComponent
@onready var shader_component: ShaderComponent = $ShaderComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var movement_component: TopDownMovementComponent = $TopDownMovementComponent

@onready var hurt_area: HurtArea = $HurtArea
@onready var camera_2d: Camera2D = $Camera2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	hurt_area.signal_hurt_area_entered.connect(_handle_hurt_area_entered)
	health_component.signal_no_health.connect(_handle_no_health)

func _physics_process(delta: float) -> void:
	pass
"""
	var direction: float = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if (Input.is_action_just_pressed("player_projectile")):
		var node: Node = projectile_scene.instantiate()
		add_child(node)     
		(node as Projectile).hit_area.faction = HitArea.Faction.PLAYER

	move_and_slide()
"""	

func _handle_damage(damage: float) -> void:
	print("Take " + str(damage) + " damage")
	health_component.add(-damage)
	
	time_scale_component.apply_hit_stop(0.1)
	camera_component.shake(50.0, 0.5)
	shader_component.apply(sprite_2d, Color.WHITE)
	
func _handle_stun(duration: float) -> void:
	shader_component.apply(sprite_2d, Color.DIM_GRAY)
	movement_component.set_physics_process(false)
	await get_tree().create_timer(duration, true, false, true).timeout
	movement_component.set_physics_process(true)

func _handle_hurt_area_entered(effect: HitAreaEffect) -> void:
	if (effect.type == HitAreaEffect.Type.DAMAGE):
		_handle_damage(effect.amount)
	if (effect.type == HitAreaEffect.Type.STUN):
		_handle_stun(effect.duration)
		
func _handle_no_health() -> void:
	queue_free()
