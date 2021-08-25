extends RigidBody2D

var self_destruction_seconds = 4
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	SelfDestruct()

func _process(delta):
	velocity = get_linear_velocity()
	rotation = (atan2(velocity.x, velocity.y))
	var bodies = get_colliding_bodies()
	if (!bodies.empty()):
		if (bodies[0] is TileMap):
			print ("Body collided")
			sleeping = true
	
func SelfDestruct():
	yield(get_tree().create_timer(self_destruction_seconds), "timeout")
	queue_free()
