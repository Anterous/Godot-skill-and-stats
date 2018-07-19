extends Area2D

export(int) var damage = 1
signal attack_finished
signal damage_given

enum STATES {IDLE, ATTACK}
var state = null


func _change_state(new_state):
	match new_state:
		IDLE:
			set_physics_process(false)
			$AnimationPlayer.play('idle')
		ATTACK:
			set_physics_process(true)
			$AnimationPlayer.play('Attack')
	state = new_state

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		"""body.has_node("Health") and not""" 
		if !body.is_a_parent_of(self):
			print("you got rekt mate")
			$HitTimer.start()
			emit_signal("damage_given", damage)
			$CollisionPolygon2D.disabled = true
			#body.queue_free()

func attack():
	_change_state(ATTACK)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'idle':
		return
	_change_state(IDLE)
	emit_signal("attack_finished")


func _on_HitTimer_timeout():
	$CollisionPolygon2D.disabled = false
