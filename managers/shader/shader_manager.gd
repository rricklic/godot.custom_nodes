class_name ShaderManager extends Node

const GROUP: StringName = "ShaderManager"

#@export var color: Color = Color.WHITE
@export var duration: float = 1.0
@export var shader: Shader

func _ready() -> void:
	add_to_group(GROUP)

func apply(node: Node2D, color: Color) -> void:
	var shader_material: ShaderMaterial = _create_shader_material()
	shader_material.set_shader_parameter("flash_color", color)
	
	node.material = shader_material
	
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(_set_shader_parameter.bind(shader_material, "flash_amount"), 1.0, 0.0, duration)
	await tween.finished
	
	node.material = null

func _create_shader_material() -> ShaderMaterial:
	var shader_material: ShaderMaterial = ShaderMaterial.new()
	shader_material.shader = shader
	shader_material.resource_local_to_scene = true
	return shader_material;

func _set_shader_parameter(value: Variant, shader_material: ShaderMaterial, param: StringName) -> void:
	shader_material.set_shader_parameter(param, value)
