extends CharacterBody2D

@export var max_health: int = 10
@export var attack_damage: int = 2
@export var attack_speed: float = 1.0   # Attack alle x Sekunden

var current_health: int
var attack_timer: float = 0.0
var target: Node = null


func _ready():
	current_health = max_health


func _process(delta):
	if target:
		attack_timer -= delta
		if attack_timer <= 0.0:
			attack_timer = attack_speed
			attack()


func attack():
	if target and target.has_method("take_damage"):
		target.take_damage(attack_damage)


func take_damage(amount: int):
	current_health -= amount
	print(name, "has", current_health, "HP left")

	if current_health <= 0:
		die()


func die():
	queue_free()
