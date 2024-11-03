class_name Projectile extends Node2D

@export var texture: Texture2D
@export var damage_amount: int = 100
@export var speed: float = 500

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hit_area: HitArea = $HitArea
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	sprite_2d.texture = texture
	hit_area.effect = HitAreaEffect.new()
	hit_area.effect.type = HitAreaEffect.Type.DAMAGE
	hit_area.effect.amount = damage_amount
	
	visible_on_screen_notifier_2d.screen_exited.connect(_on_screen_exited)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_screen_exited() -> void:
	queue_free()
