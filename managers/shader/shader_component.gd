class_name ShaderComponent extends Node

func apply(target_node: Node, color: Color) -> void:
	for node: Node in get_tree().get_nodes_in_group(ShaderManager.GROUP):
		if (node is ShaderManager):
			(node as ShaderManager).apply(target_node, color)
