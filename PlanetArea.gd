extends Area2D

var character: CharacterBody2D = null

func _ready():
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func _physics_process(delta):
	if character == null:
		return
		
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(character.global_position, self.global_position)
	query.exclude = [character]
	var result = space_state.intersect_ray(query)
	
	if result.get("collider"):
		var normal_angle = result.get("normal").angle() + PI/2
		# update the transform to be oriented towards the normal angle, have the original scale, and be at the original world position
		character.transform = Transform2D(normal_angle, character.transform.get_scale(), 0, character.global_position)
		character.up_direction = -character.transform.y
		character.force_update_transform()

func on_body_entered(body):
	if body is CharacterBody2D:
		character = body

func on_body_exited(body):
	if body is CharacterBody2D:
		character = null
