extends Enemy
class_name TestEnemy

@onready var attack_range = $AttackRange

var attack_target : HitboxComponent
var attack_timer = 0.5
@onready var cooldown_timer = $CooldownTimer
@onready var attack = $Attack
var attackBall = preload("res://scenes/attack_ball.tscn")


func summon_attack(state : eState):
	await get_tree().create_timer(attack_timer).timeout
	var attackBallInstance = attackBall.instantiate()
	add_child(attackBallInstance)
	attackBallInstance.global_position = attack_range.global_position
	await get_tree().create_timer(1).timeout
	attackBallInstance.queue_free()
	cooldown_timer.start()
	state_machine.change_state(state)


func die():
	self.queue_free()
