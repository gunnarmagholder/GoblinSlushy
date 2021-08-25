extends KinematicBody2D

export var aim_rotation = 0
export var arrow_speed = 0
export var arrow_rate = 0.6

const GRAVITY = 200.0
var arrow = preload("res://Entities/Arrow.tscn")
var can_fire = true
var velocity = Vector2.ZERO
export (int) var speed = 800
export (int) var jump_speed = -180
export (int) var gravity = 400

func _ready():
	$ShotReady.visible = false

func _physics_process(delta):
	process_keys(delta)
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)

func process_keys(delta):
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_pressed("Jump"):
		if is_on_floor():
			velocity.y = jump_speed
	if Input.is_action_pressed("shoot"):
		arrow_speed += 10
		if arrow_speed > 1000:
			arrow_speed = 1000
			$ShotReady.visible = true
		$ShootForce.rect_size.x = arrow_speed / 10
			
	if Input.is_action_just_released("shoot") and can_fire:
		can_fire = false
		var arrow_instance = arrow.instance()
		arrow_instance.position = $Bow/ShootingPoint.get_global_position()
		arrow_instance.apply_impulse(Vector2(), Vector2(arrow_speed, 0).rotated($Bow.rotation))
		arrow_instance.transform = $Bow/ShootingPoint.get_global_transform()
		get_tree().get_root().add_child(arrow_instance)
		yield(get_tree().create_timer(arrow_rate), "timeout")
		can_fire = true
		arrow_speed = 0
		$ShootForce.rect_size.x = 0
		$ShotReady.visible = false
		
