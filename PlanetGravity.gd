extends StaticBody2D

@export var character: CharacterBody2D = null
@onready var raycast: RayCast2D = character.find_child("RayCast2D")
	
func _process(delta):
	# Update the raycast position relative to the character
	raycast.target_position = (self.position - character.position) # or use local position if needed
	raycast.force_raycast_update()
	#print("Raycast Position:", raycast.global_position)
	#print("Collision Point:", raycast.get_collision_point())
	#print("Collision Normal:", raycast.get_collision_normal())

	var normal_angle = raycast.get_collision_normal().angle() + PI/2
	character.transform = Transform2D(normal_angle, character.global_position)
	character.up_direction = character.transform.y
	character.force_update_transform()
