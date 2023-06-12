extends AnimatableBody2D
var c 
var coll = 1
@export var velocity = Vector2(0,0)
var rng = RandomNumberGenerator.new()
var prev = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	iterate()

	if c ==1:
		$Platform.modulate = Color(0,0,1)
	if c ==2:
		$Platform.modulate = Color(1,0,0)
	if c ==3:
		$Platform.modulate = Color(1,1,0)

func physics_process(delta):
	pass
	#var Bodies = $Platform.get_overlapping_bodies()
	#for b in Bodies:
		#if b.name == "Player":
		#    coll=true
		#else:
		#    coll=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func setc(val:int):
	coll=val
func _process(delta):
	#print(coll)
	set_collision_layer(coll)
	set_collision_mask(coll)
	var viewport_rect = get_viewport_rect()

	#if position.x > -viewport_rect.size.x:
		#$Platform.position.x -= 100*delta

		#position = Vector2(450, -30)
		#$PlatformS.position = Vector2(450, -30)
# func changeX():
#    position.x+=10
func getC() -> int:
	return c
func iterate():
	c = rng.randi_range(1,3)
	if c == prev:
		c = rng.randi_range(1,3)
		iterate()
	else:
		prev = c
