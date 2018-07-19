extends KinematicBody2D

signal state_changed
signal damage_taken

var input_direction = Vector2()
var look_direction = Vector2(1, 0)
var last_move_direction = Vector2(1, 0)


enum STATES { IDLE, ATTACK }
var state = null

export(String) var weapon_scene_path = 'res://Wepon/Sword.tscn'
var weapon = null


func _ready():
	_change_state(IDLE)

	if not weapon_scene_path:
		return
	var weapon_instance = load(weapon_scene_path).instance()

	$Body/WeaponSpawnPoint.add_child(weapon_instance)
	weapon = $Body/WeaponSpawnPoint.get_child(0)
	weapon.connect("attack_finished", self, "_on_Weapon_attack_finished")
	weapon.connect("damage_given", self, "_on_damage_given")

func _change_state(new_state):
	# Prevent player from changing direction
	match state:
		ATTACK:
			set_physics_process(true)

	# Initialize the new state
	match new_state:
		IDLE:
			$AnimationPlayer.play('Idle')
		ATTACK:
			set_physics_process(false)
			if not weapon:
				print("%s tries to attack but has no weapon" % get_name())
				_change_state(IDLE)
				return

			weapon.attack()
			$AnimationPlayer.play('Idle')
	state = new_state
	emit_signal('state_changed', new_state)


func _on_damage_given(damage):
	emit_signal('damage_taken', damage)

func _on_Weapon_attack_finished():
	_change_state(IDLE)