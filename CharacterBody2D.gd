extends CharacterBody2D

var speed = 250
var jump_speed = -800
var dampening_x = -60

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = 500

func _physics_process(delta):
	# walk dampening
	if abs(velocity.x) > 0:
		velocity.x += sign(velocity.x) * dampening_x * delta
		
	# gravity
	velocity += self.transform.y * gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		velocity = self.transform.y * jump_speed

	# Get the input direction.
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		velocity = self.transform.x * sign(direction) * speed
	move_and_slide()
