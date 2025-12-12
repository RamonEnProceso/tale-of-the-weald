extends Node3D

class_name DialogueComponent

@export var RANGE : float
@export var CHARACTER_ID : String
@export var DIALOGUE_START_ID : String
@onready var enterDialogueRange = $EnterDialogueRange/CollisionShape3D

var dialogue
var playerIsInDialogueRange : bool = false


func _ready():
	dialogue = get_node_or_null("Dialogue")
	enterDialogueRange.shape.radius = RANGE

func _input(event):
	if Input.is_action_just_pressed("game_interact") and playerIsInDialogueRange and dialogue.player.is_on_floor():
		dialogue.player.velocity.x = 0
		dialogue.player.velocity.z = 0
		dialogue.player.stateMachine.change_state(dialogue.player.stateMachine.INITIAL_STATE)
		find_and_play_dialogue()

func _on_enter_dialogue_range_body_entered(body):
	if body is Player:
		playerIsInDialogueRange = true
	return

func _on_enter_dialogue_range_body_exited(body):
	if body is Player:
		playerIsInDialogueRange = false
	return

func find_and_play_dialogue():

	if dialogue and !dialogue.isDialogueActive:
		dialogue.play_from(DIALOGUE_START_ID)
