extends Node2D

onready var skilltree_scene = preload("res://SkillTree/Main.tscn")
var skilltree_location = Vector2(0,0)

func _ready():
	_open_skilltree()

func _open_skilltree():
	var skilltree = skilltree_scene.instance()
	add_child(skilltree)
	skilltree.show()

