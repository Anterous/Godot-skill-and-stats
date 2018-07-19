extends "res://character.gd"

var motion = Vector2()
export(int) var health = 100
const MOTION_SPEED = 1000 # Pixels/second
var x 


func _ready():
	x = 0
	$ChangeDir.start()

func _on_Player_damage_taken(damage):
	health = health -damage
	if health == 0:
		print("dead")
		_kill()
	print(health)

func _physics_process(delta):
	move_and_slide(motion)

func _on_change_dir():
	motion = Vector2(x,0)
	motion = motion.normalized() * MOTION_SPEED

func _kill():
	self.queue_free()


func _on_ChangeDir_timeout():
	if x == 1 || x == 0:
		x = -1
		_on_change_dir()
	elif x == -1:
		x = 1
		_on_change_dir()
