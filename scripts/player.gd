extends CharacterBody3D
class_name Player

@onready var animations : AnimatedSprite3D = $AnimatedSprite3D
@onready var stateMachine : Node = $pStateMachine
@onready var springPivot : Node3D = $SpringArmPivot
@onready var healthComponent : HealthComponent = $HealthComponent
@onready var collectableComponent : CollectableComponent = $CollectableComponent
@onready var camera : Camera3D = $springPivot3D/Camera3D


@export var DEATH_STATE: pState 



func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	stateMachine.init(self)


func _unhandled_key_input(event):
	stateMachine.process_input(event)

func _physics_process(delta):
	stateMachine.process_physics(delta)
	
func _process(delta):
	stateMachine.process_frame(delta)

func die():
	stateMachine.change_state(DEATH_STATE)

##movimientos de cámara
var is_camera_moving : bool = false


func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)
	set_process_unhandled_key_input(active)

func pause_or_unpause_game(): ## MOVER ESTO A UN CONTROLADOR DE GUI QUE NO SE PUEDA PAUSAR (PORQUE EVIDENTEMENTE ESO CONGELA EL JUEGO, AL NO PODER PROCESAR INPUTS)
	var isPaused = get_tree().paused
	if isPaused:
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
