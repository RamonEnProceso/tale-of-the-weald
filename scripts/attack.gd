extends Node
class_name Attack

@export var ATTACK_DAMAGE : float = 1


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent() is Enemy:
		area.damage(self)
