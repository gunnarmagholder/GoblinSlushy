extends RigidBody2D

var self_destruction_seconds = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	SelfDestruct()

func _process(delta):
	var velocity = get_linear_velocity()
	rotation = atan2(velocity.x, velocity.y)
	print(rotation)

func SelfDestruct():
	yield(get_tree().create_timer(self_destruction_seconds), "timeout")
	queue_free()
