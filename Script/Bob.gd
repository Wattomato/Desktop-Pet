extends CharacterBody2D
@onready var time: Timer = $Timer
@onready var animation: AnimationPlayer = $AnimationPlayer
const SPEED = 10000.0
const JUMP_VELOCITY = -400.0
var dropping: bool = true
var moving: bool = false
var dir: int = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var counter: int = 0
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
func _ready():
	randomize()
func _physics_process(delta):
	# Add the gravity.
	if dropping && counter<20:
		animation.play("Bob_in_Bubble")
		velocity.y= 400
		velocity.x= 200
		if(counter==19):
			velocity.y= -200
			velocity.x= 200
			counter+=1
			await get_tree().create_timer(0.2).timeout
			counter = -1
		counter+=1
		if is_on_floor():
			dropping=false
			velocity.y = 0
			velocity.x = 0
			animation.play("Iddle")
	if moving:
		var temp: Vector2 = (Vector2(counter, global_position.y)-global_position).normalized()
		velocity = temp * SPEED * delta
		animation.play("Walk")
		if dir != temp.x:
			moving = false
			velocity.x = 0
			animation.play("Iddle")
			time.start(rng.randi_range(1, 5))
		else:
			if temp.x < 0:
				$Sprite2D.flip_h = true
			if temp.x > 0:
				$Sprite2D.flip_h = false
		


	move_and_slide()


func _on_timer_timeout()->void:
	counter = rng.randi_range(100, 1800)
	moving = true
	dir = ((Vector2(counter, global_position.y)-global_position).normalized()).x
func _walk()->void:
	pass
