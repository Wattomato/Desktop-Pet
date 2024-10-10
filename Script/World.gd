extends Node2D
@export_node_path("Camera2D") var main_camera: NodePath
@onready var _MainCamera: Camera2D = get_node(main_camera)
@onready var _MainWindow: Window = get_window()
#@onready var _SubWindow: Window = $Window
@export var player_size: Vector2i = Vector2i(160, 160)
#@export_range(0, 19) var player_visibility_layer: int = 1
#@export_range(0, 19) var world_visibility_layer: int = 2
var big: bool = false
func _ready():
	
	#_SubWindow.world_2d = _MainWindow.world_2d
	# Enable per-pixel transparency, required for transparent windows but has a performance cost
	# Can also break on some systems
	ProjectSettings.set_setting("display/window/per_pixel_transparency/allowed", true)
	# Set the window settings - most of them can be set in the project settings
	_MainWindow.borderless = true		# Hide the edges of the window
	_MainWindow.unresizable = true		# Prevent resizing the window
	_MainWindow.always_on_top = true	# Force the window always be on top of the screen
	_MainWindow.gui_embed_subwindows = false # Make subwindows actual system windows <- VERY IMPORTANT
	_MainWindow.transparent = true		# Allow the window to be transparent
	# Settings that cannot be set in project settings
	_MainWindow.transparent_bg = true	# Make the window's background transparent
	
	
	_MainWindow.size = player_size
	
	#_MainWindow.set_canvas_cull_mask_bit(player_visibility_layer, true)
	#_MainWindow.set_canvas_cull_mask_bit(world_visibility_layer, false)

	# Contrarily to the main window, hide the player and show the world
	#_SubWindow.set_canvas_cull_mask_bit(player_visibility_layer, false)
	#_SubWindow.set_canvas_cull_mask_bit(world_visibility_layer, true)
	
	_MainWindow.min_size = player_size
	_MainWindow.size = player_size
func _process(delta):
	# Update the main window's position
		#print(DisplayServer.screen_get_size())
		_MainWindow.position = get_window_pos_from_camera()
		#_MainWindow.min_size = player_size
		
	#print(get_global_mouse_position())

func get_window_pos_from_camera()->Vector2i:
	return (Vector2i(_MainCamera.global_position + _MainCamera.offset) - player_size / 2) 



#func _on_timer_timeout():
	#player_size = Vector2i(270,270)
	#_MainWindow.position = get_window_pos_from_camera()
	#_MainWindow.min_size = player_size
	#player_size = Vector2i(160, 160)
	#_MainWindow.position = get_window_pos_from_camera()
	#_MainWindow.min_size = player_size
