extends CharacterBody3D
class_name Player

@onready var animations : AnimatedSprite3D = $AnimatedSprite3D
@onready var stateMachine : Node = $pStateMachine
@onready var springPivot : Node3D = $SpringArmPivot
@onready var healthComponent : HealthComponent = $HealthComponent
@onready var collectableComponent : CollectableComponent = $CollectableComponent
@onready var camera : Camera3D = $springPivot3D/Camera3D

@onready var shadow_ray = $ShadowRay
@onready var shadow_decal : Decal = $ShadowDecal

@export var DEATH_STATE: pState 



func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	stateMachine.init(self)


func _unhandled_key_input(event):
	stateMachine.process_input(event)

func update_shadow_logic():
	shadow_ray.force_shapecast_update()
	
	shadow_ray.force_shapecast_update()
	
	if shadow_ray.is_colliding():
		shadow_decal.visible = true
		
		var collision_point = shadow_ray.get_collision_point(0)
		
		shadow_decal.global_position.y = collision_point.y + 0.1
		
		var distance = global_position.y - collision_point.y
		shadow_decal.albedo_mix = lerp(1.0, 0.0, clamp(distance / 10.0, 0.0, 1.0))
		
		var target_size = lerp(1.5, 0.5, clamp(distance / 10.0, 0.0, 1.0))
		shadow_decal.size.x = target_size
		shadow_decal.size.z = target_size
	else:
		shadow_decal.visible = false

func _physics_process(delta):
	stateMachine.process_physics(delta)
	
	#Actualiza la sombra del PJ
	update_shadow_logic()

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
