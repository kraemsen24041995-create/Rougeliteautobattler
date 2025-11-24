extends CharacterBody2D

@export var max_health: int = 10
@export var attack_damage: int = 2
@export var attack_speed: float = 1.0   # Attack alle x Sekunden

var current_health: int
var attack_timer: float = 0.0
@export var target: Node = null

func _process(delta):
	if not target:
		return

	var dist = distance_to_target()

	if dist > attack_range:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()
		return

	velocity = Vector2.ZERO

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
func distance_to_target() -> float:
	if target:
		return global_position.distance_to(target.global_position)
	return INF

@export var attack_range: float = 100.0   # Reichweite in Pixel
@export var move_speed: float = 80.0      # Bewegungsgeschwindigkeit
