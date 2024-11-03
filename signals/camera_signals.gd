class_name CameraSignals extends RefCounted

signal screen_shake

static func signal_screen_shake() -> void:
	screen_shake.emit()
