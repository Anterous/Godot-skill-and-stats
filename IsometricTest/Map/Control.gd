extends Control

onready var skilltree_scene = preload("res://SkillTree/Main.tscn")
var skilltree_location = Vector2(0,0)
var skilltree
var statscreen_active = false

func _open_skilltree():
	skilltree = skilltree_scene.instance()
	add_child(skilltree)
	skilltree.show()
	skilltree.rect_global_position = get_node("../walls/Player").position + Vector2(-500,-400)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_P:
			if statscreen_active == false:
				_open_skilltree()
				statscreen_active = true
			elif statscreen_active == true:
				for i in get_children():
					i.queue_free()
				statscreen_active = false

