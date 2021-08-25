extends Area2D

var self_destruction_seconds = 4
var velocity = Vector2()
export (Vector2) var speed
export var mass = 10.0
var stuck = false

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = speed
	SelfDestruct()

func _process(delta):
	if (!stuck):
		velocity += gravity_vec*gravity*mass*delta
		position += velocity*delta
		rotation = velocity.angle()
	
func SelfDestruct():
	yield(get_tree().create_timer(self_destruction_seconds), "timeout")
	queue_free()


func _on_Arrow_body_entered(body):
	rotation = velocity.angle()
	print(rotation)
	velocity= Vector2()
	mass = 0
	stuck = true
