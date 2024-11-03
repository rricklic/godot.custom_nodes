class_name World extends Node2D

@onready var player: Player = $Player

func _ready() -> void:
	for node: Node in get_tree().get_nodes_in_group(DramaticArea.GROUP):
		if (node is DramaticArea):
			(node as DramaticArea).disable()

func _physics_process(delta: float) -> void:
	# TODO: handle via signal
	if (player.health_component.health < 3):
		for node: Node in get_tree().get_nodes_in_group(DramaticArea.GROUP):
			if (node is DramaticArea):
				(node as DramaticArea).enable()
