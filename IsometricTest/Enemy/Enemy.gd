extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
var MOTION_SPEED = 5
var motion = Vector2()
var health = 100

export(String) var char_scene_path = 'res://character.tscn'

func _ready():
	var char_instance = load(char_scene_path).instance()
	char_instance.connect("damage_taken", self, "_on_take_damage")


func _on_take_damage(damage):
	health = health - damage
	print ("LCD")


