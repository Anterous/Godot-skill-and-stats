extends "res://character.gd"

# Member variables
const MOTION_SPEED = 160 # Pixels/second
signal enemy_hit
export(int) var health = 100


func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("move_bottom"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-1, 0)
		$Body.set_scale(Vector2(-0.6, 0.6))
		if $Body.scale == Vector2(-0.6,0.6):
			pass#print("Katse vasempaan")
	if Input.is_action_pressed("move_right"):
		motion += Vector2(1, 0)
		$Body.set_scale(Vector2(0.6,0.6))
		if $Body.scale == Vector2(0.6,0.6):
			pass#print("katse oikeaan")
	if Input.is_action_pressed("attack"):
		_change_state(ATTACK)
	
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)


func _on_NewEnemy_damage_taken(damage):
	health = health - (damage)
	print(health)
	if health == 0:
		self.queue_free()















