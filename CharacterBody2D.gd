extends CharacterBody2D

var speed = 700
var jump_speed = -450.0

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = 400


func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity += self.transform.y * gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"): #and is_on_floor():
		velocity = self.transform.y * jump_speed

	# Get the input direction.
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		velocity = self.transform.x * 150
	move_and_slide()
