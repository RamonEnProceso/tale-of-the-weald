extends Camera3D

@export var SPRING_ARM : Node3D
@export var LERP_POWER : float = 1.0

func _process(delta : float) -> void:
	position = lerp(position, SPRING_ARM.position, delta*LERP_POWER)
