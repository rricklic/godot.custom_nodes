class_name MainMenu extends CenterContainer

@onready var panel_container: PanelContainer = %PanelContainer
@onready var title: Label = %Title
@onready var start_button: Button = %StartButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton
@onready var high_score: Label = %HighScore
@onready var high_score_value: Label = %HighScoreValue


# https://www.youtube.com/watch?v=jF3UgstQ1Yk

# UI juice
# XXXX fall into place
# XXXX tally up value
# XXXX rotate and scale
# shake/bounce
# XXXX move pivot to center
# XXXX hover scale
# XXXX slide on/off screen

func _ready() -> void:
	start_button.mouse_entered.connect(_on_mouse_entered.bind(start_button))
	start_button.mouse_exited.connect(_on_mouse_exited.bind(start_button))
	start_button.pressed.connect(_on_start_button_pressed)
	
	options_button.mouse_entered.connect(_on_mouse_entered.bind(options_button))
	options_button.mouse_exited.connect(_on_mouse_exited.bind(options_button))
	options_button.pressed.connect(_on_options_button_pressed)
	
	quit_button.mouse_entered.connect(_on_mouse_entered.bind(quit_button))
	quit_button.mouse_exited.connect(_on_mouse_exited.bind(quit_button))
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	_set_pivot_center.call_deferred() # NOTE: call_defered so that all nodes are loaded

func _set_pivot_center() -> void:
	# Need to wait one frame to set scale otherwize panel will reset to Vector2.ZERO
	await get_tree().process_frame

	# NOTE: pivot_offset cannot be set in editor only in code after the nodes have loaded
	title.pivot_offset = title.size / 2.0
	start_button.pivot_offset = start_button.size / 2.0
	options_button.pivot_offset = options_button.size / 2.0
	quit_button.pivot_offset = quit_button.size / 2.0
	panel_container.pivot_offset = panel_container.size / 2.0
	
	start_button.scale = Vector2.ZERO
	options_button.scale = Vector2.ZERO
	quit_button.scale = Vector2.ZERO
	
	high_score.visible = false
	
	var duration: float = 0.5

	await _bound_in_panel()
	_rotate_pulse_title(duration)
	await _scale_in_buttons(duration)
	_tally_high_score()

func _bound_in_panel() -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(panel_container, "position", panel_container.position, 1.5).from(panel_container.position + Vector2(0, -1000))
	await tween.finished
	
func _rotate_pulse_title(duration: float) -> void:
	# Rotate title
	var ease_type: Tween.EaseType = Tween.EASE_IN_OUT
	var trans_type: Tween.TransitionType = Tween.TRANS_SINE

	var tween: Tween = create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(trans_type)
	tween.tween_property(title, "rotation_degrees", 10, duration)
	tween.tween_property(title, "rotation_degrees", 0, duration)
	tween.tween_property(title, "rotation_degrees", -10, duration)
	tween.tween_property(title, "rotation_degrees", 0, duration)
	tween.set_loops(-1)

	# Pulse scale title
	var tween2: Tween = create_tween()
	tween2.set_ease(ease_type)
	tween2.set_trans(trans_type)
	tween2.tween_property(title, "scale", Vector2(1.5, 1.5), duration)
	tween2.tween_property(title, "scale", Vector2(1, 1), duration)
	tween2.set_loops(-1)
	
func _scale_in_buttons(duration: float) -> void:
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EaseType.EASE_OUT)
	tween.set_trans(Tween.TransitionType.TRANS_SPRING)
	tween.tween_property(start_button, "scale", Vector2.ONE, duration)
	tween.tween_property(options_button, "scale", Vector2.ONE, duration)
	tween.tween_property(quit_button, "scale", Vector2.ONE, duration)
	await tween.finished

# TODO: when a label is resized, the Control node seems to reset the 
#       scale/rotation of child Control nodes... how to prevent?
func _tally_high_score() -> void:
	# TODO: animated tally node
	high_score.visible = true
	var tween: Tween = create_tween()
	tween.tween_method(_set_label.bind(high_score_value), 0, 1213124, 3.0)
	await tween.finished

	high_score_value.pivot_offset = high_score_value.size / 2.0

	var tween2: Tween = create_tween()
	tween2.set_parallel(true)
	tween2.set_ease(Tween.EaseType.EASE_IN_OUT)
	tween2.set_trans(Tween.TransitionType.TRANS_SINE)
	tween2.tween_property(high_score_value, "scale", Vector2(1.5, 1.5), 0.25)
	#tween2.tween_property(high_score, "scale", Vector2(1.5, 1.5), 0.25)
	await tween2.finished

	var tween3: Tween = create_tween()
	tween3.set_parallel(true)
	tween3.set_ease(Tween.EaseType.EASE_IN_OUT)
	tween3.set_trans(Tween.TransitionType.TRANS_SINE)	
	tween3.tween_property(high_score_value, "scale", Vector2.ONE, 0.25)
	#tween3.tween_property(high_score, "scale", Vector2.ONE, 0.25)

func _set_label(value: int, label: Label) -> void:
	label.text = str(value)

func _on_mouse_entered(button: Button) -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(button, "scale", Vector2(1.5, 1.5), 0.5)

func _on_mouse_exited(button: Button) -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.5)
	
func _on_start_button_pressed() -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(panel_container, "position", panel_container.position + Vector2(1000, 0), 1.0)
	await tween.finished
	
func _on_options_button_pressed() -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(panel_container, "scale", Vector2(50, 50), 1.0)
	await tween.finished

func _on_quit_button_pressed() -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(panel_container, "position", panel_container.position + Vector2(0, 1000), 1.0)
	await tween.finished
