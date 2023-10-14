extends StaticBody2D

@export var character: CharacterBody2D = null
@onready var raycast: RayCast2D = character.find_child("RayCast2D")

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(character.global_position, self.global_position)
	query.exclude = [character.find_child("CollisionShape")]
	var result = space_state.intersect_ray(query)

	#print("Raycast Position:", raycast.global_position)
	#print("Collision Point:", raycast.get_collision_point())
	#print("Collision Normal:", raycast.get_collision_normal()
	
	if result.get("collider"):
		var normal_angle = result.get("normal").angle() + PI/2
		character.transform = Transform2D(normal_angle, character.global_position)
		character.up_direction = character.transform.y
		character.force_update_transform()
