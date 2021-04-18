extends KinematicBody2D

onready var player = null
var speed = 100
var motion = Vector2()
var distanceToAttack = 200

# npc get player position
func _ready():
	player = get_parent().get_parent().get_node("Player")
	
func stay():
	player = null
	
#func follow(speed,deltaTime):
	#var MoveVector = (player.position - position)
	#var Velocity = speed * deltaTime
	#motion = MoveVector * Velocity
	
	#if position.distance_to(player.position) <= distanceToAttack:
		#look_at(player.global_position)
		#move_and_slide(motion)
		
func Talk():
	pass
	
func _process(delta):
	#follow(speed, delta)
	pass
	
func is_NPC():
	print("hi")
