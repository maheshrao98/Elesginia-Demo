extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 500
const FRICTION = 500

var velocity = Vector2.ZERO

#set the animation player in ready so that you can be sure it is loaded the moment the player node done loading
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

#runs every time the frame rate is being run
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#make sure diagonal movements doesn't make the player move faster than moving in single direction
	input_vector = input_vector.normalized()
	
	# player movement based on time which doesn't match the frame rate of the computer
	# so, by multiplying with delta we match player movement speed with frame rate
	# so, no matter if  a computer runs 0n 30 FPS or 60 FPS, the player movement remains smooth
	if input_vector != Vector2.ZERO:
		#setting blend position for player move so player face the position the player stop running when they go idle instead of alwyas facing one position
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		#setting player to run when movment input is pressed
		animationState.travel("Run")
		# To avoid from velocity exceeding MAX SPEED when running
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		#setting player to stay idle when movment input is not pressed
		animationState.travel("Idle")
		# set friction to player movement to avoid player movement look like ice skating when coming to stop running
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
	
	#the player will move and also collide with collision shapes and move smoothly at the edges of the collision shapes
	velocity = move_and_slide(velocity)
