class_name HitAreaEffect extends Resource

enum Type {
	DAMAGE,
	POISION,
	STUN
}

@export var type: Type
@export var amount: int
@export var duration: float = -1.0
