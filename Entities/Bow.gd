extends Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	look_at(get_global_mouse_position())
	var current_rotation = self.get_rotation()
	var rotation = clamp(current_rotation, -1, 0)
	self.set_rotation(rotation)
