extends Control

@onready
var spectrum = AudioServer.get_bus_effect_instance(1,0)

@onready
var TopRightArray = $mplayer/background/Right/Top.get_children()

@onready
var BottomRightArray = $mplayer/background/Right/Bottom.get_children()

@onready
var TopLeftArray = $mplayer/background/Left/Top.get_children()

@onready
var BottomLeftArray = $mplayer/background/Left/Bottom.get_children()

const VU_COUNT = 16
const HEIGHT = 500
const FREQ_MAX = 60.0

const MIN_DB = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	TopLeftArray.reverse()
	BottomRightArray.reverse()


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	
	var prev_hz = 0
	for i in range(1,VU_COUNT+1):   
		var hz = i * FREQ_MAX / VU_COUNT;
		var f = spectrum.get_magnitude_for_frequency_range(prev_hz,hz)
		var energy = clamp((MIN_DB + linear_to_db(f.length()))/MIN_DB,0,1)
		var height = energy * HEIGHT
		
		prev_hz = hz
		
		var BottomRightRect = BottomRightArray[i - 1]
		
		var TopRightRect = TopRightArray[i - 1]

		var TopLeftRect = TopLeftArray[i - 1]

		var BottomLeftRect = BottomLeftArray[i - 1]
		
		var tween = get_tree().create_tween()

		tween.tween_property(TopRightRect, "size", Vector2(TopRightRect.size.x, height), 0.05)
		
		tween.tween_property(BottomRightRect, "size", Vector2(BottomRightRect.size.x, height), 0.05)

		tween.tween_property(TopLeftRect, "size", Vector2(TopLeftRect.size.x, height), 0.05)

		tween.tween_property(BottomLeftRect, "size", Vector2(BottomLeftRect.size.x, height), 0.05)
