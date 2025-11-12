![Odysset Framework](./addons/odyssey/icon_of.svg)
# v0.1.1

Simplify development of FPS, RPG, ImSims.

# Included Addons
- [Little Camera Preview](https://github.com/anthonyec/godot_little_camera_preview)
- [LimboAI](https://github.com/limbonaut/limboai)
- [YAML](https://github.com/fimbul-works/godot-yaml)
- [GodotIK](https://github.com/monxa/GodotIK)
- [Twee](https://github.com/chair_full/GodotTwee)
- [RicherTextLabels](https://github.com/chairfull/GodotRichTextLabel2/tree/v2dev)

# Controls

|Control|Action|
|--|--|
|`Ctrl`+`1`| Toggle 1st-person view|
|`Ctrl`+`2`| Toggle 3rd-person view|
|`Ctrl`+`3`| Toggle top-down view|

# Design Goal
- AFAP: As few components as possible:
	- Player & npc share most scripts
	- Weapons/items share most components
- Gameplay over cinema:
	- Max interaction: Everything interactive w everything
	- Most cinematics skippable/ffwdable
	- NPCs w behavior, reacting to game events
- RPG-like world state where vars in unloaded scenes can be get/set
- Planning from the start for:
	- 1st/3rd/top-down/point-and-click view
	- Split screen multiplayer
	- Language changing
	- Mod/patch support
- Easy customisation with config files and hot replacements.
- Lots of juice/crunch (Communicating "somthing happened" to player and "how much")
	- Minimise jerkiness/clankiness.
	- [ ] UI buttons animate/communicate on hover, click, unhover
	- [ ] Landing causes camera to tilt based on impact
	- [ ] Sounds change based on object movement speed
	
# Todo

## Camera

## First Person
- [x] Movement
- [x] Jumping
	- [x] Coyote Time
	- [ ] Shrink Collider
	- [x] Hold longer = jump higher
	- [ ] Speed based on velocity
	- [ ] Air-control
- [ ] Ledges
	- [ ] Small hop over
	- [ ] Grabbing on fall
	- [ ] Ledges: Hang climbing side to side
- [x] Prone
	- [x] Crouch
	- [x] Crawl
	- [ ] Auto-Stand
- [ ] Tilt around corner
- [x] Sprint
- [ ] Swim
- [x] Interaction
- [x] Pick-Up
	- [x] Aim
	- [x] Camera FOV adjust
	- [x] Breathing Noise
	- [x] Drop
	- [x] Fire
	- [x] Reload
- [ ] Pushing
- [ ] Pulling
- [ ] Climbing
- [ ] God-Mode/Flying

## Third Person
- [ ] God-Mode
- [x] Click Movement
	- [ ] Auto-Jumping
- [x] Keyboard Movement
	- [x] Jumping
- [x] Interaction
- [x] Aim/Focus
- [ ] Look at objects
- [ ] Use hands on interactives
### Animations
- [x] Movement
- [x] Jumping

## NPC
- [ ] Moving
- [ ] Jumping
- [ ] Entering/Exiting mounts
	- [ ] Generic
	- [ ] Vehicles
- [ ] Look at
	- [ ] Character
	- [ ] Actions in scene
	- [ ] Noise locations
- [ ] Behaviors
	- [ ] Senses
		- [ ] Visual
			- [ ] Lighting scale (darkness, smoke... decreases)
		- [ ] Auditory
			- [ ] Drone scale (rain, machinery... decreases)
	- [ ] Patrol Area
	- [ ] "Live" in area (Sit, use objects)
	- [ ] Day schedule
	- [ ] Hostile to target
		- [ ] Hostile to multiple targets
	- [ ] Chase
	- [ ] Flee
	- [ ] Attack
		- [ ] Shoot
		- [ ] Melee
	- [ ] Pick-up items
	- [ ] Give/offer items
- [ ] Interact

## Cinema
- [x] Scripting language
	- [x] Parsing
	- [x] Script to AnimationPlayer
- [ ] Rewind
- [x] Pause gameplay
	- [ ] Slow game speed right before and after
- [ ] Respond to state
- [ ] Runtime cinematics (These don't pause gameplay)
- [x] Dialogue
	- [x] Captions
		- [ ] Audio
	- [ ] Choices
	- [ ] Scripted animations
		- [ ] Walking
		- [ ] Animations
- [ ] Save/load

## Interactions
### Items
- [x] Pick up
	- [ ] Hand points at object
	- [ ] Hand grab object animation
	- [ ] Add to inventory
- [x] Object Highlight
- [x] Label
	- [x] World-space when 3rd person
	- [ ] HUD-space when 1st person
- [x] No-clip first person camera
- [x] Drop
- [ ] Place on mount
- [x] Use equipped item
- [x] Reload equipped item
- [ ] Put item in inventory
- [ ] Hold from inventory
### Mounts
- [x] Mount: Change control to mount
- [x] Unmount: Revert control to character
### Vehicle
- [x] Enter/Exit
- [ ] Toggle first-third person camera
#### First Person
#### Third Person
#### Top-Down
- [ ] Click to drive to location

## Audio
- [ ] Footsteps

## Items
- [ ] Inventory
	- [ ] UI
- [ ] Pickup
	- [ ] 1st-Person
	- [ ] 3rd-Person
	- [ ] Top-Down
- [ ] Equip
- [ ] Use
- [ ] Mount/Display
### Weapons
- [x] Firing
	- [x] Ray-based
	- [ ] Shape-based
	- [ ] Decals
	- [ ] Particles
	- [ ] Sound
- [ ] Melee
- [x] Damagables
- [ ] Fall Damage

## UI
- [ ] Hit direction indicator
- [ ] Damage indicator (red-periphery)
	- [ ] Posion indicator (green)
- [x] Toast system
	- [x] Queue based on type
	- [ ] Update if visible
	- [ ] Templates
		- [ ] Quest state changed
		- [ ] Inventory state changed
		- [ ] Achievement
		- [ ] Location entered
### Markers
- [x] Show markers
- [ ] Fade in/out based on distance
- [ ] Change to arrow when off screen
### Minimap
- [x] Generator
	- [x] Generate cell images
	- [ ] Delete old cell images
	- [ ] Zip cell images
	- [ ] Stylize
	- [ ] Levels/Z-axis
	- [ ] Extra buffer around navpolygon
- [ ] Renderer
	- [x] Cells
	- [ ] Objects/interactives
	- [ ] Markers
### Meta-Menu
- [ ] Quest Log
- [ ] Wiki/Encyclopedia
- [ ] Skills/Stats
### Misc
- [ ] Pause Menu
- [ ] Settings
- [ ] Controls
- [ ] Save & Load
	- [x] Save
		- [x] Preview
		- [x] State
		- [ ] Only save changes to resources

## Input
- [ ] Gamepad
- [ ] Customise controls
	- [ ] Presets
	- [ ] Multiplayer

## Other
- [x] Split screen
	- [ ] Lighting not working in Mobile/Comaptibility mode

# res://_state_.gd
```gd
# WARNING: Autogenerated in StateBase
# Allows making sure all flow_script variables and functions will work.
# TODO: Show stats here, like 'lines spoken' for each character.
extends StateBase
func _cond_1190937198() -> bool: return my_quest.ticked("find_apple", "find_pear", "find_banana")
func _cond_1744640919() -> bool: return ZONE_EXITED.zone in [apple_area, pear_area, banana_area]
func _cond_1916210732() -> bool: return my_quest.ticked("find_pear", "find_banana")
func _cond_2090770405() -> bool: return true
func _cond_2090815788() -> bool: return my_quest.ticked("find_apple") or my_quest.ticked("find_banana") or my_quest.ticked("find_pear")
func _cond_2590090614() -> bool: return my_quest.ticked("find_apple", "find_banana")
func _cond_2636823051() -> bool: return ZONE_ENTERED.zone == pear_area
func _cond_3056990139() -> bool: return ZONE_ENTERED.zone in [apple_area, pear_area, banana_area]
func _cond_4194837085() -> bool: return my_quest.ticked("find_apple", "find_pear")
func _cond_520882869() -> bool: return ZONE_ENTERED.zone == apple_area
func _cond_5381() -> bool: return true

####
## CHARS x2
####
var mary: CharInfo:
	get: return chars[&"mary"]
var paul: CharInfo:
	get: return chars[&"paul"]

####
## ITEMS x3
####
var apple: ItemInfo:
	get: return items[&"apple"]
var banana: ItemInfo:
	get: return items[&"banana"]
var pear: ItemInfo:
	get: return items[&"pear"]

####
## ZONES x17
####
var apple_area: ZoneInfo:
	get: return zones[&"apple_area"]
var banana_area: ZoneInfo:
	get: return zones[&"banana_area"]
var home: ZoneInfo:
	get: return zones[&"home"]
var pear_area: ZoneInfo:
	get: return zones[&"pear_area"]

####
## STATS x1
####
var score: int:
	get: return stats[&"score"].value
	set(v): stats[&"score"].value = v

####
## QUESTS x1
####
var my_quest: QuestInfo:
	get: return quests[&"my_quest"]

```

# res://addons/anthonyec.camera_preview/plugin.gd
```gd
@tool
extends EditorPlugin

const preview_scene = preload("res://addons/anthonyec.camera_preview/preview.tscn")

var preview: CameraPreview
var current_main_screen_name: String

func _enter_tree() -> void:
	main_screen_changed.connect(_on_main_screen_changed)
	EditorInterface.get_selection().selection_changed.connect(_on_editor_selection_changed)
	
	# Initialise preview panel and add to main screen.
	preview = preview_scene.instantiate() as CameraPreview
	preview.request_hide()
	
	var main_screen = EditorInterface.get_editor_main_screen()
	main_screen.add_child(preview)
	
func _exit_tree() -> void:
	if preview:
		preview.queue_free()
		
func _ready() -> void:
	# TODO: Currently there is no API to get the main screen name without 
	# listening to the `EditorPlugin.main_screen_changed` signal:
	# https://github.com/godotengine/godot-proposals/issues/2081
	EditorInterface.set_main_screen_editor("Script")
	EditorInterface.set_main_screen_editor("3D")
	
func _on_main_screen_changed(screen_name: String) -> void:
	current_main_screen_name = screen_name
	
	 # TODO: Bit of a hack to prevent pinned staying between view changes on the same scene.
	preview.unlink_camera()
	_on_editor_selection_changed()

func _on_editor_selection_changed() -> void:
	if not is_main_screen_viewport():
		# This hides the preview "container" and not the preview itself, allowing
		# any locked previews to remain visible once switching back to 3D tab.
		preview.visible = false
		return
		
	preview.visible = true
	
	var selected_nodes = EditorInterface.get_selection().get_selected_nodes()
	
	var selected_camera_3d: Camera3D = find_camera_3d_or_null(selected_nodes)
	var selected_camera_2d: Camera2D = find_camera_2d_or_null(selected_nodes)
	
	if selected_camera_3d and current_main_screen_name == "3D":
		preview.link_with_camera_3d(selected_camera_3d)
		preview.request_show()
	
	elif selected_camera_2d and current_main_screen_name == "2D":
		preview.link_with_camera_2d(selected_camera_2d)
		preview.request_show()
		
	else:
		preview.request_hide()
	
func is_main_screen_viewport() -> bool:
	return current_main_screen_name == "3D" or current_main_screen_name == "2D"
	
func find_camera_3d_or_null(nodes: Array[Node]) -> Camera3D:
	var camera: Camera3D
	
	for node in nodes:
		if node is Camera3D:
			camera = node as Camera3D
			break
			
	return camera
	
func find_camera_2d_or_null(nodes: Array[Node]) -> Camera2D:
	var camera: Camera2D
	
	for node in nodes:
		if node is Camera2D:
			camera = node as Camera2D
			break
			
	return camera

func _on_selected_camera_3d_tree_exiting() -> void:
	preview.unlink_camera()

```

# res://addons/anthonyec.camera_preview/preview.gd
```gd
@tool

class_name CameraPreview
extends Control

enum CameraType {
	CAMERA_2D,
	CAMERA_3D
}

enum PinnedPosition {
	LEFT,
	RIGHT,
}

enum InteractionState {
	NONE,
	RESIZE,
	DRAG,

	# Animation is split into 2 seperate states so that the tween is only 
	# invoked once in the "start" state. 
	START_ANIMATE_INTO_PLACE,
	ANIMATE_INTO_PLACE,
}

const margin_3d: Vector2 = Vector2(10, 10)
const margin_2d: Vector2 = Vector2(20, 15)
const panel_margin: float = 2
const min_panel_size: float = 250

@onready var panel: Panel = %Panel
@onready var placeholder: Panel = %Placeholder
@onready var preview_camera_3d: Camera3D = %Camera3D
@onready var preview_camera_2d: Camera2D = %Camera2D
@onready var sub_viewport: SubViewport = %SubViewport
@onready var sub_viewport_text_rect: TextureRect = %TextureRect
@onready var resize_left_handle: Button = %ResizeLeftHandle
@onready var resize_right_handle: Button = %ResizeRightHandle
@onready var lock_button: Button = %LockButton
@onready var gradient: TextureRect = %Gradient
@onready var viewport_margin_container: MarginContainer = %ViewportMarginContainer
@onready var overlay_margin_container: MarginContainer = %OverlayMarginContainer
@onready var overlay_container: Control = %OverlayContainer

var camera_type: CameraType = CameraType.CAMERA_3D
var pinned_position: PinnedPosition = PinnedPosition.RIGHT
var viewport_ratio: float = 1
var editor_scale: float = EditorInterface.get_editor_scale()
var is_locked: bool
var show_controls: bool
var selected_camera_3d: Camera3D
var selected_camera_2d: Camera2D

var state: InteractionState = InteractionState.NONE
var initial_mouse_position: Vector2
var initial_panel_size: Vector2
var initial_panel_position: Vector2

func _ready() -> void:
	# Set initial width.
	panel.size.x = min_panel_size * editor_scale
	
	# Setting texture to viewport in code instead of directly in the editor 
	# because otherwise an error "Path to node is invalid: Panel/SubViewport"
	# on first load. This is harmless but doesn't look great.
	#
	# This is a known issue:
	# https://github.com/godotengine/godot/issues/27790#issuecomment-499740220
	sub_viewport_text_rect.texture = sub_viewport.get_texture()
	
	# From what I can tell there's something wrong with how an editor theme
	# scales when used within a plugin. It seems to ignore the screen scale. 
	# For instance, a 30x30px button will appear tiny on a retina display.
	#
	# Someone else had the issue with no luck:
	# https://forum.godotengine.org/t/how-to-scale-plugin-controls-to-look-the-same-in-4k-as-1080p/36151
	#
	# And seems Dialogic also scales buttons manually:
	# https://github.com/dialogic-godot/dialogic/blob/master/addons/dialogic/Editor/Common/sidebar.gd#L25C6-L38
	#
	# Maybe I don't know the correct way to do it, so for now the workaround is
	# to set the correct size in code using screen scale.
	var button_size = Vector2(30, 30) * editor_scale
	var margin_size: float = panel_margin * editor_scale
	
	resize_left_handle.size = button_size
	resize_left_handle.pivot_offset = Vector2(0, 0) * editor_scale
	
	resize_right_handle.size = button_size
	resize_right_handle.pivot_offset = Vector2(30, 30) * editor_scale
	
	lock_button.size = button_size
	lock_button.pivot_offset = Vector2(0, 30) * editor_scale
	
	viewport_margin_container.add_theme_constant_override("margin_left", margin_size)
	viewport_margin_container.add_theme_constant_override("margin_top", margin_size)
	viewport_margin_container.add_theme_constant_override("margin_right", margin_size)
	viewport_margin_container.add_theme_constant_override("margin_bottom", margin_size)
	
	overlay_margin_container.add_theme_constant_override("margin_left", margin_size)
	overlay_margin_container.add_theme_constant_override("margin_top", margin_size)
	overlay_margin_container.add_theme_constant_override("margin_right", margin_size)
	overlay_margin_container.add_theme_constant_override("margin_bottom", margin_size)
	
	# Parent node overlay size is not available on first ready, need to wait a 
	# frame for it to be drawn.
	await get_tree().process_frame
	
	# Anchors are set in code because setting them in the editor UI doesn't take
	# editor scale into account.
	resize_left_handle.position = Vector2(0, 0)
	resize_right_handle.set_anchors_preset(Control.PRESET_TOP_LEFT)
	
	resize_right_handle.position = Vector2(overlay_container.size.x - button_size.x, 0)
	resize_right_handle.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	
	lock_button.position = Vector2(0, overlay_container.size.y - button_size.y)
	lock_button.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)

func _process(_delta: float) -> void:
	if not visible: return
	
	match state:
		InteractionState.NONE:
			panel.size = get_clamped_size(panel.size)
			panel.position = get_pinned_position(pinned_position)
			
		InteractionState.RESIZE:
			var delta_mouse_position = initial_mouse_position - get_global_mouse_position()
			var resized_size = panel.size
		
			if pinned_position == PinnedPosition.LEFT:
				resized_size = initial_panel_size - delta_mouse_position
				
			if pinned_position == PinnedPosition.RIGHT:
				resized_size = initial_panel_size + delta_mouse_position
			
			panel.size = get_clamped_size(resized_size)
			panel.position = get_pinned_position(pinned_position)
			
		InteractionState.DRAG:
			placeholder.size = panel.size
			
			var global_mouse_position = get_global_mouse_position()
			var offset = initial_mouse_position - initial_panel_position

			panel.global_position = global_mouse_position - offset

			if global_mouse_position.x < global_position.x + size.x / 2:
				pinned_position = PinnedPosition.LEFT
			else:
				pinned_position = PinnedPosition.RIGHT
				
			placeholder.position = get_pinned_position(pinned_position)
			
		InteractionState.START_ANIMATE_INTO_PLACE:
			var final_position: Vector2 = get_pinned_position(pinned_position)
			var tween = get_tree().create_tween()
			
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(panel, "position", final_position, 0.3)
			
			tween.finished.connect(func():
				panel.position = final_position
				state = InteractionState.NONE
			)
			
			state = InteractionState.ANIMATE_INTO_PLACE
			
	# I couldn't get `mouse_entered` and `mouse_exited` events to work 
	# nicely, so I use rect method instead. Plus using this method it's easy to
	# grow the hit area size.
	var panel_hover_rect = Rect2(panel.global_position, panel.size)
	panel_hover_rect = panel_hover_rect.grow(40)
	
	var mouse_position = get_global_mouse_position()
	
	show_controls = state != InteractionState.NONE or panel_hover_rect.has_point(mouse_position)
	
	# UI visibility.
	resize_left_handle.visible = show_controls and pinned_position == PinnedPosition.RIGHT
	resize_right_handle.visible = show_controls and pinned_position == PinnedPosition.LEFT
	lock_button.visible = show_controls or is_locked
	placeholder.visible = state == InteractionState.DRAG or state == InteractionState.ANIMATE_INTO_PLACE
	gradient.visible = show_controls
	
	# Sync camera settings.
	if camera_type == CameraType.CAMERA_3D and selected_camera_3d:
		sub_viewport.size = panel.size
		
		# Sync position and rotation without using a `RemoteTransform` node 
		# because if you save a camera as a scene, the remote transform node will
		# be stored within the scene. Also it's harder to keep the remote 
		# transform `remote_path` up-to-date with scene changes, which causes 
		# many errors.
		preview_camera_3d.global_position = selected_camera_3d.global_position
		preview_camera_3d.global_rotation = selected_camera_3d.global_rotation
		
		preview_camera_3d.fov = selected_camera_3d.fov
		preview_camera_3d.projection = selected_camera_3d.projection
		preview_camera_3d.size = selected_camera_3d.size
		preview_camera_3d.cull_mask = selected_camera_3d.cull_mask
		preview_camera_3d.keep_aspect = selected_camera_3d.keep_aspect
		preview_camera_3d.near = selected_camera_3d.near
		preview_camera_3d.far = selected_camera_3d.far
		preview_camera_3d.h_offset = selected_camera_3d.h_offset
		preview_camera_3d.v_offset = selected_camera_3d.v_offset
		preview_camera_3d.attributes = selected_camera_3d.attributes
		preview_camera_3d.environment = selected_camera_3d.environment
	
	if camera_type == CameraType.CAMERA_2D and selected_camera_2d:
		var project_window_size = get_project_window_size()
		var ratio = project_window_size.x / panel.size.x
		
		# TODO: Is there a better way to fix this?
		# The camera border is visible sometimes due to pixel rounding. 
		# Subtract 1px from right and bottom to hide this.
		var hide_camera_border_fix = Vector2(1, 1)
		
		sub_viewport.size = panel.size
		sub_viewport.size_2d_override = (panel.size - hide_camera_border_fix) * ratio
		sub_viewport.size_2d_override_stretch = true
		
		preview_camera_2d.global_position = selected_camera_2d.global_position
		preview_camera_2d.global_rotation = selected_camera_2d.global_rotation

		preview_camera_2d.offset = selected_camera_2d.offset
		preview_camera_2d.zoom = selected_camera_2d.zoom
		preview_camera_2d.ignore_rotation = selected_camera_2d.ignore_rotation
		preview_camera_2d.anchor_mode = selected_camera_2d.anchor_mode
		preview_camera_2d.limit_left = selected_camera_2d.limit_left
		preview_camera_2d.limit_right = selected_camera_2d.limit_right
		preview_camera_2d.limit_top = selected_camera_2d.limit_top
		preview_camera_2d.limit_bottom = selected_camera_2d.limit_bottom

func link_with_camera_3d(camera_3d: Camera3D) -> void:
	# TODO: Camera may not be ready since this method is called in `_enter_tree` 
	# in the plugin because of a workaround for: 
	# https://github.com/godotengine/godot-proposals/issues/2081
	if not preview_camera_3d:
		return request_hide()
		
	var is_different_camera = camera_3d != preview_camera_3d
	
	# TODO: A bit messy.
	if is_different_camera:
		if preview_camera_3d.tree_exiting.is_connected(unlink_camera):
			preview_camera_3d.tree_exiting.disconnect(unlink_camera)
		
		if not camera_3d.tree_exiting.is_connected(unlink_camera):
			camera_3d.tree_exiting.connect(unlink_camera)
		
	sub_viewport.disable_3d = false
	sub_viewport.world_3d = camera_3d.get_world_3d()
	
	selected_camera_3d = camera_3d
	camera_type = CameraType.CAMERA_3D
	
func link_with_camera_2d(camera_2d: Camera2D) -> void:
	if not preview_camera_2d:
		return request_hide()
	
	var is_different_camera = camera_2d != preview_camera_2d
	
	# TODO: A bit messy.
	if is_different_camera:
		if preview_camera_2d.tree_exiting.is_connected(unlink_camera):
			preview_camera_2d.tree_exiting.disconnect(unlink_camera)
		
		if not camera_2d.tree_exiting.is_connected(unlink_camera):
			camera_2d.tree_exiting.connect(unlink_camera)
		
	sub_viewport.disable_3d = true
	sub_viewport.world_2d = camera_2d.get_world_2d()
		
	selected_camera_2d = camera_2d
	camera_type = CameraType.CAMERA_2D

func unlink_camera() -> void:
	if selected_camera_3d:
		selected_camera_3d = null
	
	if selected_camera_2d:
		selected_camera_2d = null
	
	is_locked = false
	lock_button.button_pressed = false
	
func request_hide() -> void:
	if is_locked: return
	visible = false
	
func request_show() -> void:
	visible = true
	
func get_pinned_position(pinned_position: PinnedPosition) -> Vector2:
	var margin: Vector2 = margin_3d * editor_scale
	
	if camera_type == CameraType.CAMERA_2D:
		margin = margin_2d * editor_scale
	
	match pinned_position:
		PinnedPosition.LEFT:
			return Vector2.ZERO - Vector2(0, panel.size.y) - Vector2(-margin.x, margin.y)
		PinnedPosition.RIGHT:
			return size - panel.size - margin
		_:
			assert(false, "Unknown pinned position %s" % str(pinned_position))
			
	return Vector2.ZERO
	
func get_clamped_size(desired_size: Vector2) -> Vector2:
	var viewport_ratio = get_project_window_ratio()
	var editor_viewport_size = get_editor_viewport_size()

	var max_bounds = Vector2(
		editor_viewport_size.x * 0.6,
		editor_viewport_size.y * 0.8
	)
	
	var clamped_size = desired_size
	
	# Apply aspect ratio.
	clamped_size = Vector2(clamped_size.x, clamped_size.x * viewport_ratio)
	
	# Clamp the max size while respecting the aspect ratio.
	if clamped_size.y >= max_bounds.y:
		clamped_size.x = max_bounds.y / viewport_ratio
		clamped_size.y = max_bounds.y
		
	if clamped_size.x >= max_bounds.x:
		clamped_size.x = max_bounds.x
		clamped_size.y = max_bounds.x * viewport_ratio
	
	# Clamp the min size based on if it's portrait or landscape. Portrait min
	# size should be based on it's height. Landscape min size is based on it's
	# width instead. Applying min width to a portrait size would make it too big.
	var is_portrait = viewport_ratio > 1
	
	if is_portrait and clamped_size.y <= min_panel_size * editor_scale:
		clamped_size.x = min_panel_size / viewport_ratio
		clamped_size.y = min_panel_size
		clamped_size = clamped_size * editor_scale
		
	if not is_portrait and clamped_size.x <= min_panel_size * editor_scale:
		clamped_size.x = min_panel_size
		clamped_size.y = min_panel_size * viewport_ratio
		clamped_size = clamped_size * editor_scale
	
	# Round down to avoid sub-pixel artifacts, mainly seen around the margins.
	return clamped_size.floor()
	
func get_project_window_size() -> Vector2:
	var window_width = float(ProjectSettings.get_setting("display/window/size/viewport_width"))
	var window_height = float(ProjectSettings.get_setting("display/window/size/viewport_height"))
	
	return Vector2(window_width, window_height)
	
func get_project_window_ratio() -> float:
	var project_window_size = get_project_window_size()
	
	return project_window_size.y / project_window_size.x
	
func get_editor_viewport_size() -> Vector2:
	var fallback_size = EditorInterface.get_editor_main_screen().size
	
	# There isn't an API for getting the viewport node. Instead it has to be
	# found by checking the parent's parent of the subviewport and find
	# the correct node based on name and class.
	var editor_sub_viewport_3d = EditorInterface.get_editor_viewport_3d(0)
	var editor_viewport_container = editor_sub_viewport_3d.get_parent().get_parent().get_parent()
	
	# Early return incase editor tree structure has changed.
	if editor_viewport_container.get_class() != "Node3DEditorViewportContainer":
		return fallback_size
		
	return editor_viewport_container.size

func _on_resize_handle_button_down() -> void:
	if state != InteractionState.NONE: return
	
	state = InteractionState.RESIZE
	initial_mouse_position = get_global_mouse_position()
	initial_panel_size = panel.size

func _on_resize_handle_button_up() -> void:
	state = InteractionState.NONE

func _on_drag_handle_button_down() -> void:
	if state != InteractionState.NONE: return
		
	state = InteractionState.DRAG
	initial_mouse_position = get_global_mouse_position()
	initial_panel_position = panel.global_position

func _on_drag_handle_button_up() -> void:
	if state != InteractionState.DRAG: return
	
	state = InteractionState.START_ANIMATE_INTO_PLACE

func _on_lock_button_pressed() -> void:
	is_locked = !is_locked

```

# res://addons/libik/script/max_rotation_bone_constraint.gd
```gd
@tool
class_name MaxRotationBoneConstraint extends GodotIKConstraint
## Constrains the rotation of a bone within a maximum angle.
##
## This constraint limits how much a bone can rotate from its initial orientation,
## ensuring it stays within a given angular range.

## Whether the constraint applies when the IK solver iterates forward.
@export var forward : bool

## Whether the constraint applies when the IK solver iterates backward.
@export var backward : bool

## Whether the constraint is currently active.
@export var active : bool

## The maximum allowable rotation angle (in radians) from the initial pose.
@export var max_rotation : float

var _initial_rotation : Quaternion

## This function overwrite limits the bone's rotation by ensuring it does not exceed
## the specified `max_rotation` angle from its initial pose.
func apply(
	pos_parent_bone: Vector3,
	pos_bone: Vector3,
	pos_child_bone: Vector3,
	dir: int
	) -> PackedVector3Array:

	var result = [pos_parent_bone, pos_bone, pos_child_bone]
	if not active:
		return result

	var dir_pb = pos_parent_bone.direction_to(pos_bone)
	var dir_bc = pos_bone.direction_to(pos_child_bone)

	## Store the initial rotation on the first iteration.
	if get_ik_controller().get_current_iteration() == 0:
		_initial_rotation = calculate_initial_rotation()

	## Compute the current rotation and the deviation from the initial pose.
	var current_rotation : Quaternion = Quaternion(dir_pb, dir_bc)
	var rotation_to_initial = _initial_rotation * current_rotation.inverse()
	var phi = rotation_to_initial.get_angle()

	## If within the max rotation, no correction is needed.
	if phi <= max_rotation:
		return result

	## Adjust the rotation based on direction and constraints.
	if dir == FORWARD and forward:
		var d = phi - max_rotation
		var adj = Quaternion(rotation_to_initial.get_axis(), d)
		result[2] = pos_bone + adj * dir_bc * (pos_child_bone - pos_bone).length()

	if dir == BACKWARD and backward:
		var d = phi - max_rotation
		var adj = Quaternion(-rotation_to_initial.get_axis(), d)
		result[0] = pos_bone + adj * -dir_pb * (pos_parent_bone - pos_bone).length()

	return result


## This function calculates the initial relative rotation between the parent and child bones
## before any IK solving takes place. This serves as a reference for enforcing the rotation constraint.
func calculate_initial_rotation() -> Quaternion:
	var bone_parent = get_skeleton().get_bone_parent(bone_idx)
	var bone_children = get_skeleton().get_bone_children(bone_idx)
	assert(bone_children.size() == 1)

	var pos_p = get_skeleton().get_bone_global_pose(bone_parent).origin
	var pos_b = get_skeleton().get_bone_global_pose(bone_idx).origin
	var pos_c = get_skeleton().get_bone_global_pose(bone_children[0]).origin

	var dir_pb = pos_p.direction_to(pos_b)
	var dir_bc = pos_b.direction_to(pos_c)

	return Quaternion(dir_pb, dir_bc)

```

# res://addons/libik/script/pole_bone_constraint.gd
```gd
@tool
class_name PoleBoneConstraint extends GodotIKConstraint
## Applies a pole vector constraint to an IK bone chain.
##
## This constraint ensures that the mid-bone follows a specific pole direction,
## controlling the plane in which the chain bends.

## Whether the constraint is currently active.
@export var active : bool = true

## The pole direction vector that influences the bending plane.
@export var pole_direction : Vector3

## If true, the constraint applies when the IK solver iterates forward.
@export var forward : bool = true

## If true, the constraint applies when the IK solver iterates backward.
@export var backward : bool = true

func apply(
		pos_parent_bone: Vector3,
		pos_bone: Vector3,
		pos_child_bone: Vector3,
		chain_dir : Dir
	) -> PackedVector3Array:
	var result : PackedVector3Array = [pos_parent_bone, pos_bone, pos_child_bone]
	if not active:
		return result
	if chain_dir == Dir.FORWARD and not forward:
		return result
	if chain_dir == Dir.BACKWARD and not backward:
		return result

	# Compute the primary bone direction
	var dir = (pos_child_bone - pos_parent_bone).normalized()

	# Project pole direction onto the plane perpendicular to dir
	var pole_direction_normalized = pole_direction.normalized()  # Ensure it's a unit vector
	var pole_direction_projected = pole_direction_normalized - pole_direction_normalized.dot(dir) * dir

	# If the projected pole direction is too small, return early
	if pole_direction_projected.length_squared() < 0.002:
		return result

	# Normalize the projected pole direction
	pole_direction_projected = pole_direction_projected.normalized()

	# Find the perpendicular foot of the bone to the line
	var mid_point = foot_of_the_perpendicular(pos_bone, pos_parent_bone, pos_child_bone)

	# Adjust the bone position to follow the pole constraint
	var mid_to_bone = pos_bone - mid_point
	var bone_length = mid_to_bone.length()  # Store instead of computing twice
	result[1] = mid_point + pole_direction_projected * bone_length

	return result

## Compute the foot of the perpendicular from a point to a line
func foot_of_the_perpendicular(point_tip: Vector3, point_line1: Vector3, point_line2: Vector3) -> Vector3:
	var bc: Vector3 = point_line2 - point_line1  # Vector along the line
	var t: float = (point_tip - point_line1).dot(bc) / bc.length_squared()  # Projection factor
	return point_line1 + t * bc

```

# res://addons/libik/script/smooth_bone_constraint.gd
```gd
@tool
class_name SmoothBoneConstraint extends GodotIKConstraint

## Enables or disables the smooth constraint.
@export var active = true
## Maximum allowed stretch factor for the bone.
@export var max_stretch : float = 1.5
## Speed at which the bone position is interpolated.
@export var smooth_speed : float = 20.

var _cached_pos_bone : Vector3
var _prev_time = Time.get_ticks_msec() * 0.001

## Smooths the bone position and applies a stretch limit.
func apply(
		pos_parent_bone: Vector3,
		pos_bone: Vector3,
		pos_child_bone: Vector3,
		chain_dir : Dir
	) -> PackedVector3Array:
	var result : PackedVector3Array = [pos_parent_bone, pos_bone, pos_child_bone]

	if active:
		if not _cached_pos_bone:
			_cached_pos_bone = result[1]
		var cur_time = Time.get_ticks_msec() * 0.001
		var delta = cur_time - _prev_time
		_prev_time = cur_time
		result[1] = lerp(_cached_pos_bone, result[1], min(delta * smooth_speed, 1.))
		_cached_pos_bone = result[1]
		if chain_dir == FORWARD:
			var d_old = pos_parent_bone.distance_to(pos_bone)
			var d_new = pos_parent_bone.distance_to(result[1])
			if d_old != 0 and d_new / d_old >= max_stretch:
				result[1] = pos_parent_bone + max_stretch * d_old * pos_parent_bone.direction_to(pos_bone)
	return result

```

# res://addons/libik/script/straight_bone_constraint.gd
```gd
@tool
class_name StraightBoneConstraint extends GodotIKConstraint
## Ensures a joint remains straight between the parent and child bones.
##
## This constraint forces the mid-bone to align perfectly along the axis
## between the parent and child bones, removing any bending.

## Whether the constraint is currently active.
@export var active : bool = true

## If true, the constraint applies when the IK solver iterates forward.
@export var forward : bool = true

## If true, the constraint applies when the IK solver iterates backward.
@export var backward : bool = true

## This function overwrite modifies the mid-bone position to ensure it stays in a straight line
## between the parent and child bones.
func apply(
		pos_parent_bone: Vector3,
		pos_bone: Vector3,
		pos_child_bone: Vector3,
		chain_dir : Dir
	) -> PackedVector3Array:
	var result : PackedVector3Array = [pos_parent_bone, pos_bone, pos_child_bone]

	if not active: return result
	if not forward and FORWARD or not backward and BACKWARD:
		return result

	var dir_parent_child = pos_parent_bone.direction_to(pos_child_bone)
	var len_parent_bone = pos_parent_bone.distance_to(pos_bone)
	var len_bone_child = pos_bone.distance_to(pos_child_bone)
	var vec_parent_bone = pos_bone - pos_parent_bone

	match chain_dir:
		FORWARD:
			result[1] = pos_parent_bone + dir_parent_child * len_parent_bone
			result[2] = pos_parent_bone + dir_parent_child * (len_parent_bone + len_bone_child)
		BACKWARD:
			result[1] = pos_child_bone - dir_parent_child * len_bone_child
			result[0] = pos_child_bone - dir_parent_child * (len_parent_bone + len_bone_child)
	return result

```

# res://addons/odyssey/flow/flow_player.gd
```gd
#@icon("res://addons/odyssey/flow")
class_name FlowPlayer extends AnimationPlayer

signal wait_started()
signal wait_ended()
signal ended()

## Multiple methods may be called in a single tick this way.
@export var method_calls: Dictionary[int, Array]
var _waiting_for_user := false
var _stack: Array[Array]

func _ready() -> void:
	if not Engine.is_editor_hint():
		animation_finished.connect(_animation_finished)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"advance_cinematic") and _waiting_for_user:
		get_viewport().set_input_as_handled()
		_waiting_for_user = false
		wait_ended.emit()
		seek(current_animation_position + .01)
		play()

func _meth(hash_index: int):
	if hash_index in method_calls:
		for item in method_calls[hash_index]:
			var meth_id: StringName = item[0]
			var meth_args: Array = item[1]
			Global.msg("FlowPlayer", "Method", item)
			match meth_id:
				&"_expr": State.call("_expr_%s" % meth_args[0])
				&"_cond":
					var conds: Array = meth_args[0]
					for cond in conds:
						var cond_hash: int = cond[0]
						var cond_branch: StringName = cond[1]
						if State.call("_cond_%s" % cond_hash):
							goto(cond_branch)
							break
				&"_event":
					var ev_id: StringName = meth_args[0]
					var ev_data: String = meth_args[1]
					Cinema._event(ev_id, ev_data)
				&"_break":
					if is_playing():
						var curr := current_animation
						stop(true)
						_animation_finished(curr)
				_: callv(meth_id, meth_args)

func _animation_finished(anim_id: StringName):
	Global.msg("FlowPlayer", "Animation Finished", [anim_id])
	if _stack:
		var last: Array = _stack.pop_back()
		var anim: StringName = last[0]
		var position: float = last[1]
		Global.msg("FlowPlayer", "Continue from", [], { anim=anim, position=position })
		_play(anim, position)
	else:
		Global.msg("FlowPlayer", "Finished")
		end()

func end():
	Global.msg("FlowPlayer", "Stopped")
	stop(true)
	ended.emit()

## Wait for user to press something.
func wait():
	if not is_playing(): return
	if _waiting_for_user: return
	_waiting_for_user = true
	wait_started.emit()
	pause()
	print("Waiting for user input.")

func goto(id: StringName, return_after := true, clear_stack := false):
	Global.msg("FlowPlayer", "Goto", [id], {return_after=return_after, clear_stack=clear_stack})
	if clear_stack:
		_stack.clear()
	
	if return_after:
		# Add a tenth of a second offset, so we don't repeat/loop.
		_stack.append([current_animation, current_animation_position + .01])
	
	if "/" in id:
		_play(id)
	else:
		var branch := current_animation.split("/", true, 1)[0]
		_play(branch + "/" + id)

func _play(id: StringName, at := 0.0):
	Global.msg("FlowPlayer", "Play", [], { anim=id, at=at })
	assigned_animation = id
	seek(at, false)
	play()

```

# res://addons/odyssey/flow/flow_player_generator.gd
```gd
@tool
class_name FlowPlayerGenerator extends Node

@export var flow_script: FlowScript
@export var default_delay := 0.5
var _queued_branches: Array[Array]
var _code_methods := 0
var _player: FlowPlayer
var _library_id: String
var _library: AnimationLibrary ## Current lib being generated.
var _branch_id: StringName
var _branch_anim: Animation ## Current anim being generated.
var _branch_state: Dictionary ## State of current anim branch.
var _branch_time: float ## Total time of current anim branch.
var _screens: Node

func get_state(key: StringName, default: Variant = null) -> Variant:
	return _branch_state.get(key, default)

func has_state(key: StringName) -> bool:
	return key in _branch_state

func set_state(key: StringName, value: Variant) -> void:
	_branch_state[key] = value

static func generate(paths: Array[FlowScript]) -> FlowPlayer:
	var generator := FlowPlayerGenerator.new()
	generator._generate()
	for path in paths:
		generator.add_script(path)
	return generator._player

func _generate():
	_player = FlowPlayer.new()
	_player.set_root(^".")
	
	_screens = CanvasLayer.new()
	_player.add_child(_screens)
	_screens.name = "screens"
	_screens.owner = _player

func add_script(cscript: FlowScript) -> void:
	_library = AnimationLibrary.new()
	_library_id = cscript.resource_path.get_basename().get_file()
	if _player.has_animation_library(_library_id):
		return
	_player.add_animation_library(_library_id, _library)
	var dict := FlowScriptParser.parse(cscript.code, cscript.resource_path)
	_queued_branches = [["ROOT", dict.tabbed]]
	while _queued_branches:
		var binfo: Array = _queued_branches.pop_front()
		var branch: Array[Dictionary]
		branch.assign(binfo[1])
		_add_branch(binfo[0], branch)

func _add_branch_queued(steps: Array[Dictionary], branch_id := &"") -> StringName:
	if not branch_id:
		branch_id = "branch_%s" % hash(steps)
	_queued_branches.append([branch_id, steps])
	return branch_id

func _add_branch(branch_id: StringName, steps: Array[Dictionary]):
	_branch_id = branch_id
	_branch_anim = Animation.new()
	_branch_anim.length = 0.0
	_branch_state = {}
	_branch_time = 0.0
	
	var track := _branch_anim.add_track(Animation.TYPE_METHOD)
	_branch_state.t_methods = track
	_branch_anim.track_set_path(track, ^".")
	_library.add_animation(branch_id, _branch_anim)
	
	var step_index := 0
	while step_index < steps.size():
		var step := steps[step_index]
		match step.type:
			FlowToken.TEXT:
				var state := add_object("caption")
				state.node._cinematic_step(self, step)
			FlowToken.KEYV:
				var state := add_object("caption")
				state.node._cinematic_step(self, step)
			FlowToken.CMND:
				match step.cmnd:
					&"MENU":
						var state := add_object("menu")
						state.node._cinematic_step(self, step)
					&"WAIT":
						add_time(1.0)
					&"CODE":
						add_method(&"_expr", [hash(step.rest)])
						add_time(1.0)
					&"IF":
						var collected := [step]
						var step_index2 := step_index+1
						while step_index2 < steps.size():
							var step2 := steps[step_index2]
							if step2.type == FlowToken.CMND and step2.cmnd in [&"ELIF", &"ELSE"]:
								collected.append(step2)
								step_index2 += 1
							else:
								break
						step_index = step_index2
						var args := []
						for cond in collected:
							var hash_index := hash(cond.rest)
							var branch := _add_branch_queued(cond.tabbed)
							args.append([hash_index, branch])
						print("IFELFO", args)
						add_method(&"_cond", [args])
						add_time(0.1)
					&"ELIF", &"ELSE":
						push_error("ELIF and ELSE must follow and IF.")
					_:
						if step.cmnd in QuestDB.ALL_EVENTS\
						or step.cmnd in InventoryDB.ALL_EVENTS:
							add_method(&"_event", [step.cmnd, step.rest])
						else:
							Global.warn("FlowPlayerGenerator", "Unimplimented command %s." % [step])
			_:
				Global.warn("FlowPlayerGenerator", "Unimplmented step %s." % [step])
		step_index += 1

func has_object(id: String) -> bool:
	return get_object(id) != null

func get_object(id: String) -> Node:
	return _player.get_node_or_null(id)

func add_object(id: String) -> Dictionary:
	if not has_object(id):
		var node := Assets.create_scene(id, _player)
		node.name = id
		node.owner = _player
	if not has_state(id):
		var node := get_object(id)
		set_state(id, { node=node, node_path=".".path_join(id) })
	return get_state(id)

func add_checkpoint():
	add_method(&"wait")

func add_method(method: StringName, args: Array = []):
	var hash_index := hash(_branch_id + str(_branch_time))
	if not hash_index in _player.method_calls:
		_player.method_calls[hash_index] = []
	_player.method_calls[hash_index].append([method, args])
	# Will replace existing frames, but that's fine since they will have the same hash.
	_branch_anim.track_insert_key(_branch_state.t_methods, _branch_time, { method=&"_meth", args=[hash_index] })

func add_track(node: Node, property: NodePath, update: Variant = null, interp: Variant = null) -> int:
	var state_name := node.name
	var state: Dictionary = get_state(state_name, {})
	var path := "%s:%s" % [state.node_path, property]
	if update == null:
		var node_res := _player.get_node_and_resource(path)
		var obj: Object = (node_res[1] if node_res[1] else node_res[0])
		var prop: Variant = obj.get_indexed(node_res[2])
		match typeof(prop):
			TYPE_FLOAT, TYPE_INT, TYPE_VECTOR2, TYPE_VECTOR3, TYPE_VECTOR4: update = Animation.UPDATE_CONTINUOUS
			_: update = Animation.UPDATE_DISCRETE
	if interp == null:
		var node_res := _player.get_node_and_resource(path)
		var obj: Object = (node_res[1] if node_res[1] else node_res[0])
		var prop: Variant = obj.get_indexed(node_res[2])
		match typeof(prop):
			TYPE_FLOAT, TYPE_INT, TYPE_VECTOR2, TYPE_VECTOR3, TYPE_VECTOR4: interp = Animation.INTERPOLATION_LINEAR
			_: interp = Animation.INTERPOLATION_NEAREST
	var track_name := "t_%s" % property
	if not track_name in state:
		var track := _branch_anim.add_track(Animation.TYPE_VALUE)
		_branch_anim.track_set_path(track, path)
		_branch_anim.track_set_interpolation_type(track, interp)
		_branch_anim.value_track_set_update_mode(track, update)
		state[track_name] = track
	return state[track_name]

func add_key(track: int, time: float, key: Variant, transition: float = 1.0):
	_branch_anim.track_insert_key(track, time, key, transition)

func add_time(amount: float = default_delay):
	_branch_time += amount
	_branch_anim.length += amount

func get_time() -> float:
	return _branch_time

```

# res://addons/odyssey/flow/flow_script.gd
```gd
@tool
class_name FlowScript extends Resource

@export_custom(PROPERTY_HINT_EXPRESSION, "") var code := ""

func get_id() -> String:
	return resource_path.get_basename().get_file()

func get_parsed() -> Dictionary:
	return FlowScriptParser.parse(code, resource_path)

@export_tool_button("Print Parsed") var _tb_print_parsed := func():
	print(JSON.stringify(get_parsed(), "\t", false))

@export_tool_button("Generate Dummy") var _tb_generate_dummy := func():
	FlowPlayerGenerator.generate([self])

```

# res://addons/odyssey/flow/flow_script_parser.gd
```gd
@tool
class_name FlowScriptParser extends RefCounted

const TYPES := [FlowToken.CMND, FlowToken.FLOW, FlowToken.FUNC, FlowToken.KEYV, FlowToken.NUMB, FlowToken.PROP, FlowToken.TEXT]

static var REGEX_FUNCTION: RegEx

static func pprint(d: Dictionary):
	print(JSON.stringify(d, "\t", false))

static func parse(str: String, dbg_file := "") -> Dictionary:
	REGEX_FUNCTION = RegEx.create_from_string(r"^[@%^]?[A-Za-z_][A-Za-z0-9_]*\(.*\)$")
	
	var out: Dictionary
	var root := { tabbed=[] }
	var stack := [root]
	stack.resize(20)
	var lines := str.split("\n")
	var i := 0
	while i < lines.size():
		var deep := 0
		var line := lines[i]
		# Tabs or YAML style two-spaces.
		while deep < line.length():
			if line[deep] == "\t":
				deep += 2
			elif line[deep] == " ":
				deep += 1
			else:
				break
		deep = deep / 2
		var comment := line.rfind("# ")
		var stripped := line.substr(deep, comment).strip_edges()
		if stripped:
			var info := _str_to_step(stripped, dbg_file, i)
			if "_greedy" in info:
				var j := i+1
				var subkey: String = "val" if info.type == FlowToken.KEYV else "rest"
				while j < lines.size():
					var deep2 := 0
					var line2 := lines[j]
					while deep2 < line2.length() and line2[deep2] == "\t":
						deep2 += 1
					if deep2 <= deep: break
					var comment2 := line2.rfind("# ")
					var stripped2 := line2.substr(deep+1, comment2).strip_edges(false)
					info[subkey] += stripped2 + "\n"
					j += 1
				info[subkey] = info[subkey].trim_suffix("\n")
				info.erase("_greedy")
				i = j
			if not "tabbed" in stack[deep]:
				var tabbed: Array[Dictionary]
				stack[deep].tabbed = tabbed
			stack[deep].tabbed.append(info)
			stack[deep+1] = info
		i += 1
	
	return root

# TODO: Error handling which outputs dbg_file and dbg_line.
static func _str_to_step(str: String, dbg_file: String, dbg_line: int) -> Dictionary:
	var step: Dictionary
	var parts := str.split(" ", true, 1)
	if parts.size() == 1: parts.append("")
	
	# Functions: func_name(true, "false)
	# Can start with @ for nodes, % for unique named, and ^ for when dealing with children, in loops.
	if REGEX_FUNCTION.search(str):
		step.type = FlowToken.FUNC
		step.func = str
	# Numbers: "1.0"
	elif str.is_valid_float():
		step.type = FlowToken.NUMB
		step.numb = str
	# Flow: "=== flow_id"
	elif parts[0] == "===":
		step.type = FlowToken.FLOW
		step.flow = parts[1].strip_edges()
	# Command: "COMMAND rest"
	elif parts[0] == parts[0].to_upper():
		step.type = FlowToken.CMND
		step.cmnd = parts[0]
		step.rest = parts[1]
		if step.cmnd.ends_with(":"):
			step.cmnd = step.cmnd.trim_suffix(":")
			step._greedy = true
	# Key val: "key: val"
	elif parts[0].ends_with(":"):
		step.type = FlowToken.KEYV
		step.key = parts[0].trim_suffix(":")
		step.val = parts[1]
		if not step.val:
			step._greedy = true
	# New line: ""
	elif parts[0] == "/":
		step.type = FlowToken.TEXT
		step.text = ""
	# Speakerless text: ":Text without a speaker."
	elif parts[0].begins_with(":"):
		step.type = FlowToken.TEXT
		step.text = str.trim_prefix(":")
	# Properties: "position (1, 2)"
	elif parts[0] == parts[0].to_lower():
		step.type = FlowToken.PROP
		step.prop = {}
		var tokens := get_space_seperated_tokens(str)
		var i := 0
		while i < tokens.size():
			step.prop[tokens[i]] = tokens[i+1]
			i += 2
	# Text: "speaker with or without speach."
	else:
		step.type = FlowToken.TEXT
		step.text = str
	step.dbg = "%s:%s" % [dbg_file, dbg_line]
	return step

static func get_kwargs_from_space_seperated_tokens(line: String, args: Array[String], kwargs: Dictionary[StringName, String]):
	for token in get_space_seperated_tokens(line):
		if ":" in token:
			var key_val := token.split(":", true, 1)
			kwargs[StringName(key_val[0])] = key_val[1]
		else:
			args.append(token)

static func get_space_seperated_tokens(line: String) -> PackedStringArray:
	var tokens: PackedStringArray
	var buf := ""
	var brackets := []
	var i := 0
	while i < line.length():
		var c := line[i]
		if c in "({[\"":
			brackets.append(c)
			buf += c
		elif c in ")}]":
			buf += c
			if brackets: brackets.pop_back()
		elif c == "\"" and (not brackets or brackets[-1] != "\""):
			brackets.append(c)
			buf += c
		elif c == "\"" and brackets and brackets[-1] == "\"":
			brackets.pop_back()
			buf += c
		elif c == " " and not brackets:
			if buf:
				tokens.append(buf)
				buf = ""
		else:
			buf += c
		i += 1
	if buf:
		tokens.append(buf)
	return tokens

const TEST_FLOW_SCRIPT := """
# Comment
speaker: Caption for speaker. # Right side comment.
Speakerless text. Begins with a capital.
:SPEAKERLESS TEXT BEGINNING WITH A COLON. # For when there is yelling.

SHOW paul left
MOVE paul right

CODE:
	if score > 20:
		reset()
		if archer.has_item():
			print("Has item.")
	
	else:
		print("Score too low.")

SCREEN shout
	TEXT
		Once upon a time there was a king
		Text on second line.
		/
		Text after a break.

IF score > 20
	We have a high score.
ELSE
	Low score.

MENU talk
	Menu text.
	Go westward
		JUMP west
	Go east
		JUMP east

ON signal ENABLED true KEY one two three
	modulate Color.RED position (100, 200)

EASE 1.0 position (0, 1) modulate Color.BLUE
1.0
function_call(true, "false")

# Quest Stuff
name "The Final Quest"
desc: Return to the final quest
ON entered_zone WHO player ZONE main_base
	Player entered the main base
	player: Here I am, in the base!
	
=== subflow
	This is a subflow.

"""

```

# res://addons/odyssey/flow/flow_token.gd
```gd
class_name FlowToken extends RefCounted

const CMND := &"cmnd" # { cmnd: "", rest: "" }
const FLOW := &"flow" # { flow: "" }
const FUNC := &"func" # { func: "" }
const KEYV := &"keyv" # { key: "", val: "" }
const NUMB := &"numb" # { numb: "" }
const PROP := &"prop" # { prop: {} }
const TEXT := &"text" # { text: "" }

```

# res://addons/richer_text/scripts/editor_property_list.gd
```gd
@tool
class_name EditorProperties extends RefCounted

var _list: Array[Dictionary]

func _init(list := []) -> void:
	_list.assign(list)

func group(name: String, hint_string: String) -> EditorProperties:
	return prop(name, TYPE_NIL, PROPERTY_HINT_NONE, hint_string, PROPERTY_USAGE_GROUP)

func subgroup(name: String, hint_string: String) -> EditorProperties:
	return prop(name, TYPE_NIL, PROPERTY_HINT_NONE, hint_string, PROPERTY_USAGE_SUBGROUP)

func res(name: StringName, type: String = "Resource") -> EditorProperties:
	return prop(name, TYPE_OBJECT, PROPERTY_HINT_RESOURCE_TYPE, type)

func button(name: StringName, text: String = "Click") -> EditorProperties:
	return prop(name, TYPE_CALLABLE, PROPERTY_HINT_TOOL_BUTTON, text, PROPERTY_USAGE_EDITOR)

func boolean(name: StringName) -> EditorProperties:
	return prop(name, TYPE_BOOL)

func node_path(name: StringName, type := "") -> EditorProperties:
	return prop(name, TYPE_NODE_PATH, PROPERTY_HINT_NODE_PATH_VALID_TYPES, type)

func color(name: StringName) -> EditorProperties:
	return prop(name, TYPE_COLOR)

func integer(name: StringName) -> EditorProperties:
	return prop(name, TYPE_INT)

func integer_enum(name: StringName, en: Variant) -> EditorProperties:
	en = en if en is String else ",".join(en.keys().map(func(s): return s.capitalize()))
	return prop(name, TYPE_INT, PROPERTY_HINT_ENUM, en)

func string(name: StringName) -> EditorProperties:
	return prop(name, TYPE_STRING)

func string_enum(name: StringName, keys: Variant) -> EditorProperties:
	return prop(name, TYPE_STRING, PROPERTY_HINT_ENUM_SUGGESTION, ",".join(keys))

func tween_trans(name: StringName) -> EditorProperties:
	return prop(name, TYPE_INT, PROPERTY_HINT_ENUM, "Linear:0,Sine:1,Quint:2,Quart:3,Quad:4,Expo:5,Elastic:6,Cubic:7,Circ:8,Bounce:9,Back:10,Spring:11")

func tween_ease(name: StringName) -> EditorProperties:
	return prop(name, TYPE_INT, PROPERTY_HINT_ENUM, "In:0,Out:1,In Out:2,Out In:3")

func number_range(name: StringName, minn = 0.0, maxx = 1.0) -> EditorProperties:
	return prop(name, TYPE_FLOAT, PROPERTY_HINT_RANGE, "%s,%s" % [minn, maxx])

func number(name: StringName) -> EditorProperties:
	return prop(name, TYPE_FLOAT)

func node(name: StringName, hint_string: String = "") -> EditorProperties:
	return prop(name, TYPE_OBJECT, PROPERTY_HINT_NODE_TYPE, hint_string)

func dict(name: StringName, hint_string: String) -> EditorProperties:
	if true and Engine.get_version_info().hex >= 0x040400:
		#var hint_string := "%s;%s" % [type_string(typeof(a)), type_string(typeof(b))]
		# PROPERTY_HINT_DICTIONARY_TYPE = 38
		return prop(name, TYPE_DICTIONARY, 38, hint_string)
	else:
		return prop(name, TYPE_DICTIONARY)

func file(name: StringName, types: PackedStringArray = []) -> EditorProperties:
	return prop(name, TYPE_STRING, PROPERTY_HINT_FILE, "" if not types else ("*." + ",*.".join(types)))

func dir(name: StringName) -> EditorProperties:
	return prop(name, TYPE_STRING, PROPERTY_HINT_DIR)

func enum_cursor(name: StringName) -> EditorProperties:
	return integer_enum(name, CursorShape)

func prop(name: StringName, type: int, hint: PropertyHint = PROPERTY_HINT_NONE, hint_string: String = "", usage := PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE) -> EditorProperties:
	_list.append({ name=name, type=type, usage=usage, hint=hint, hint_string=hint_string })
	return self

func end() -> Array[Dictionary]:
	return _list

enum CursorShape {
	ARROW = 0,			# Arrow cursor. Standard, default pointing cursor.
	IBEAM = 1,			# I-beam cursor. Usually used to show where the text cursor will appear when the mouse is clicked.
	POINTING_HAND = 2,	# Pointing hand cursor. Usually used to indicate the pointer is over a link or other interactable item.
	CROSS = 3,			# Cross cursor. Typically appears over regions in which a drawing operation can be performed or for selections.
	WAIT = 4,			# Wait cursor. Indicates that the application is busy performing an operation, and that it cannot be used during the operation.
	BUSY = 5,			# Busy cursor. Indicates that the application is busy performing an operation, and that it is still usable during the operation.
	DRAG = 6,			# Drag cursor. Usually displayed when dragging something.
						# Note: Windows lacks a dragging cursor, so DRAG is the same as MOVE for this platform.
	CAN_DROP = 7,		# Can drop cursor. Usually displayed when dragging something to indicate that it can be dropped at the current position.
	FORBIDDEN = 8,		# Forbidden cursor. Indicates that the current action is forbidden or that the control at a position is disabled.
	VSIZE = 9,			# Vertical resize mouse cursor. Double-headed vertical arrow.
	HSIZE = 10,			# Horizontal resize mouse cursor. Double-headed horizontal arrow.
	BDIAGSIZE = 11,		# Window resize cursor (↘↖). Bottom-left to top-right diagonal double-headed arrow.
	FDIAGSIZE = 12,		# Window resize cursor (↙↗). Top-left to bottom-right diagonal double-headed arrow.
	MOVE = 13,			# Move cursor. Indicates that something can be moved.
	VSPLIT = 14,		# Vertical split cursor. On Windows, same as VSIZE.
	HSPLIT = 15,		# Horizontal split cursor. On Windows, same as HSIZE.
	HELP = 16			# Help cursor. Usually a question mark.
}

```

# res://addons/richer_text/scripts/font_db.gd
```gd
@tool
class_name FontDB extends Resource
## Font Database scans for fonts so they can be easily used.

const EXT_FONT: PackedStringArray = ["otf", "ttf", "ttc", "otc", "woff", "woff2", "pfb", "pfm", "fnt", "font"]
const PATH_DEFAULT_DB := "res://assets/font_db.tres"

@export_dir var parent_dir := "res://" ## Directory to start scanning from.
@export var paths: Dictionary[StringName, String] ## Paths organized by a nickname.
@export var emoji: String ## Path to emoji font.
@export var sanitize_ids := true ## Make names lowercase without symbols.

## Scans parent_dir for fonts.
@export_tool_button("Find Fonts") var _tool_button := find_fonts

static func get_default() -> FontDB:
	if Engine.is_editor_hint():
		if not FileAccess.file_exists(PATH_DEFAULT_DB):
			if not DirAccess.dir_exists_absolute(PATH_DEFAULT_DB.get_base_dir()):
				DirAccess.make_dir_recursive_absolute(PATH_DEFAULT_DB.get_base_dir())
			var fontdb := FontDB.new()
			fontdb.find_fonts()
			var err := ResourceSaver.save(fontdb, PATH_DEFAULT_DB)
			if err != OK:
				push_error("FontDB: ", error_string(err))
	return load(PATH_DEFAULT_DB)

func get_nice_names() -> PackedStringArray:
	return paths.keys().map(func(s: String): return s.capitalize())

func get_font(id: StringName) -> Font:
	id = _sanitise(id)
	#print("SAN ", id)
	return load(paths[id]) if id in paths else ThemeDB.fallback_font

func find_fonts():
	if not Engine.is_editor_hint():
		push_error("Shouldn't scan for fonts when not in editor.")
		return
	
	_scan_dir(parent_dir)
	notify_property_list_changed()

func _sanitise(id: String) -> StringName:
	var out := ""
	for c in id.to_snake_case():
		if c in "abcdefghijklmnopqrstuvwxyz0123456789":
			out += c
		elif out and out[-1] != "-":
			out += "-"
	return out
	
func _scan_dir(dir: String):
	for subdir in DirAccess.get_directories_at(dir):
		_scan_dir(dir.path_join(subdir))
	
	for file in DirAccess.get_files_at(dir):
		if file.get_extension().to_lower() in EXT_FONT:
			var font_path := dir.path_join(file)
			var font_id := file.get_basename().get_file()
			if "emoji" in font_id.to_lower():
				print("Found emoji font: %s" % font_path)
				emoji = font_path
			elif not paths.find_key(font_path):
				if sanitize_ids:
					font_id = _sanitise(font_id)
				print("Found font: %s" % font_id)
				paths[font_id] = font_path
			else:
				print("Already found font at %s" % font_path)

```

# res://addons/richer_text/scripts/juicy_label.gd
```gd
@tool
class_name JuicyLabel extends Control

enum EffectState { DEFAULT, HOVERED, CLICKED }

@export var font_db: FontDB = FontDB.get_default():
	set(f):
		if f == null:
			f = FontDB.get_default()
		font_db = f

@export_storage var font_id: String:
	set(f):
		font_id = f
		font = font_db.get_font(font_id)
		queue_redraw()

@export var font_size: int = 64:
	set(s):
		font_size = s
		queue_redraw()

@export var text := "": set=set_text
@export var color := Color(.17, .78, .45, 1.0)

@export var outlines: Array[RTxtOutline]
@export var style := RTxtOutline.Style.TEXT
@export var outline_size := 1 ## Only used if style is Outline or OutlineAndText.

@export_range(0.0, 1.0, 0.01) var effect_weight := 1.0 ## Scales some effects by this amount.
@export var effect_state := EffectState.DEFAULT: set=set_effect_state
@export_storage var _effect_state := EffectState.DEFAULT ## True effect_state.

@export var default_effect: RTxtEffect:
	set(e):
		if e == null: e = RTE_Mega.new()
		if e: e._juicy = self
		default_effect = e

@export var hovered_effect: RTxtEffect:
	set(e):
		if e == null: e = RTE_Mega.new()
		if e: e._juicy = self
		hovered_effect = e

@export var clicked_effect: RTxtEffect:
	set(e):
		if e == null: e = RTE_Mega.new()
		if e: e._juicy = self
		clicked_effect = e

@export var disable_effects := false ## Disables any effects. Debug.

var _anim := 0.0
var _smoothed_mouse_position := Vector2.ZERO
var _rects: Array[Rect2]
var _tween: Tween
var _tween_amount := 0.0
var font: Font:
	get: return font if font else ThemeDB.fallback_font

var horizontal_alignment := HORIZONTAL_ALIGNMENT_CENTER ## TODO
var vertical_alignment := VERTICAL_ALIGNMENT_CENTER ## TODO.

func set_text(t: String):
	text = t
	
	var total_size := Vector2.ZERO
	var offset := Vector2.ZERO
	var chr_offset := Vector2.ZERO
	_rects.resize(text.length())
	for i in _rects.size():
		var chr := text[i]
		var chr_pos := offset + chr_offset
		var chr_size := font.get_string_size(chr, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size)
		_rects[i] = Rect2(chr_pos, chr_size)
		chr_offset.x += chr_size.x
		total_size.x = maxf(total_size.x, chr_offset.x)
		total_size.y = maxf(total_size.y, chr_size.y)
	
	size = total_size
	custom_minimum_size = total_size
	
	queue_redraw()

func set_effect_state(s: EffectState):
	effect_state = s
	_tween_amount = 0.0
	
	var from := _get_effect(_effect_state)
	var to := _get_effect(effect_state)
	if from and to:
		if _tween: _tween.kill()
		_tween = create_tween()
		_tween.tween_property(self, "_tween_amount", 1.0, to.tween_duration)\
			.set_trans(to.tween_trans)\
			.set_ease(to.tween_ease)
		_tween.tween_callback(func(): _effect_state = effect_state)

func _process(delta: float) -> void:
	_anim += delta
	_smoothed_mouse_position = _smoothed_mouse_position.lerp(get_local_mouse_position(), 10.0 * delta)
	queue_redraw()

func _get_effect(s: EffectState) -> RTxtEffect:
	match s:
		EffectState.DEFAULT: return default_effect
		EffectState.HOVERED: return hovered_effect
		EffectState.CLICKED: return clicked_effect
	return default_effect

func _draw() -> void:
	# Debug boxes.
	#for i in _rects.size():
		#draw_rect(_rects[i], Color(Color.BLACK, 0.5), false, 1, true)
	
	var ascent := Vector2(0.0, font.get_ascent(font_size))
	var baseline := Vector2(0.0, font.get_ascent(font_size))
	var diff := (size - custom_minimum_size)
	
	match horizontal_alignment:
		HORIZONTAL_ALIGNMENT_CENTER: baseline.x += diff.x * .5
		HORIZONTAL_ALIGNMENT_RIGHT: baseline.x += diff.x
		HORIZONTAL_ALIGNMENT_FILL: baseline.x += diff.x * .5
	
	match vertical_alignment:
		VERTICAL_ALIGNMENT_CENTER: baseline.y += diff.y * .5
		VERTICAL_ALIGNMENT_BOTTOM: baseline.y += diff.y
		VERTICAL_ALIGNMENT_FILL: baseline.y += diff.y * .5
	
	if disable_effects:
		pass
	
	elif effect_state != _effect_state:
		var a_effect := _get_effect(_effect_state)
		var b_effect := _get_effect(effect_state)
		if a_effect and b_effect:
			a_effect._juicy = self
			b_effect._juicy = self
			
			var cfx := RTxtCharFXTransform.new()
			cfx.elapsed_time = _anim
			
			for i in _rects.size():
				var rect := _rects[i]
				
				cfx.relative_index = i
				cfx.range = Vector2(i, 0)
				
				var a_trans: Transform2D 
				var a_color: Color
				cfx.transform = Transform2D(0.0, Vector2.ONE, 0.0, rect.position)
				cfx.color = color
				if a_effect._process_custom_fx(cfx):
					a_trans = cfx.transform
					a_color = cfx.color
				
				var b_trans: Transform2D
				var b_color: Color
				cfx.transform = Transform2D(0.0, Vector2.ONE, 0.0, rect.position)
				cfx.color = color
				if b_effect._process_custom_fx(cfx):
					b_trans = cfx.transform
					b_color = cfx.color
				
				var mix_trans := a_trans.interpolate_with(b_trans, _tween_amount)
				var mix_color := a_color.lerp(b_color, _tween_amount)
				draw_set_transform_matrix(mix_trans)
				draw_string(font, baseline, text[i], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, mix_color)
			return
	else:
		var text_server = TextServerManager.get_primary_interface()
		var effect := _get_effect(effect_state)
		if effect:
			effect._juicy = self
			
			var states: Array[RTxtCharFXTransform]
			states.resize(_rects.size())
			
			for i in _rects.size():
				var rect := _rects[i]
				var half_size := rect.size * .5
				var cfx := RTxtCharFXTransform.new()
				cfx.font = font.get_rid()
				cfx.elapsed_time = _anim
				cfx.relative_index = i
				cfx.range = Vector2(i, 0)
				cfx.transform = Transform2D(0.0, Vector2.ONE, 0.0, Vector2.ZERO)
				cfx.color = color
				cfx.glyph_index = text_server.font_get_glyph_index(font.get_rids()[0], font_size, text[i].unicode_at(0), 0)
				cfx.outline_states.assign(outlines.map(func(o: RTxtOutline):
					return {} if not o else {
						style=o.style,
						color=o.color,
						position=o.position,
						size=o.size,
						rotation=o.rotation,
						skew=o.skew, 
						scale=o.scale }))
				#cfx.set_meta(&"outlines", outlines)
				#cfx.set_meta(&"outline_states", outline_states)
				states[i] = cfx
				
				if effect._process_custom_fx(cfx):
					pass
			
			for o in range(outlines.size()-1, -1, -1):
				if not outlines[o]:
					continue
				for i in _rects.size():
					var cfx := states[i]
					var rect := _rects[i]
					var half_size := rect.size * .5
					var outline: Dictionary = cfx.outline_states[o]
					var off: Vector2 = outline.position
					var chr := char(text_server.font_get_char_from_glyph_index(font.get_rids()[0], font_size, cfx.glyph_index))
					var mtx := cfx.transform * Transform2D(outline.rotation, outline.scale, outline.skew, outline.position)
					var basis_only := Transform2D(cfx.transform.x, cfx.transform.y, Vector2.ZERO)
					var desired_center := rect.position + Vector2(baseline.x, 0) + half_size
					var draw_mtx := Transform2D.IDENTITY.translated(desired_center) * basis_only * Transform2D.IDENTITY.translated(-half_size)
					draw_set_transform_matrix(draw_mtx)
					if outline.style != RTxtOutline.Style.OUTLINE:
						draw_string(font, ascent, chr, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, outline.color)
					if outline.style != RTxtOutline.Style.TEXT:
						draw_string_outline(font, ascent, chr, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, outline.size, outline.color)
			
			for i in _rects.size():
				var cfx = states[i]
				var rect := _rects[i]
				var half_size := rect.size * .5
				var chr := char(text_server.font_get_char_from_glyph_index(font.get_rids()[0], font_size, cfx.glyph_index))
				var mtx: Transform2D = cfx.transform
				var basis_only := Transform2D(cfx.transform.x, cfx.transform.y, Vector2.ZERO)
				var desired_center := rect.position + Vector2(baseline.x, 0) + half_size
				var draw_mtx := Transform2D.IDENTITY.translated(desired_center) * basis_only * Transform2D.IDENTITY.translated(-half_size)
				draw_set_transform_matrix(draw_mtx)
				if style != RTxtOutline.Style.OUTLINE:
					draw_string(font, ascent, chr, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, cfx.color)
				if style != RTxtOutline.Style.TEXT:
					draw_string_outline(font, ascent, chr, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, outline_size, cfx.color)
		return
	
	for i in _rects.size():
		var rect := _rects[i]
		draw_string(font, rect.position + baseline, text[i], HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, color)

#region Editor
func _property_can_revert(property: StringName) -> bool:
	return property in JuicyLabel.new()

func _property_get_revert(property: StringName) -> Variant:
	return JuicyLabel.new().get(property)

func _get_property_list() -> Array[Dictionary]:
	return EditorProperties.new()\
		.string_enum(&"font_id", font_db.paths.keys() if font_db else [])\
		.integer_enum(&"horizontal_alignment", "Left,Center,Right,Fill")\
		.integer_enum(&"vertical_alignment", "Top,Center,Bottom,Fill")\
		.end()
#endregion

```

# res://addons/richer_text/scripts/richer_text_label.gd
```gd
@tool
class_name RicherTextLabel extends RichTextLabel

signal link_hovered(content: Variant)
signal link_unhovered(content: Variant)
signal link_clicked(content: Variant)
signal link_right_clicked(content: Variant)
signal _mods_finished() ## Called after all the mods have postprocessed the label.

class TooltipObject extends RefCounted:
	var id: String
	var tooltip_text: String
	func _to_string() -> String:
		return "Tooltip:%s(%s)" % [id, tooltip_text]

@export var bbcode_head: String: set=set_bbcode_head ## Will always prefix the bbcode.
@export_custom(PROPERTY_HINT_EXPRESSION, "") var bbcode: String: set=set_bbcode
var _image_keys: PackedInt32Array ## Allow us to change image color & alpha with effects.

## Scaled to the parser size.
#@export var font_scale := 1.0:
	#set(f):
		#font_scale = f
		#_changed_font_size()

## Scaled against effects like [sin] and [bounce].
@export_range(0.0, 1.0) var effect_weight := 1.0

@export var modifiers: Array[RTxtModifier]:
	set(m):
		modifiers = m
		for mod in modifiers:
			if mod:
				mod.label = self
				if not mod.changed.is_connected(refresh):
					mod.changed.connect(refresh)
		refresh()

@export var shadow: RTxtShadow:
	set(s):
		shadow = s
		if s: s.changed.connect(_changed_shadow)
		_changed_shadow()

var font: Font:
	get: return load(parser.font_default) if parser else ThemeDB.fallback_font

var font_size: float:
	get: return (parser.font_size if parser else ThemeDB.fallback_font_size)# * font_scale

## Populated with [link] tag data.
@export_storage var link_content: Dictionary[int, String]
var _link_regions: Dictionary[int, PackedInt32Array] ## Used internally for mouse over detection. Populated by RTxtLinkEffect.
var _link_rects: Dictionary[int, PackedVector2Array] ## Used internally for mouse over detection.
var hovered_link: int = -1:
	set(h):
		if h == hovered_link:
			return
		if hovered_link != -1:
			_link_unhovered(hovered_link)
			_set_cursor(Input.CURSOR_ARROW)
		hovered_link = h
		if hovered_link != -1:
			_link_hovered(hovered_link)
			if can_click(hovered_link):
				_set_cursor(parser.link_cursor if parser else Input.CURSOR_POINTING_HAND)
			else:
				_set_cursor(parser.link_tooltip_cursor if parser else Input.CURSOR_HELP)

@export var parser: RTxtParser = RTxtParser.get_default(): set=set_parser

func _set_cursor(shape: int):
	Input.set_default_cursor_shape(shape)
	mouse_default_cursor_shape = shape

## Converts a Callable into a clickable tag.
## WARNING: You still have to wrap it: "[%s]Test]" % to_link(my_func)
static func to_link(call: Callable) -> String:
	var id := call.get_object_id()
	var meth := call.get_method()
	var args := "&".join(call.get_bound_arguments().map(JSON.stringify))
	return "=call:%s:%s:%s" % [id, meth, args]

func set_bbcode_head(head: String):
	bbcode_head = head
	refresh()

func set_bbcode(bb: String):
	if bbcode == bb:
		return
	bbcode = bb
	refresh()

func refresh():
	link_content.clear()
	_link_regions.clear()
	_link_rects.clear()
	_image_keys.clear()
	uninstall_effects()
	set_process_input(false)
	
	var bb := bbcode
	
	for mod in modifiers:
		if mod and mod.enabled:
			bb = mod._preparse(bb)
	
	# Attach the head after the modifiers, since they tend to repeat stuff.
	var bb_head := bbcode_head.strip_edges()
	if bb_head:
		if not bb_head.begins_with("["): bb_head = "[" + bb_head
		if not bb_head.ends_with("]"): bb_head = bb_head + "]"
		bb = bb_head + bb
	
	if parser:
		if not is_inside_tree():
			await ready
		bb = parser.parse(bb, self, link_content)
		
		if link_content and parser.link_effect:
			_install_effect(parser.link_effect)
			set_process_input(true)
	else:
		print("No parser...")
	
	if false and "[/img]" in bb:
		# HACK: To give images a key so we can update them with RichTextLabel effects.
		clear()
		var re := RegEx.create_from_string(r"(\[img[^\]]*\])(.+?)(\[/img\])")
		var offset := 0
		while offset < bb.length():
			var rm := re.search(bb, offset)
			if rm:
				append_text(bb.substr(offset, rm.get_start() - offset))
				var index := get_parsed_text().length()
				_image_keys.append(index)
				add_image(load(rm.strings[2]), 64, 64, Color.WHITE, INLINE_ALIGNMENT_CENTER, Rect2(), index)
				offset = rm.get_end()
			else:
				append_text(bb.substr(offset))
				offset = bb.length()
	else:
		set_text(bb)

func _finished():
	for mod in modifiers:
		if mod and mod.enabled:
			mod._finished()
	_mods_finished.emit()

var _debug_commands: Array[Callable]
func add_draw(drawcmd: Callable):
	if not _debug_commands:
		_debug_commands = []
	_debug_commands.append(drawcmd)
	queue_redraw()

func _init() -> void:
	set_process_input(false)
	
	if not parser:
		set_parser(null)
		bbcode_enabled = true
		fit_content = true
		autowrap_mode = TextServer.AUTOWRAP_OFF
		meta_underlined = false
		hint_underlined = false
	
	for mod in modifiers:
		if mod and not mod.changed.is_connected(refresh):
			mod.changed.connect(refresh)
	
	if not finished.is_connected(_finished):
		finished.connect(_finished)

func _exit_tree() -> void:
	# Clear states on the way out, since many nodes can share the effect.
	# TODO: At the moment you can't probably can't have RicherTextLabels with links.
	if link_content and parser.link_effect:
		parser.link_effect._clear()

func _input(event: InputEvent) -> void:
	if not link_content or not parser.link_effect:
		set_process_input(false)
		return
		
	if event is InputEventMouseMotion:
		if parser and parser.link_effect:
			parser.link_effect._check_mouse_over(self, get_local_mouse_position())
	elif event is InputEventMouseButton and event.pressed and hovered_link != -1:
		if can_click(hovered_link):
			if event.button_index == MOUSE_BUTTON_LEFT:
				get_viewport().set_input_as_handled()
				_link_clicked(hovered_link)
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				get_viewport().set_input_as_handled()
				_link_clicked(hovered_link, true)

func _draw() -> void:
	for mod in modifiers:
		if mod and mod.enabled:
			mod._debug_draw(self)
	
	while _debug_commands:
		_debug_commands.pop_front().call(self)

## If false this is just a tooltip meta.
func can_click(index: int) -> bool:
	var link := get_link_content(index)
	if link is Callable:
		return true
	elif link is Object and (link.has_method(&"_richtext_clicked") or link.has_method(&"_richtext_right_clicked")):
		return true
	return false

func _link_clicked(index: int, right_clicked := false):
	var link := get_link_content(index)
	var result: Variant = null
	if link is Callable:
		var obj = link.get_object()
		var method = link.get_method()
		if right_clicked and obj.has_method(method + "_right_clicked"):
			result = obj.callv(method + "_right_clicked", link.get_bound_arguments())
		else:
			result = link.call()
	elif link is Object:
		if right_clicked:
			if link.has_method(&"_richtext_right_clicked"):
				result = link._richtext_right_clicked()
		else:
			if link.has_method(&"_richtext_clicked"):
				result = link._richtext_clicked()
	
	if not result:
		return
	
	if parser:
		if parser.link_effect:
			parser.link_effect._link_clicked(index)
		if parser.link_audio_enabled:
			if right_clicked:
				_play_sound(parser.link_audio_path_right_clicked)
			else:
				_play_sound(parser.link_audio_path_clicked)
	
	if right_clicked:
		if result != true:
			link_right_clicked.emit(link)
		RTxtParser.link_right_clicked.emit(self, index)
	else:
		if result != true:
			link_clicked.emit(link)
		RTxtParser.link_clicked.emit(self, index)

func _link_hovered(index: int):
	var link := get_link_content(index)
	var result: Variant
	if link is Object and link.has_method(&"_richtext_hovered"):
		result = link._richtext_hovered()
	elif link is Callable:
		var obj: Object = link.get_object()
		var hov_method: StringName = &"%s_hovered" % link.get_method()
		if obj.has_method(hov_method):
			result = obj.callv(hov_method, link.get_bound_arguments())
	elif link is TooltipObject:
		result = link.tooltip_text
	
	if result is String:
		tooltip_text = result
	elif result != true:
		return
	
	if parser:
		if parser.link_effect:
			parser.link_effect._link_hovered(index)
		if parser.link_audio_enabled:
			if can_click(index):
				_play_sound(parser.link_audio_path_hovered)
			else:
				_play_sound(parser.link_audio_path_tooltip_hovered)
	
	if result != true:
		link_hovered.emit(link)
	RTxtParser.link_hovered.emit(self, index)

func _link_unhovered(index: Variant):
	var link := get_link_content(index)
	var result: Variant
	if link is Object and link.has_method(&"_richtext_unhovered"):
		result = link._richtext_unhovered()
	elif link is Callable:
		var obj: Object = link.get_object()
		var hov_method: StringName = &"%s_unhovered" % link.get_method()
		if obj.has_method(hov_method):
			result = obj.callv(hov_method, link.get_bound_arguments())
	elif link is TooltipObject:
		result = ""
	
	if result is String:
		tooltip_text = result
	elif result != true:
		return
	
	if parser:
		if parser.link_effect:
			parser.link_effect._link_unhovered(index)
		if parser.link_audio_enabled:
			if can_click(index):
				_play_sound(parser.link_audio_path_unhovered)
			else:
				_play_sound(parser.link_audio_path_tooltip_unhovered)
	
	if result != true:
		link_unhovered.emit(link)
	RTxtParser.link_unhovered.emit(self, index)

func get_link_content(index: Variant) -> Variant:
	var link_str: String = link_content.get(int(index), "")
	if link_str.begins_with("id:"):
		return instance_from_id(int(link_str.trim_prefix("id:")))
	elif link_str.begins_with("call:"):
		var parts := link_str.split(":", true, 3)
		var object := instance_from_id(int(parts[1]))
		var method := parts[2]
		var args := [] if not parts[3] else Array(parts[3].split("&"))
		return Callable(object, method).bindv(args)
	elif link_str.begins_with("{"):
		return JSON.parse_string(link_str)
	elif "?" in link_str:
		var parts := link_str.split("?", true, 1)
		var tt := TooltipObject.new()
		tt.id = parts[0]
		tt.tooltip_text = parts[1]
		return tt
	return link_str

func _play_sound(path: String):
	if not path or not FileAccess.file_exists(path):
		return
	var snd := AudioStreamPlayer.new()
	add_child(snd)
	snd.stream = load(path)
	snd.play()
	snd.finished.connect(snd.queue_free)

func get_animation() -> RTxtAnimator:
	return get_modifier(RTxtAnimator)

func get_modifier(script: GDScript) -> RTxtModifier:
	for mod in modifiers:
		if mod.get_script() == script:
			return mod
	return null

func set_parser(p: RTxtParser):
	if p == null:
		p = RTxtParser.get_default()
	var last_parser := parser
	parser = p
	if p and not p.started.is_connected(_started):
		p.started.connect(_started, CONNECT_PERSIST)
		p.install_effect.connect(_install_effect, CONNECT_PERSIST)
		p.changed_font.connect(_changed_font, CONNECT_PERSIST)
		p.changed_font_size.connect(_changed_font_size, CONNECT_PERSIST)
		p.changed_outline.connect(_changed_outline, CONNECT_PERSIST)
	_changed_font()
	_changed_font_size()
	_changed_shadow()

func _install_effect(effect: RichTextEffect):
	effect.resource_local_to_scene = true
	effect.set_meta(&"rt", get_instance_id())
	install_effect(effect)

func _started():
	bbcode_enabled = true

func uninstall_effects():
	while custom_effects:
		custom_effects.pop_back()

func _changed_font_size():
	_changed_shadow()
	if parser:
		add_theme_font_size_override(&"normal_font_size", parser.font_size)
		add_theme_font_size_override(&"bold_font_size", parser.font_size)
		add_theme_font_size_override(&"italics_font_size", parser.font_size)
		add_theme_font_size_override(&"bold_italics_font_size", parser.font_size)
	else:
		remove_theme_font_size_override(&"normal_font_size")
		remove_theme_font_size_override(&"bold_font_size")
		remove_theme_font_size_override(&"italics_font_size")
		remove_theme_font_size_override(&"bold_italics_font_size")

func _changed_font():
	if parser:
		var normal_font := ThemeDB.fallback_font
		if parser.font_db:
			if parser.font_default and parser.font_default in parser.font_db:
				normal_font = load(parser.font_db.font_paths[parser.font_default])
		add_theme_font_override(&"normal_font", normal_font)
		
		var bold_font := FontVariation.new()
		bold_font.setup_local_to_scene()
		bold_font.set_base_font(normal_font)
		bold_font.set_variation_embolden(parser.font_bold_weight)
		add_theme_font_override(&"bold_font", bold_font)
		
		var italics_font := FontVariation.new()
		italics_font.set_base_font(normal_font)
		italics_font.set_variation_embolden(parser.font_italics_weight)
		italics_font.set_variation_transform(Transform2D(Vector2(1, parser.font_italics_slant), Vector2(0, 1), Vector2(0, 0)))
		add_theme_font_override(&"italics_font", italics_font)
		
		var bold_italics_font := FontVariation.new()
		bold_italics_font.set_base_font(normal_font)
		bold_italics_font.set_variation_embolden(parser.font_bold_weight)
		bold_italics_font.set_variation_transform(Transform2D(Vector2(1, parser.font_italics_slant), Vector2(0, 1), Vector2(0, 0)))
		add_theme_font_override(&"bold_italics_font", italics_font)
	else:
		remove_theme_font_override(&"normal_font")
		remove_theme_font_override(&"bold_font")
		remove_theme_font_override(&"italics_font")
		remove_theme_font_override(&"bold_italics_font")

func _changed_outline():
	if parser:
		if parser.outline_size > 0 and parser.outline_mode != RTxtParser.OutlineMode.OFF:
			add_theme_constant_override(&"outline_size", parser.outline_size)
		else:
			remove_theme_constant_override(&"outline_size")
		
		if parser.font_color != Color.WHITE:
			add_theme_color_override(&"default_color", parser.font_color)
		else:
			remove_theme_color_override(&"default_color")
		
		match parser.outline_mode:
			RTxtParser.OutlineMode.OFF: remove_theme_color_override(&"font_outline_color")
			RTxtParser.OutlineMode.DARKEN: add_theme_color_override(&"font_outline_color", hue_shift(parser.font_color.darkened(parser.outline_adjust), parser.outline_hue_adjust))
			RTxtParser.OutlineMode.LIGHTEN: add_theme_color_override(&"font_outline_color", hue_shift(parser.font_color.lightened(parser.outline_adjust), parser.outline_hue_adjust))
			RTxtParser.OutlineMode.CUSTOM, RTxtParser.OutlineMode.CUSTOM_DARKEN, RTxtParser.OutlineMode.CUSTOM_LIGHTEN: add_theme_color_override(&"font_outline_color", parser.outline_color)
	else:
		remove_theme_constant_override(&"outline_size")
		remove_theme_color_override(&"font_outline_color")
		remove_theme_color_override(&"default_color")

func _changed_shadow():
	if shadow and shadow.enabled:
		add_theme_color_override(&"font_shadow_color", Color(shadow.color, shadow.alpha))
		add_theme_constant_override(&"shadow_offset_x", floor(cos(shadow.angle) * shadow.distance))
		add_theme_constant_override(&"shadow_offset_y", floor(sin(shadow.angle) * shadow.distance))
		add_theme_constant_override(&"shadow_outline_size", ceil(font_size * shadow.outline_size))
	else:
		remove_theme_color_override(&"font_shadow_color")
		remove_theme_constant_override(&"shadow_offset_x")
		remove_theme_constant_override(&"shadow_offset_y")
		remove_theme_constant_override(&"shadow_outline_size")

func _make_custom_tooltip(for_text: String) -> Object:
	if not for_text.strip_edges():
		return null
	var lbl := RicherTextLabel.new()
	lbl.size = Vector2.ZERO
	lbl.parser = parser
	lbl.autowrap_mode = TextServer.AUTOWRAP_OFF
	lbl.bbcode_enabled = true
	lbl.fit_content = true
	lbl.bbcode = "[0.6]%s]" % [for_text]
	return lbl

# @mairod https://gist.github.com/mairod/a75e7b44f68110e1576d77419d608786
# converted to godot by teebar. no credit needed.
const kRGBToYPrime = Vector3(0.299, 0.587, 0.114)
const kRGBToI = Vector3(0.596, -0.275, -0.321)
const kRGBToQ = Vector3(0.212, -0.523, 0.311)
const kYIQToR = Vector3(1.0, 0.956, 0.621)
const kYIQToG = Vector3(1.0, -0.272, -0.647)
const kYIQToB = Vector3(1.0, -1.107, 1.704)
static func hue_shift(color: Color, adjust: float) -> Color:
	var colorv = Vector3(color.r, color.g, color.b)
	var YPrime = colorv.dot(kRGBToYPrime)
	var I = colorv.dot(kRGBToI)
	var Q = colorv.dot(kRGBToQ)
	var hue = atan2(Q, I)
	var chroma = sqrt(I * I + Q * Q)
	hue += adjust * TAU
	Q = chroma * sin(hue)
	I = chroma * cos(hue)
	var yIQ = Vector3(YPrime, I, Q)
	return Color(yIQ.dot(kYIQToR), yIQ.dot(kYIQToG), yIQ.dot(kYIQToB), color.a)

```

# res://addons/richer_text/scripts/rtxt_animator.gd
```gd
@tool
class_name RTxtAnimator extends RTxtModifier
#TODO: When not animating, remove the Effect, so it's less cpu intensive.
#TODO: Fade out previous lines. This will allow for cool things with Scatterer.

signal started() ## Caused once animation begins.
signal paused() ## When paused by <hold> or <wait>.
signal continued() ## User advanced or timer finished.
signal finished() ## Animation finished, and indicator should probably be shown.
signal progressed(p: float) ## Better than using progress float, as this is smoothly updated by the tween.
signal indicator_enabled() ## Fires when paused, finished, or waiting started.
signal indicator_disabled() ## Fires when started, continued, or waiting ended.
signal timer_started() ## Timer until advance.
signal timer_progressed(p: float) ## 1.0 -> 0.0: Time until auto-advance.
signal timer_finished() ## Timer finished.

## Unit of characters to animate at a time.
## Look at `delay`.
enum Unit {
	CHAR,	## Each character fades one by one.
	WORD,	## All characters in a word fade together.
	LINE	## All characters in a line fade together.
}

## Where the indicator will align itself.
enum IndicatorAlignment {
	CharTop,	## Top of last character.
	CharCenter,	## Center of last character.
	CharBottom,	## Bottom of last character.
	LineBottom,	## Bottom of last visible line.
	LineRight,	## x=Right edge of bounding box, y=last visible line.
}

enum NewLineStyle {
	None,
	WaitForUser,		## Wait for user to press advance.
	WaitForUserJoin,	## Wait for user, and join lines.
	WaitForTime,		## Wait for timer to advance.
	WaitForTimeJoin	## Wait for timer, and join lines.
}

var unit := Unit.WORD: set=set_unit
var duration := 1.0  ## How long before a unit is faded in.
var delay := 0.2 ## Delay between units fading it.
var trans := Tween.TRANS_LINEAR ## Transition to use for fade.
var ease := Tween.EASE_IN_OUT	## Ease to use for fade.
#var uninstall_effect_after_fade := true
var progress := 1.0: set=set_progress
var animation := &"fader" ## Animation to fade with.
var new_line_style := NewLineStyle.WaitForUser
var arrow_node_path: NodePath ## Node that will be moved to the end of the characters.
var arrow_offset := Vector2.ZERO ## Ideally it's better to use a node child, but this is for convenience.
var arrow_alignment := IndicatorAlignment.CharCenter
var arrow_show_on_finished := true ## Show the indicator even after animation is finished.

## TODO:
## Hides lines when a new one started animating.
## Useful for the scatter and ticker effect.
#@export var hide_previous_lines := false

@export_storage var _total_chars := 0
@export_storage var _total_words := 0
@export_storage var _total_lines := 0
var _tool_button_advance := advance
var _tool_button_reset = reset
@export_storage var _waypoints: Dictionary[int, String]
@export_storage var _alphas: PackedFloat32Array
@export_storage var _chars: PackedInt32Array
@export_storage var _words: PackedInt32Array
@export_storage var _lines: PackedInt32Array
var _transforms: Array[Transform2D]
var _char_size: Array[Vector2] ## Returns the character width. Used for CTC.
var _tween: Tween
@export_storage var _waiting_for_time := false
@export_storage var _waiting_for_user := false
var _tween_timer: Tween

func set_unit(u: Unit):
	unit = u
	if not label or not label.is_inside_tree():
		return
	
	var stripped := label.get_parsed_text()
	var units := [""]
	var last_unit := 0
	var ulist := _chars
	if u == Unit.WORD: ulist = _words
	if u == Unit.LINE: ulist = _lines
	for i in stripped.length():
		if ulist[i] == last_unit:
			units[-1] += stripped[i]
		else:
			units.append(stripped[i])
		last_unit = ulist[i]

func set_progress(p: float):
	var last_progress := progress
	progress = clampf(p, 0.0, 1.0)
	
	if not label:
		return
	
	var last_u := floori(last_progress * _total_chars)
	var u := floori(progress * _total_chars)
	if _tween: _tween.kill()
	
	if last_u > u:
		for i in _alphas.size():
			set("alphas_%s" % i, 0.0)
	else:
		if last_progress == 0:
			started.emit()
		else:
			continued.emit()
		indicator_disabled.emit()
		
		progressed.emit(progress)
		
		var ulist: PackedInt32Array = _chars
		match unit:
			Unit.CHAR: ulist = _chars
			Unit.WORD: ulist = _words
			Unit.LINE: ulist = _lines
		var last_visible := -1
		_tween = label.create_tween()
		_tween.set_parallel()
		var last_unit_index := 0
		var unit_delay := 0.0
		var max_duration := 0.0
		for i in _alphas.size():
			var unit_index := ulist[i]
			var char_index := _chars[i]
			var was_visible: bool = char_index <= last_u
			var visible: bool = char_index <= u
			if visible:
				last_visible = i
			if visible and not was_visible:
				if unit_index != last_unit_index:
					unit_delay += delay
			_tween.tween_property(self, "alphas_%s" % i, 1.0 if visible else 0.0, duration)\
				.set_delay(unit_delay)\
				.set_trans(trans)\
				.set_ease(ease)
			max_duration = maxf(max_duration, duration + unit_delay)
			last_unit_index = unit_index
		_tween.tween_method(progressed.emit, last_progress, progress, max_duration)
		
		# HACK: TODO: Why do i need to do this?
		if progress == 1.0:
			last_visible = _total_chars
		
		_tween.chain().tween_callback(_update_indicator.bind(last_visible))
		
		if last_visible in _waypoints:
			for waypoint in _waypoints[last_visible].split(";"):
				match waypoint:
					"user": pass
					"time":
						_tween.chain().tween_callback(timer_started.emit)
						_tween.chain().tween_callback(set.bind("_waiting_for_time", true))
						_tween.chain().tween_method(timer_progressed.emit, 1.0, 0.0, 1.0)
						_tween.chain().tween_callback(advance)
						_tween.chain().tween_callback(set.bind("_waiting_for_time", false))
						_tween.tween_callback(timer_finished.emit)
		
		_tween.chain().tween_callback(_advance_finished)

func _update_indicator(last_visible: int):
	
	# Move indicator into position.
	var arrow_node := label.get_node_or_null(arrow_node_path)
	if arrow_node:
		if last_visible != -1:
			arrow_node.position = Vector2.ZERO
			
			match arrow_alignment:
				IndicatorAlignment.CharTop:
					var trans := _transforms[last_visible]
					arrow_node.position = trans.origin
					arrow_node.position.y -= label.font_size
				IndicatorAlignment.CharCenter:
					var trans := _transforms[last_visible]
					arrow_node.position = trans.origin
					arrow_node.position.y -= label.font_size * .5
				IndicatorAlignment.CharBottom:
					var trans := _transforms[last_visible]
					arrow_node.position = trans.origin
				IndicatorAlignment.LineBottom:
					var trans := _transforms[last_visible]
					arrow_node.position = trans.origin
					arrow_node.position.x = label.size.x * .5
				IndicatorAlignment.LineRight:
					var trans := _transforms[last_visible]
					arrow_node.position = trans.origin
					arrow_node.position.x = label.size.x
					arrow_node.position.y -= label.font_size * .5
			arrow_node.position += arrow_offset
	
func _advance_finished():
	# Fire signals.
	if progress == 1.0:
		finished.emit()
		if arrow_show_on_finished:
			indicator_enabled.emit()
	else:
		paused.emit()
		indicator_enabled.emit()

func reset():
	progress = 0.0

func advance_to_char(char_index: int):
	progress = float(char_index) / float(_total_chars)

func get_anim_char() -> int:
	return floori(progress * float(_total_chars))

func advance():
	var current := get_anim_char()
	var next := -1
	for i in range(current+1, _total_chars):
		if i in _waypoints:
			next = i
			break
	advance_to_char(next if next != -1 else _total_chars)

## Returns all `progress` positions that can advanced() will move towards.
## Useful for using an AnimationPlayer to control it.
func get_all_waypoints() -> Array[float]:
	var out: Array[float]
	#if true:
		#var pp := _preparse(label.bbcode)
		#var total_chars := label.parser.parse(pp).length()
		#for i in total_chars:
			#if i in label.parser._waypoints:
				#out.append(i / float(total_chars))
		#prints("WAYPOINTS", label.name, out, label.bbcode, pp)
	#else:
	for i in _total_chars:
		if i in _waypoints:
			out.append(i / float(_total_chars))
	out.append(1.0)
	return out

func is_finished() -> bool:
	return progress == 1.0

func _preparse(bbcode: String) -> String:
	if not Engine.is_editor_hint():
		indicator_disabled.emit()
		progress = 0.0
	if new_line_style != NewLineStyle.None:
		var newlns := ""
		for line in bbcode.split("\n"):
			if line.strip_edges() and newlns:
				match new_line_style:
					NewLineStyle.WaitForUser: newlns += "<user>\n" + line
					NewLineStyle.WaitForUserJoin: newlns += "<user>" + line
					NewLineStyle.WaitForTime: newlns += "<time>\n" + line
					NewLineStyle.WaitForTimeJoin: newlns += "<time>" + line
			else:
				newlns += line
		bbcode = newlns
	return super("[%s id=%s]%s]" % [animation, get_instance_id(), bbcode])
	
func _finished():
	_waypoints = {}
	if label.parser:
		var stripped := label.get_parsed_text()
		_waypoints.merge(label.parser._waypoints)
		_total_chars = stripped.length()
		_total_words = 0
		_total_lines = 0
		_transforms.resize(_total_chars+1) # Not sure why I have to +1
		_char_size.resize(_total_chars+1)
		_alphas.resize(_total_chars)
		_chars.resize(_total_chars)
		_words.resize(_total_chars)
		_lines.resize(_total_chars)
		var spaced := false
		for i in _total_chars:
			var c := stripped[i]
			if c == " ":
				spaced = true
			elif c == "\n":
				_total_lines += 1
				spaced = true
			else:
				if spaced:
					_total_words += 1
					spaced = false
			_chars[i] = i
			_words[i] = _total_words
			_lines[i] = _total_lines
		
		var words := {}
		for i in _chars.size():
			var w := _words[i]
			var c := stripped[i]
			words[w] = words.get(w, "") + c
	prints(label.name, "Animator Waypoints: ", _waypoints, label.get_parsed_text().c_escape())
	
#region Internal
func _property_can_revert(property: StringName) -> bool:
	return RTxtAnimator.new().get(property) != null

func _property_get_revert(property: StringName) -> Variant:
	return RTxtAnimator.new().get(property)

func _get_property_list() -> Array[Dictionary]:
	var files := Array(DirAccess.get_files_at("res://addons/richer_text/text_effects/anims"))\
		.filter(func(x: String): return x.begins_with("rte_") and x.ends_with(".gd"))\
		.map(func(x: String): return x.trim_prefix("rte_").trim_suffix(".gd"))
	var list := EditorProperties.new(super())\
		.button(&"_tool_button_advance", "Advance")\
		.button(&"_tool_button_reset", "Reset")\
		.string_enum(&"animation", files)\
		.number_range(&"progress")\
		.integer_enum(&"unit", Unit)\
		.number(&"duration")\
		.number(&"delay")\
		.integer_enum(&"new_line_style", NewLineStyle)\
		.tween_trans(&"trans")\
		.tween_ease(&"ease")\
		.group("Continue Arrow", "arrow_")\
		.node_path(&"arrow_node_path", "CanvasItem")\
		.prop(&"arrow_offset", TYPE_VECTOR2)\
		.integer_enum(&"arrow_alignment", IndicatorAlignment)\
		.boolean(&"arrow_show_on_finished")\
		.group("Alphas", "alphas_")\
		.end()
	for i in _alphas.size():
		list.append({ name="alphas_%s" % i, type=TYPE_FLOAT, hint=PROPERTY_HINT_RANGE, hint_string="0.0,1.0" })
	return list

func _get(property: StringName) -> Variant:
	if property.begins_with("alphas_"):
		var index := int(property.trim_prefix("alphas_"))
		return _alphas[index] if index < _alphas.size() else 1.0
	return

func _set(property: StringName, value: Variant) -> bool:
	if property.begins_with("alphas_"):
		var index := int(property.trim_prefix("alphas_"))
		if index < _alphas.size():
			_alphas[index] = value
		return true
	return false
#endregion

```

# res://addons/richer_text/scripts/rtxt_char_fx_transform.gd
```gd
class_name RTxtCharFXTransform extends CharFXTransform

var outline_color: Color
var bg_color: Color
var fg_color: Color
var outline_states: Array[Dictionary]

```

# res://addons/richer_text/scripts/rtxt_continue_arrow.gd
```gd
@tool
class_name RTxtContinueArrow extends CanvasItem
## Simple base class for an indicator to be displayed at the end of the RicherTextLabel.

signal enabled()
signal disabled()

func _ready() -> void:
	var anim := get_animation()
	if anim:
		anim.indicator_enabled.connect(enabled.emit)
		anim.indicator_disabled.connect(disabled.emit)

func get_animation() -> RTxtAnimator:
	var parent := get_parent()
	if parent is RicherTextLabel:
		return (parent as RicherTextLabel).get_animation()
	return null

```

# res://addons/richer_text/scripts/rtxt_curver.gd
```gd
@tool
class_name RTxtCurver extends RTxtModifier

@export_node_path("Path2D") var curve: NodePath
@export_range(0.0, 1.0, 0.01) var offset := 0.0 ## Offset along the curve. Curve must be larger than text.
@export var rotate := true ## Rotate with the curve normal.
@export var skew := true ## Skew with the curve normal.
@export_range(0, 8) var increase_spaces := 0 ## Add more spaces between text.
var _sizes: PackedVector2Array

func _preparse(bbcode: String) -> String:
	label.fit_content = true
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.clip_contents = false
	
	if increase_spaces > 0:
		bbcode = bbcode.replace(" ", " ".repeat(1+increase_spaces))
	
	return "[curve id=%s]%s]" % [get_instance_id(), super(bbcode)]

func _finished():
	super()
	
	var txt := label.get_parsed_text()
	_sizes.resize(txt.length())
	var fnt := label.get_theme_default_font()
	var fnt_size := label.font_size
	var off := 0.0
	for i in txt.length():
		var chr_size := fnt.get_string_size(txt[i], HORIZONTAL_ALIGNMENT_CENTER, -1, fnt_size)
		_sizes[i] = Vector2(off, chr_size.x)
		off += chr_size.x
	
#func _get_property_list() -> Array[Dictionary]:
	#return EditorProperties.new(super())\
		#.boolean(&"position_enabled")\
		#.prop(&"position_curve", TYPE_OBJECT)\
		#.end()

```

# res://addons/richer_text/scripts/rtxt_effect.gd
```gd
@tool
@abstract class_name RTxtEffect extends RichTextEffect
## Use the _update() method.
## Designed to work like a shader: assumes char_fx is context.
## Instead of calling char_fx.color.a just call alpha.
## WARNING: When trying to animate images all we can really change is there color.
	## TODO: Write a custom drawer, make [img] transparent, and draw the controlable form overtop.

@export var tween_duration := 0.2 ## Used by JuicyLabel when transitioning to this effect.
@export var tween_trans := Tween.TRANS_LINEAR ## Used by JuicyLabel when transitioning to this effect.
@export var tween_ease := Tween.EASE_IN_OUT ## Used by JuicyLabel when transitioning to this effect.
@export_storage var _juicy: JuicyLabel
@export var outline_effect: RTxtOutlineEffect

var _char_fx: CharFXTransform

## Used to sort effects. Lower get updated sooner.
## TODO
func _get_rank_order() -> int:
	return 0

var label_richtext: RichTextLabel:
	get:
		if _juicy:
			return
		if not label_richtext:
			var rtid := get_meta(&"rt")
			if rtid:
				label_richtext = instance_from_id(rtid)
		return label_richtext

var label: RicherTextLabel:
	get: return label_richtext

var anim: RTxtAnimator:
	get: return get_instance()

var text: String = "":
	get: return _juicy.text if _juicy else label.get_parsed_text()

## Global weight scaler for effects.
var weight: float:
	get: return _juicy.effect_weight if _juicy else label.effect_weight if label else 1.0

var font: RID:
	get: return _juicy.font.get_rids()[0] if _juicy else _char_fx.font

## Ideally effects are scaled to this.
var font_size: int:
	get: return _juicy.font_size if _juicy else label.parser.font_size if label and label.parser else 16

var font_height: float:
	get:
		var ts := TextServerManager.get_primary_interface()
		return ts.font_get_ascent(font, font_size) + ts.font_get_descent(font, font_size)

func is_image() -> bool:
	return false if _juicy else _char_fx.glyph_index == 0 and _char_fx.range.x in label._image_keys

var color: Color:
	get: return _char_fx.color if _juicy or not is_image() else Color.WHITE 
	set(c):
		if _juicy or not is_image():
			_char_fx.color = c
		else:
			label.update_image(_char_fx.range.x, RichTextLabel.UPDATE_COLOR, null, 0, 0, c)

## Get/set character transparency.
var alpha: float:
	get: return color.a
	set(a): color = Color(color, a)

## Index in a styled block.
var index: int:
	get: return _char_fx.relative_index

var range: Vector2i:
	get: return _char_fx.range

## Index in the full text.
## For _juicy this will absolute_index == index.
var absolute_index: int:
	get: return _char_fx.range.x

## Get/set actual character string. (Changing this isn't ideal for non-monospaced fonts.)
var chr: String:
	get: return text[absolute_index]
	set(c):
		var text_server = TextServerManager.get_primary_interface()
		var new_glyph := text_server.font_get_glyph_index(font, font_size, c.unicode_at(0), 0)
		_char_fx.glyph_index = new_glyph

## Previous character in the text.
var chr_prev: String:
	get: return text[absolute_index-1] if absolute_index-1 > 0 else ""

## Next character in the text.
var chr_next: String:
	get: return text[absolute_index+1] if absolute_index+1 < text.length() else ""

## Size of this specific character. Use label.size for 
var size: Vector2:
	get:
		if _juicy: return _juicy._rects[index].size
		if is_image(): return Vector2(font_size, font_size)
		var ts := TextServerManager.get_primary_interface()
		return ts.font_get_glyph_size(font, Vector2i(font_size, 0), _char_fx.glyph_index)

var transform: Transform2D:
	get: return _char_fx.transform
	set(t): _char_fx.transform = t

var position: Vector2:
	get: return transform.origin
	set(o): transform.origin = o

var scale: Vector2:
	get: return transform.get_scale()
	set(s): transform *= Transform2D.IDENTITY.scaled(s)

var rotation: float:
	get: return transform.get_rotation()
	set(r): transform = Transform2D(r, transform.origin)

var skew: float:
	get: return _char_fx.transform.get_skew()
	set(s):
		var t := transform
		transform = Transform2D(t.get_rotation(), t.get_scale(), s, t.get_origin())

var skew_y: float:
	get:
		# Extract from basis
		return atan2(transform.y.x, transform.y.y)
	set(s):
		var t := transform
		var shear := Transform2D(Vector2(1, tan(s)), Vector2(0, 1), Vector2.ZERO)  
		var new_basis := Transform2D(t.get_rotation(), Vector2.ZERO)
		new_basis = new_basis.scaled(t.get_scale())
		new_basis = shear * new_basis
		transform = Transform2D(new_basis.x, new_basis.y, t.get_origin())

func skew_pivoted(sk: float, pivot: Vector2):
	var t := transform
	var p := (Vector2(0.5, 0.5) - pivot) * size
	transform *= Transform2D.IDENTITY.translated(-p)
	transform *= Transform2D(Vector2(1.0, 0.0), Vector2(tan(sk), 1.0), Vector2.ZERO)
	transform *= Transform2D.IDENTITY.translated(p)

## Prefer using position or transform.origin.
var offset: Vector2:
	get: return _char_fx.offset
	set(o): _char_fx.offset = o

## The alpha of the character. Used in animations.
## Only works for RichTextAnimation effects.
var delta: float:
	get:
		if anim and _char_fx.range.x < anim._alphas.size():
			return anim._alphas[_char_fx.range.x]
		return 1.0

## Local mouse position.
## This function seems slow, so we attempt to cache it.
## It might not work if the first character in an effect doesn't try to access it.
var mouse: Vector2:
	get:
		if _juicy: return _juicy._smoothed_mouse_position
		if index == 0:
			mouse = label.get_local_mouse_position()
		return mouse

## Distance from character to the cursor.
var cursor_delta: Vector2:
	get:
		var off := (position - mouse)
		off.x = (off.x / font_size) / (1 + abs(off.x / font_size))
		off.y = (off.y / font_size) / (1 + abs(off.y / font_size))
		return off

## Distance from character to the center of the label.
var center_delta: Vector2:
	get:
		if _juicy: return (position - _juicy.size * .5) / font_size
		return (position - label.size * .5) / font_size

## Elapsed time. Useful for animations.
var time: float:
	get: return _juicy._anim if _juicy else _char_fx.elapsed_time


func rotate(angle: float):
	var cs := size * Vector2(0.5, -0.5)
	_char_fx.transform *= Transform2D.IDENTITY.translated(cs)
	_char_fx.transform *= Transform2D.IDENTITY.rotated_local(angle)
	_char_fx.transform *= Transform2D.IDENTITY.translated(-cs)

## Prefer overriding this instead of _process_custom_fx()
func _update() -> bool:
	return true

## Prefer overriding _update().
func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	_char_fx = char_fx
	var updated := _update()
	if updated and outline_effect:
		outline_effect._char_fx = char_fx
		return outline_effect._update()
	return updated

func get_var(key: StringName, default: Variant = null) -> Variant:
	return _char_fx.env.get(key, default)

func get_int(key: StringName = &"id", default := 0) -> int:
	return _char_fx.env.get(key, default)

func get_float(key: StringName, default := 0.0) -> float:
	return _char_fx.env.get(key, default)

func get_bool(key: StringName, default := true) -> bool:
	return _char_fx.env.get(key, default)

func get_str(key: StringName, default := "") -> String:
	return _char_fx.env.get(key, default)

func get_vec2(key: StringName, default := Vector2.ZERO) -> Vector2:
	return _char_fx.env.get(key, default)

func get_instance(key := &"id", default: Object = null) -> Object:
	if key in _char_fx.env:
		return instance_from_id(int(_char_fx.env[key]))
	return default

## Returns: 0.0 to TAU
func rnd(freq := 1.0, seed := 0.0) -> float:
	return fmod(float(index * freq + seed) * 12.9898, TAU)

## Seed gets offset by elapsed_time.
## Returns: 0.0 - 1.0.
func rnd_time(freq := 1.0, seed := 0.0) -> float:
	return rnd(freq, seed + time) / TAU

## Returns: -1.0 to 1.0
func rnd_smooth(speed := 1.0, freq := 1.0, seed := 0.0) -> float:
	var phase := rnd(freq, seed)
	var t := time * speed
	return sin(t + phase) * 0.5 + sin(t * 1.73 + phase * 2.31) * 0.5

## Unsigned version: 0.0 to 1.0
func rnd_smoothu(speed := 1.0, freq := 1.0, seed := 0.0) -> float:
	return rnd_smooth(speed, freq, seed) * .5 + .5

## Lerp between a basic sin() and a noise()
func rnd_noise(amount: float, speed := 1.0, freq := 1.0, seed := 0.0) -> float:
	var base := sin(time * speed + (index * freq + seed) * 12.9898)
	return lerpf(base, rnd_smooth(speed, freq, seed), amount)

## Returns the last characters transformation so we can use it for end of text animations.
## Should be applied last (so in an animation effect)
func _send_transform_back():
	if is_image():
		return
	
	var index := _char_fx.relative_index
	if index > 0 and index < anim._transforms.size():
		var ts := TextServerManager.get_primary_interface()
		var fsize := font_size
		var off_x := ts.font_get_glyph_size(font, Vector2i(fsize, 0), _char_fx.glyph_index).x
		var off_y := ts.font_get_ascent(font, fsize) - ts.font_get_descent(font, fsize)
		anim._char_size[index] = Vector2(off_x, off_y)
		anim._transforms[index] = _char_fx.transform

func cycle_colors(colors: PackedColorArray, t: float, default := Color.WHITE) -> Color:
	var n = colors.size()
	if n == 0: return default
	var idxf := fmod(t, float(n))
	var i := int(floor(idxf))
	var frac := idxf - float(i)
	var c1 = colors[i]
	var c2 = colors[(i + 1) % n]
	return lerp_hsv(c1, c2, frac)

func lerp_hsv(c1: Color, c2: Color, t: float) -> Color:
	var h1 = c1.h
	var h2 = c2.h
	var s1 = c1.s
	var s2 = c2.s
	var v1 = c1.v
	var v2 = c2.v
	var a1 = c1.a
	var a2 = c2.a
	var dh = fmod(h2 - h1 + 1.5, 1.0) - 0.5
	var h = fmod(h1 + dh * t, 1.0)
	var s = lerpf(s1, s2, t)
	var v = lerpf(v1, v2, t)
	var a = lerpf(a1, a2, t)
	return Color.from_hsv(h, s, v, a)

func ease_back(x: float) -> float:
	const c1 := 1.70158
	const c2 := c1 * 1.525
	if x < 0.5:
		return (pow(2.0 * x, 2.0) * ((c2 + 1.0) * 2.0 * x - c2)) / 2.0
	return (pow(2.0 * x - 2.0, 2.0) * ((c2 + 1.0) * (x * 2.0 - 2.0) + c2) + 2.0) / 2.0

func ease_back_out(x: float, c1 := 1.70158) -> float:
	var c3 := c1 + 1
	return 1.0 + c3 * pow(x - 1.0, 3.0) + c1 * pow(x - 1.0, 2.0)

```

# res://addons/richer_text/scripts/rtxt_link_list.gd
```gd
@tool
class_name RTxtLinkList extends RTxtModifier
## Treats each line as a link, and calls

@export var use_signals := true ## Will fire link_hovered, link_unhovered.
@export var use_tooltip_text := true ## Will set labels tooltip_text, causing a popup to show.
@export var can_right_click := false
var tooltips: Dictionary[String, String]

func _preparse(bbcode: String) -> String:
	tooltips.clear()
	var lines := bbcode.strip_edges().split("\n")
	for i in lines.size():
		var parts := lines[i].split("|", true, 1)
		var id := parts[0].to_kebab_case()
		var tooltip := ""
		if parts.size() == 2:
			tooltip = parts[1]
		tooltips[id] = tooltip
		lines[i] = "[=call:%s:_clicked:%s]%s]" % [get_instance_id(), id, tr(parts[0], &"main_menu")]
	return "\n".join(lines)

func _clicked(id: String):
	label.link_clicked.emit(id)
	return true

func _clicked_right_clicked(id: String):
	if can_right_click:
		label.link_right_clicked.emit(id)
		return true
	return false

func _clicked_hovered(id: String):
	if use_signals:
		label.link_hovered.emit(id)
		return true
	if use_tooltip_text:
		return tooltips.get(id, "")
	return ""

func _clicked_unhovered(id: String):
	if use_signals:
		label.link_unhovered.emit(id)
		return true
	if use_tooltip_text:
		return ""
	return ""

```

# res://addons/richer_text/scripts/rtxt_modifier.gd
```gd
@tool
@abstract class_name RTxtModifier extends Resource

## Modifier will preparse bbcode.
var enabled := true:
	set(e):
		enabled = e
		changed.emit()

@export_storage var label: RicherTextLabel

## Called before set_text()
func _preparse(bbcode: String) -> String:
	label.bbcode_enabled = true
	return bbcode

## Called when text is done processing.
func _finished():
	pass

func _debug_draw(rtl: RicherTextLabel):
	pass

func _get_property_list() -> Array[Dictionary]:
	return [{ name=&"enabled", type=TYPE_BOOL, hint=PROPERTY_HINT_GROUP_ENABLE }]

```

# res://addons/richer_text/scripts/rtxt_outline.gd
```gd
class_name RTxtOutline extends Resource

enum Style { OUTLINE, TEXT, OUTLINE_AND_TEXT }

@export var style := Style.OUTLINE
@export var size := 2.0
@export var color := Color.WHITE
@export var position := Vector2.ZERO
@export_range(-180, 180, 1.0, "radians_as_degrees") var rotation := 0.0
@export var skew := 0.0
@export var scale := Vector2.ONE

```

# res://addons/richer_text/scripts/rtxt_outline_effect.gd
```gd
@abstract class_name RTxtOutlineEffect extends RTxtEffect

```

# res://addons/richer_text/scripts/rtxt_parser.gd
```gd
@tool
class_name RTxtParser extends Resource

"""
TODO:
	- fill stack w tags, but never push them until you get to text
		- before printing, allow for tag sorting, so certain effects can run before others
		- when closing a stack, remember the order of the printing
		- when doing an old fashioned close [/tag], reprint opening tags, so you can do mixed order [b]bold[i]bold italic[/b]italic[/i]
			mixed order currently isn't allowed in godot, but shouldn't be impossible to implement
"""

static var link_hovered: Signal = _add_signal(&"url_hovered", { label=TYPE_OBJECT, link_index=TYPE_INT })
static var link_unhovered: Signal = _add_signal(&"url_unhovered", { label=TYPE_OBJECT, link_index=TYPE_INT })
static var link_clicked: Signal = _add_signal(&"url_clicked", { label=TYPE_OBJECT, link_index=TYPE_INT })
static var link_right_clicked: Signal = _add_signal(&"url_right_clicked", { label=TYPE_OBJECT, link_index=TYPE_INT })
static var _get_all_rtp: Signal = _add_signal(&"get_all_rtp")
signal started()
signal install_effect(effect)
signal changed_font()
signal changed_font_size()
signal changed_outline()

const EXT_IMAGE: PackedStringArray = ["png", "jpg", "jpeg", "webp", "svg"]
const EXT_AUDIO: PackedStringArray = ["mp3", "ogg", "wav"]
const FONT_BOLD_WEIGHT := 1.2
const FONT_ITALICS_SLANT := 0.25
const FONT_ITALICS_WEIGHT := -.25
const FONT_SIZE_MIN := 8
const FONT_SIZE_MAX := 128
const BBCODE_BUILTIN: PackedStringArray = ["b", "i", "u", "s", "left", "right", "center", "fill", "url"]
const DIR := "res://addons/richer_text/"
const DIR_TEXT_EFFECTS := DIR + "text_effects/effects"
const DIR_TEXT_ANIMATIONS := DIR + "text_effects/anims"
const DIR_TEXT_MODIFIERS := DIR + "text_effects/mods"
const PATH_EMOJIS := DIR + "emoji.json"
const PATH_DEFAULT_PARSER := "res://assets/richer_text_parser.tres"
static var REGEX_REPLACE_CONTEXT := RegEx.create_from_string(r"(?<!\\)@(?:[a-zA-Z][a-zA-Z0-9_]*|-?\d+)(?:\.[a-zA-Z0-9_]+)*(?:\([^\)]*\))?(?![^\[\]]*\])")
static var REGEX_REPLACE_CONTEXT_2 := RegEx.create_from_string(r"\{.*?\}")
static var REGEX_EMOJI := RegEx.create_from_string(r"~[a-zA-Z0-9/_-]+(?=\b|[^a-zA-Z0-9/_-])")
static var REGEX_NODE_OR_OBJECT := RegEx.create_from_string(r"(?:([A-Za-z0-9_]+):)?<([A-Za-z0-9_]+)#(-?\d+)>")
static var REGEX_TAG_HEAD := RegEx.create_from_string("^[/=!]?(\\w+)") # [tag] [tag=true] [tag prop=true] all return "tag"
static var REGEX_URL := RegEx.create_from_string(r"\[url(?:=([^\]]+)| ([^\]]+))?\](.*?)(?:\[/url\]|\[\]|(?<=\S)\])")

enum OutlineMode {
	OFF, ## Disables outline.
	DARKEN, ## Outlines will be darker than text color.
	LIGHTEN, ## Outlines will be lighter than text color.
	CUSTOM, ## Uses outline_color for all text.
	CUSTOM_DARKEN, ## Uses outline_color by default, but darkens colored text outlines.
	CUSTOM_LIGHTEN, ## Uses outline_color by default, but lightens colored text outlines.
}

var _state: Dictionary
var _stack: Array[Dictionary]
var _effects: Dictionary
var _output: PackedStringArray
var _output_stripped: PackedStringArray
var _context_node: Node
var _expression_error := OK
var _links: Dictionary[int, String]
var _offset: int
var _waypoints: Dictionary[int, String]

@export_group("Test", "test_")
@export_multiline var test_string := ""
@export_multiline var test_string_output := ""
@export_multiline var test_string_output_stripped := ""
@export_tool_button("Test") var test_button := func(): parse(test_string)

@export var colors_custom: Dictionary[StringName, Color]
@export var colors_allow_builtin := true ## Use built in colors?

@export var bbcode_shortcuts: Dictionary[StringName, String] ## Merge many tags into an easy to remember tag: [mytag] -> [b;custom_font;red]

## Pre-parsers run before anything else happens.
@export var regexes: Array[RTxtParserRegex]
@export_dir var custom_effects_dir := "res://assets/richer_text_effects"

#region Font
## Resource that stores font paths for easy picking.
var font_db: FontDB = FontDB.get_default()

## Primary font to use.
var font_default: StringName:
	set(f):
		font_default = f
		changed_font.emit()

## Default color used.
var font_color := Color.WHITE:
	set(c):
		font_color = c
		changed_font.emit()

## Default size.
## Use float tags [2.0] to resize relative.
## Use int tags [32] to resize absolute.
var font_size := 32:
	set(x):
		font_size = clampi(x, FONT_SIZE_MIN, FONT_SIZE_MAX)
		changed_font_size.emit()

## Custom font thickness when using bold tag.
var font_bold_weight := 1.5:
	set(f):
		font_bold_weight = f
		changed_font.emit()
		
## Custom font slant when using italics tag. (Can be negative.)
var font_italics_slant := 0.25:
	set(f):
		font_italics_slant = f
		changed_font.emit()

## Custom font thickness when using italics tag.
var font_italics_weight := -.25:
	set(f):
		font_italics_weight = f
		changed_font.emit()
#endregion

#region Emoji
## Path to emoji font.
var emoji_font: String

## Relative to font_size.
## Used with bbcode :banana:.
var emoji_scale := 1.0:
	set(x):
		emoji_scale = x
		changed.emit()

## Allow using the :emoji: pattern for including images.
var emoji_images := true

## Directory to look for images inside of. 
var emoji_images_dir := "res://"

#endregion

#region Outline
var outline_size := 0:
	set(o):
		outline_size = o
		changed.emit()
		changed_outline.emit()

## Automatically colorize outlines based on font color.
var outline_mode: OutlineMode = OutlineMode.DARKEN:
	set(o):
		outline_mode = o
		changed.emit()
		changed_outline.emit()
		notify_property_list_changed()

## Used with OutlineMode.CUSTOM, OutlineMode.CUSTOM_DARKEN, OutlineMode.CUSTOM_LIGHTEN.
var outline_color := Color.BLACK:
	set(x):
		outline_color = x
		changed.emit()
		changed_outline.emit()
		#_update_theme_outline()

## How much to shift outline color.
var outline_adjust := 0.8:
	set(x):
		outline_adjust = x
		changed.emit()
		changed_outline.emit()
		#_update_theme_outline()

## Nudges the tint of the outline so it isn't identical to the font.
## Produces more contrast.
var outline_hue_adjust := 0.0125:
	set(x):
		outline_hue_adjust = x
		changed.emit()
		changed_outline.emit()
		#_update_theme_outline()
#endregion

#region Markdown
var markdown_enabled := true
var markdown_custom: Dictionary[String, String] = {
	"*": "[i]%s]",
	"**": "[b]%s]",
	"***": "[b;i]%s]",
	"~": "[s]%s]",
	'"': "“%s”"
}
#endregion

#region Context
## Uses @pattern and {pattern} to replace text with state data.
## Can be call a method: "I have @player.item_count("coins") coins."
## Even array elements: "Slot 3 has @slots[3] in it.
## When only a method name is passed it will be automatically called.
var context_enabled := false
## The main node to get properties from.
var context_path: NodePath = ^"/root/State"
## Access autoloads like in regular gdscript: @Global.get_tree().get_nodes_in_group("chars")
var context_allow_autoloads := true
## Access classes like in regular gdscript.
var context_allow_global_classes := true
## Access `Engine` and other built in singletons.
var context_allow_engine_singletons := true
## Allowed globals. If none set all will be allowed.
var context_classes_allowed: PackedStringArray
## Blocked globals. If none set all will be allowed.
var context_classes_blocked: PackedStringArray
## Extra properties you can access inside the expressions.
var context_state: Dictionary[StringName, Variant]
## Will attempt to call `to_richtext()` on objects.
## If that doesn't work it looks for a `name` property.
## Otherwise `to_string()` is used.
var context_rich_objects := true
## Will automatically add commas to integers: 1234 -> 1,234
var context_rich_ints := true
## Will display an array as comma seperated items.
## Uses rich_objects and rich_ints if they are enabled.
var context_rich_array := true
#endregion

#region Link
var link_effect: RTxtLinkEffect ## Effect to animated links on hover & clicked.
var link_cursor := Input.CURSOR_POINTING_HAND
var link_tooltip_cursor := Input.CURSOR_HELP
var link_tooltip_scene: String ## TODO: Not implemented. Custom scene to load instead of the default tooltip.
var link_audio_enabled := true ## Enable audio for link on hover & clicked.
var link_audio_path_hovered := "" ## Sound played on hovered.
var link_audio_path_unhovered := "" ## Sound played on unhovered.
var link_audio_path_clicked := "" ## Sound played on clicked.
var link_audio_path_right_clicked := "" ## Sound played on right clicked.
var link_audio_path_tooltip_hovered := "" ## Sound played on tooltip hovered.
var link_audio_path_tooltip_unhovered := "" ## Sound played on tooltip unhovered.
#endregion

## Try to find a default parser resource in the "res://assets/" folder.
static func get_default() -> RTxtParser:
	if Engine.is_editor_hint():
		if not FileAccess.file_exists(PATH_DEFAULT_PARSER):
			if not DirAccess.dir_exists_absolute(PATH_DEFAULT_PARSER.get_base_dir()):
				DirAccess.make_dir_recursive_absolute(PATH_DEFAULT_PARSER.get_base_dir())
			var parser := RTxtParser.new()
			var err := ResourceSaver.save(parser, PATH_DEFAULT_PARSER)
			if err != OK:
				push_error("Parser: ", error_string(err))
	return load(PATH_DEFAULT_PARSER)

func parse(input: String, context_node: Node = null, links: Dictionary[int, String] = {}) -> String:
	_context_node = context_node
	_links = links
	_links.clear()
	_offset = 0
	_waypoints.clear()
	
	started.emit()
	
	var output := input
	
	# Replace any links that may already exist.
	output = _replace(output, REGEX_URL, func(rm: RegExMatch):
		var link_index := _add_link(rm.strings[1])
		return "[link id=%s]%s[/link]" % [link_index, rm.strings[3]])
	
	# Replace Godot node and object strings
	# Label:<MyLabel#32152512341241>
	# <MyObject#5324326132309>
	output = _replace(output, REGEX_NODE_OR_OBJECT, func(rm: RegExMatch): return "@%s" % rm.strings[3])
	
	# User defined parsers.
	for rep in regexes:
		output = rep._run(output, self)
	
	# Context replace.
	if context_enabled and _context_node:
		# @pattern
		output = _replace(output, REGEX_REPLACE_CONTEXT, func(rm: RegExMatch): return _expression_rich(rm.strings[0], rm.strings[0].trim_prefix("@")))
		
		# {} pattern
		output = _replace(output, REGEX_REPLACE_CONTEXT_2, func(rm: RegExMatch): return _expression_rich(rm.strings[0], str_unwrap(rm.strings[0], "{}")))
	
	# Emojis
	output = _replace(output, REGEX_EMOJI, func(rm: RegExMatch):
		var emoji_id := rm.strings[0].trim_prefix("~")
		for ext in EXT_IMAGE:
			var img_path := "%s%s.%s" % [emoji_images_dir, emoji_id, ext]
			if FileAccess.file_exists(img_path):
				var height := font_size * emoji_scale
				return "[img height=%s]%s[/img]" % [height, img_path]
		var json := FileAccess.get_file_as_string(PATH_EMOJIS)
		var data := JSON.parse_string(json)
		if data and emoji_id in data.named:
			return data.named[emoji_id]
		return rm.strings[0])
	
	if markdown_enabled:
		var keys := markdown_custom.keys()
		keys.sort_custom(func(a, b): return a.length() > b.length())
		for key in keys:
			output = _replace_wrapped(output, key, markdown_custom[key])
	
	_clear()
	var i := 0
	var n := output.length()
	while i < n:
		var ch := output[i]
		if ch == "[":
			var j := i+1
			var closed := false
			while j < n:
				var chj := output[j]
				if chj == "]":
					closed = true
					break
				j += 1
			var inner := output.substr(i+1, j-i-1)
			if closed:
				_tags(inner)
			else:
				_add_text(inner)
			i = j
		elif ch == "]":
			if _stack:
				_pop_last()
		elif ch == "<":
			var j := i+1
			var closed := false
			while j < n:
				var chj := output[j]
				if chj == ">":
					closed = true
					break
				j += 1
			var inner := output.substr(i+1, j-i-1)
			if closed:
				_waypoints[_offset] = inner
			else:
				_add_text(inner)
			i = j
		else:
			_add_text(ch)
		i += 1
	output = "".join(_output)
	
	test_string_output = output
	test_string_output_stripped = "".join(_output_stripped)
	_clear()
	_context_node = null
	_links = {}
	
	return output

func prnt(...args):
	print_rich(parse("".join(args)))

func prnts(...args):
	print_rich(parse(" ".join(args)))

func _clear():
	_state = {}
	_stack = []
	_output = []
	_output_stripped = []
	_effects.clear()

func _pop_last():
	if _stack:
		var keys := _stack[-1].keys()
		for i in range(keys.size()-1, -1, -1):
			_remove_tag(keys[i])
		_stack.pop_back()

func _add_tag(tag: String, is_first_tag := false, tag_state: Variant = null) -> bool:
	if not tag in _state:
		if is_first_tag:
			_stack.append({})
			is_first_tag = false
		_state[tag] = tag_state
		_stack[-1][tag] = tag_state
		if tag_state is String:
			_output.append("[%s]" % tag_state)
		elif tag_state is Dictionary:
			_output.append("[%s]" % (_state_to_tag_str(tag_state)))
		else:
			_output.append("[%s]" % tag)
	return is_first_tag

func _remove_tag(tag: String):
	if tag in _state:
		_state.erase(tag)
	for i in range(_stack.size()-1, -1, -1):
		if tag in _stack[i]:
			_stack[i].erase(tag)
			_output.append("[/%s]" % tag)
			break

func _add_text(txt: String):
	_output.append(txt)
	_output_stripped.append(txt)
	_offset += txt.length()

func _tags(tag_str: String):
	var tags: PackedStringArray
	for tag in tag_str.split(";"):
		if tag in bbcode_shortcuts:
			tags.append_array(bbcode_shortcuts[tag].split(";"))
		else:
			tags.append(tag)
	
	var is_first_tag := true
	for full_tag in tags:
		var rm := RegEx.create_from_string(r"^[/=!]?[^\]\s]+").search(full_tag)
		var tag := rm.strings[0] if rm else ""
		if not rm:
			_add_text(full_tag)
		elif tag == "":
			_pop_last()
		elif tag.begins_with("="):
			var index := _add_link(full_tag.substr(1))
			is_first_tag = _add_tag("link", is_first_tag, "link id=%s" % index)
		elif tag.begins_with("/"):
			var open_tag := tag.substr(1)
			if open_tag in BBCODE_BUILTIN:
				_remove_tag(open_tag)
			else:
				var state := _get_tag_state(open_tag, full_tag.substr(1))
				if state:
					for item in (state if state is Array else [state]):
						_remove_tag(item.tag)
				else:
					_add_text("[%s]" % full_tag)
		else:
			if tag in BBCODE_BUILTIN:
				is_first_tag = _add_tag(tag, is_first_tag, full_tag)
			else:
				var state := _get_tag_state(tag, full_tag)
				if state:
					for item in (state if state is Array else [state]):
						is_first_tag = _add_tag(item.tag, is_first_tag, item)
				else:
					_add_text("[%s]" % full_tag)

func _add_link(data: Variant) -> int:
	var link_index := _links.size()
	if data is Object:
		_links[link_index] = "id:%s" % (data as Object).get_instance_id()
	elif not data is String:
		_links[link_index] = JSON.stringify(data, "", false)
	else:
		_links[link_index] = data
	return link_index

## Returns a Dictionary or Array of Dictionaries.
func _get_tag_state(tag: String, full_tag: String) -> Variant:
	# Links to functions.
	if tag.begins_with("!"):
		var parts := tag.trim_prefix("!").split(" ")
		var method: Callable = _expression(parts[0])
		var obj_id := method.get_object_id()
		var meth_name := method.get_method()
		var meth_args := "&".join(parts.slice(1))
		var link_index := _add_link("call:%s:%s:%s" % [obj_id, meth_name, meth_args])
		return [{ tag="link", id=link_index }]
	
	# Effects.
	var effect := _to_effect(tag)
	if effect != null:
		if tag != "link" and not tag in _effects:
			_effects[tag] = true
			install_effect.emit(effect)
		return { tag=tag, _rest=full_tag }
	
	var flt := _to_float(tag)
	if flt != null:
		return { tag="font_size", font_size=int(font_size * flt) }
	
	if tag.is_valid_int():
		return { tag="font_size", font_size=font_size+int(tag) }
	
	var fnt := null if not font_db else font_db.paths.get(tag, null)
	if fnt != null:
		return { tag="font", font=fnt }
	
	var clr := _to_color(tag)
	if clr != Color.TRANSPARENT:
		if " " in full_tag:
			var clr2_str := tag.split(" ", true, 1)[-1]
			var clr2 := _to_color(clr2_str)
			if clr2 == Color.TRANSPARENT:
				# ERROR: Color was malformed.
				clr2 = clr.darkened(0.5)
			if outline_size == 0:
				return [
					{ tag="outline_size", outline_size=4 },
					{ tag="color", color=clr },
					{ tag="outline_color", outline_color=clr2 } ]
			else:
				return [
					{ tag="color", color=clr },
					{ tag="outline_color", outline_color=clr2 } ]
		else:
			if outline_size != 0:
				return [
					{ tag="color", color=clr },
					{ tag="outline_color", outline_color=clr.darkened(0.5) }
				]
			else:
				return { tag="color", color=clr }
	
	return {}

func _state_to_tag_str(state: Dictionary) -> String:
	if "_rest" in state:
		return state._rest
	
	var out: PackedStringArray = []
	if not state.tag in state:
		out.append(state.tag)
	for key in state:
		if key != &"tag":
			match typeof(state[key]):
				TYPE_COLOR: out.append("%s=#%s" % [key, (state[key] as Color).to_html(false)])
				_: out.append("%s=%s" % [key, state[key]])
	return " ".join(out)

func _to_effect(tag: String) -> RichTextEffect:
	for dir in [DIR_TEXT_EFFECTS, DIR_TEXT_ANIMATIONS, DIR_TEXT_MODIFIERS, custom_effects_dir]:
		if not dir:
			continue
		for ext in ["gd", "gdc"]:
			var path = dir.path_join("rte_%s.%s" % [tag, ext])
			if FileAccess.file_exists(path):
				var effect: RichTextEffect = load(path).new()
				effect.resource_name = tag
				effect.setup_local_to_scene()
				return effect
	return null
	
func _to_float(tag: String) -> Variant:
	if "." in tag:
		for c in tag:
			if not c in "0123456789.":
				return null
		return float(tag)
	return null

func _to_color(tag: String, default := Color.TRANSPARENT) -> Color:
	# Check if raw color was passed.
	if tag.begins_with("(") and tag.ends_with(")"):
		var floats := str_unwrap(tag, "()").split_floats(",")
		return Color(floats[0], floats[1], floats[2], floats[3])
	# 1st check custom colors.
	if tag in colors_custom:
		return colors_custom[tag]
	# 2nd check builtin colors.
	if colors_allow_builtin:
		return Color().from_string(tag, default)
	return default

func _regex_escape(s: String) -> String:
	var specials := ".*+?^${}()|[]\\"
	var out := ""
	for c in s:
		if specials.find(c) != -1:
			out += "\\" + c
		else:
			out += c
	return out

func _rich_variant(thing: Variant) -> String:
	if thing is Callable:
		return _rich_variant(thing.call())
	if context_rich_ints and typeof(thing) == TYPE_INT:
		return str_commas(thing)
	if context_rich_objects and typeof(thing) == TYPE_OBJECT:
		var output := ""
		if thing.has_method(&"to_richtext"):
			output = thing.to_richtext()
		elif &"name" in thing:
			output = thing.name
		else:
			output = str(thing)
		
		var is_link := false
		if thing.has_method(&"_richtext_clicked"):
			var link_index := _add_link(thing)
			output = "[link id=%s]%s[/link]" % [link_index, output]
			is_link = true
		
		if not is_link and &"tooltip_text" in thing:
			output = "[hint=%s]%s[/hint]" % [thing.tooltip_text, output]
		
		return output
	if context_rich_array and typeof(thing) == TYPE_ARRAY:
		return ", ".join(Array(thing).map(_rich_variant))
	return str(thing)

func _expression_rich(exp: String, exp_clean: String, state2 := {}) -> String:
	var value: Variant
	# Passed an instance id number?
	if exp_clean.is_valid_int():
		value = instance_from_id(int(exp_clean))
	# Property or method of instance id number?
	elif "." in exp_clean and exp_clean.split(".", true, 1)[0].is_valid_int():
		var parts := exp_clean.split(".", true, 1)
		var instance := instance_from_id(int(parts[0]))
		var new_exp_clean := "_MYINST_.%s" % parts[1]
		value = _expression(new_exp_clean, { _MYINST_=instance })
	else:
		value = _expression(exp_clean, state2)
	return _rich_variant(value) if _expression_error == OK else ("[red]%s]" % exp)

func _replace(text: String, re: RegEx, call: Callable) -> String:
	var offset := 0
	var output: PackedStringArray
	while offset < text.length() and re:
		var rm := re.search(text, offset)
		if rm:
			output.append(text.substr(offset, rm.get_start() - offset))
			output.append(call.call(rm))
			offset = rm.get_end()
		else:
			output.append(text.substr(offset))
			offset = text.length()
	return "".join(output)

func _replace_wrapped(text: String, tag: String, format: String) -> String:
	return _replace_between(text, tag, tag, func(rm: RegExMatch): return format % rm.get_string(1))

func _replace_between(text: String, head: String, tail: String, call: Callable) -> String:
	var esc_head := _regex_escape(head)
	var esc_tail := _regex_escape(tail)
	var re := RegEx.create_from_string(esc_head + r"(.*?)" + esc_tail)
	return _replace(text, re, func(rm: RegExMatch): return call.call(rm))

func _expression(ex: String, state2 := {}) -> Variant:
	var context: Object = null
	if _context_node and _context_node.is_inside_tree():
		context = _context_node.get_tree().root.get_node(context_path)
	else:
		var local := get_local_scene()
		if local:
			context = local.get_node(context_path)
	
	if not context:
		return "???"
	
	# If a pipe is present.
	if "|" in ex:
		# Get all pipes.
		var pipes := ex.split("|")
		var ex_prepipe := pipes[0]
		# Get initial value of expression.
		var got: Variant = _expression(ex_prepipe)
		for i in range(1, len(pipes)):
			var pipe_parts := pipes[i].split(" ")
			# First arg is pipe method name.
			var pipe_meth := pipe_parts[0]
			# Rest are arguments. Convert to an array.
			# Does method exist in context node?
			if context and context.has_method(pipe_meth):
				var arg_str := "[%s]" % [", ".join(pipe_parts.slice(1))]
				var pipe_args: Array = [got] + _expression(arg_str)
				got = context.callv(pipe_meth, pipe_args)
			else:
				var s2 := { "_GOT_": got }
				var arg_str := []
				for j in len(pipe_parts)-1:
					var key := "_ARG%s_" % j
					s2[key] = _expression(pipe_parts[j+1])
					arg_str.append(key)
				var p_exp := "_GOT_.%s(%s)" % [pipe_meth, ", ".join(arg_str)]
				got = _expression(p_exp, s2)
		return got
	
	_expression_error = OK
	var e := Expression.new()
	var returned: Variant = null
	var con_args := context_state.keys() if context_state else []
	var con_vals := context_state.values() if context_state else []
	
	if state2:
		con_args = con_args + state2.keys()
		con_vals = con_vals + state2.values()
	
	#TODO: Cache all these references.
	
	if context_allow_engine_singletons:
		for name in Engine.get_singleton_list():
			if context_classes_blocked and name in context_classes_blocked:
				continue
			if not context_classes_allowed or name in context_classes_allowed:
				con_args.append(name)
				con_vals.append(Engine.get_singleton(name))
	
	if context_allow_autoloads:
		for child in context.get_node("/root/").get_children():
			if "@" in child.name:
				continue
			if context_classes_blocked and child.name in context_classes_blocked:
				continue
			if not context_classes_allowed or child.name in context_classes_allowed:
				con_args.append(child.name)
				con_vals.append(child)
	
	if context_allow_global_classes:
		for data in ProjectSettings.get_global_class_list():
			if context_classes_blocked and data.class in context_classes_blocked:
				continue
			if not context_classes_allowed or data.class in context_classes_allowed:
				con_args.append(data.class)
				con_vals.append(load(data.path))
	
	_expression_error = e.parse(ex, con_args)
	if _expression_error == OK:
		returned = e.execute(con_vals, context, false)
	
	if e.has_execute_failed():
		_expression_error = FAILED
		push_error(e.get_error_text())
		return null
	
	return returned



#region String
static func str_unwrap(t: String, w: String) -> String:
	return t.trim_prefix(w[0]).trim_suffix(w[-1])

# 1234567 => 1,234,567
static func str_commas(number: Variant) -> String:
	var string := str(number)
	var is_neg := string.begins_with("-")
	if is_neg:
		string = string.substr(1)
	var mod = len(string) % 3
	var out = ""
	for i in len(string):
		if i != 0 and i % 3 == mod:
			out += ","
		out += string[i]
	return "-" + out if is_neg else out
#endregion

#region Editor
func _property_can_revert(property: StringName) -> bool:
	return RTxtParser.new().get(property) != null

func _property_get_revert(property: StringName) -> Variant:
	return RTxtParser.new().get(property)

func _get_property_list():
	var props := EditorProperties.new()\
		.group("Font", "font_")\
		.res(&"font_db", "FontDB")\
		.string_enum(&"font_default", [] if not font_db else font_db.paths.keys())\
		.integer(&"font_size")\
		.color(&"font_color")\
		.number(&"font_bold_weight")\
		.number(&"font_italics_slant")\
		.number(&"font_italics_weight")
	
	props.group("Emoji", "emoji_")\
		#.file(&"emoji_font", EXT_FONT)\
		.number_range(&"emoji_scale", 0.1, 2.0)\
		.boolean(&"emoji_images_enabled")\
		.dir(&"emoji_images_dir")
		
	props.group("Outline", "outline_")\
		.integer(&"outline_size")\
		.integer_enum(&"outline_mode", OutlineMode)
	if outline_mode in [OutlineMode.CUSTOM, OutlineMode.CUSTOM_DARKEN, OutlineMode.CUSTOM_LIGHTEN]:
		props.color(&"outline_color")
	if outline_mode in [OutlineMode.DARKEN, OutlineMode.LIGHTEN, OutlineMode.CUSTOM_DARKEN, OutlineMode.CUSTOM_LIGHTEN]:
		props.number_range(&"outline_adjust")
		props.number_range(&"outline_hue_adjust")
	
	props.group("Context", "context_")\
		.boolean(&"context_enabled")\
		.node_path(&"context_path")\
		.dict(&"context_state", "StringName;Variant")\
		.boolean(&"context_allow_autoloads")\
		.boolean(&"context_allow_global_classes")\
		.boolean(&"context_allow_engine_singletons")\
		.prop(&"context_classes_allowed", TYPE_PACKED_STRING_ARRAY)\
		.prop(&"context_classes_blocked", TYPE_PACKED_STRING_ARRAY)\
		.boolean(&"context_rich_objects")\
		.boolean(&"context_rich_ints")\
		.boolean(&"context_rich_array")
	
	props.group("Link", "link_")\
		.res(&"link_effect", "RTxtLinkEffect")\
		.enum_cursor(&"link_cursor")\
		.enum_cursor(&"link_tooltip_cursor")\
		.file(&"link_tooltip_scene", ["scn", "tscn"])\
		.boolean(&"link_audio_enabled")\
		.subgroup("Audio Paths", "link_audio_path_")\
		.file(&"link_audio_path_hovered", EXT_AUDIO)\
		.file(&"link_audio_path_unhovered", EXT_AUDIO)\
		.file(&"link_audio_path_clicked", EXT_AUDIO)\
		.file(&"link_audio_path_right_clicked", EXT_AUDIO)\
		.file(&"link_audio_path_tooltip_hovered", EXT_AUDIO)\
		.file(&"link_audio_path_tooltip_unhovered", EXT_AUDIO)
	
	return props.end()
	
#endregion

static func _add_signal(name: StringName, var_types := {}):
	var targ: Object = RTxtParser
	if not targ.has_signal(name):
		var args := []
		for var_name in var_types:
			args.append({ "name": var_name, "type": var_types[var_name] })
		targ.add_user_signal(name, args)
	return Signal(RTxtParser, name)

```

# res://addons/richer_text/scripts/rtxt_parser_regex.gd
```gd
@tool
class_name RTxtParserRegex extends Resource

## Optional. TODO
@export var id: StringName
## Disable to prevent parsing.
@export var enabled := true
## Pattern to search for.
@export var regex: String
## Returns something to replace the matched regex.
## Access the match with `rm`
## Example: "< %s >" % rm.strings[0]
@export_custom(PROPERTY_HINT_EXPRESSION, "") var expression: String
## Helpful hint at what is happening.
@export_multiline var comment: String

@export_group("Test", "test_")
@export_custom(PROPERTY_HINT_EXPRESSION, "") var test_input: String
@export_tool_button("Test") var test_button := func():
	var parser := RTxtParser.new()
	parser.regexes.append(self)
	test_output = parser.parse(test_input)
	
@export_custom(PROPERTY_HINT_EXPRESSION, "") var test_output: String

func _run(input: String, parser: RTxtParser) -> String:
	if not enabled or not regex or not expression:
		push_error("Skipping [%s] [%s] [%s]" % [not enabled, not regex, not expression])
		return input
	var reg := RegEx.create_from_string(regex)
	return parser._replace(input, reg, func(rm: RegExMatch):
		if expression.strip_edges().count("\n") > 0:
			var gd := GDScript.new()
			var lines := expression.split("\n")
			lines[-1] = "return " + lines[-1]
			gd.source_code = "static func _run(rm: RegExMatch):\n\t" + "\n\t".join(lines)
			var err := gd.reload()
			if err == OK:
				return str(gd.call(&"_run", rm))
			push_error("Modifier Error: ", error_string(err), expression)
			return "???"
		return parser._expression_rich("return " + expression, expression, { rm=rm }))

```

# res://addons/richer_text/scripts/rtxt_revealer.gd
```gd
@tool
class_name RTxtRevealer extends RTxtModifier
## TODO: Shorts a short text unless hovered, then displays longer.

@export var visible := false
@export_range(0.0, 1.0, 0.01) var amount := 0.0:
	set(a):
		amount = a
		label.queue_redraw()
@export var style_box: StyleBoxFlat

#func _preparse(bbcode: String) -> String:
	#var id := get_instance_id()
	#var lines := bbcode.strip_edges().split("\n")
	#for i in lines.size():
		#var parts := lines[i].split(";", true, 0)
		#var short := parts[0].strip_edges()
		#var long := parts[1].strip_edges()
		#lines[i] = "[revel id=%s x=true y=%s]%s]\n[revel id=%s x=false y=%s]%s]" % [id, i, short, id, i, long]
	#return "\n".join(lines)

func  _debug_draw(rtl: RicherTextLabel):
	var y := 0.0
	for i in rtl.get_line_count():
		var h := rtl.get_line_height(i)
		rtl.draw_style_box(style_box, Rect2(0.0, y, rtl.size.x, h))
		y += h

func _pressed():
	print("Selected")

```

# res://addons/richer_text/scripts/rtxt_scatterer.gd
```gd
@tool
class_name RTxtScatterer extends RTxtModifier

## Automatically repeats the bbcode multiple times, so you can draw the same text in multiple places.
@export_range(0, 3) var repeat_input := 0
@export var nodes: Array[NodePath]
@export var horizontal_alignment := HORIZONTAL_ALIGNMENT_CENTER
@export var vertical_alignment := VERTICAL_ALIGNMENT_CENTER
## Attempt to clamp text to the viewport. Doesn't quite work with rotations.
@export var viewport_clamp := true
@export var viewport_margin := Vector2i(16, 16)
## Copy the rotation of the nodes.
@export var copy_rotation := true
@export var copy_scale := true

var _rects: Array[Rect2]
var _char_bounds: Array[PackedVector2Array]
var _line_height: float

func _preparse(bbcode: String) -> String:
	label.clip_contents = false ## Needed for if characters are out of rect.
	label.clip_children = CanvasItem.CLIP_CHILDREN_DISABLED ## Needed for when tooltip is out of rect.
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	
	var lines := bbcode.split("\n")
	if lines.size() == 1 and repeat_input != 0:
		for i in repeat_input:
			lines.append(lines[0])
	
	var id := get_instance_id()
	for i in lines.size():
		var target: Node
		if i < nodes.size() and nodes[i]:
			target = label.get_node(nodes[i])
		if not target and i < label.get_child_count():
			target = label.get_child(i)
		if target:
			lines[i] = "[scatr id=%s pid=%s ln=%s]%s]" % [id, target.get_instance_id(), i, lines[i]]
	
	return "\n".join(lines)

func _finished():
	var fnt := label.get_theme_font(&"normal_font")
	var fnt_size := label.get_theme_font_size(&"normal_font_size")
	var lines := label.get_parsed_text().split("\n")
	_rects.resize(lines.size())
	_char_bounds.resize(label.get_parsed_text().length())
	_line_height = fnt.get_ascent(fnt_size) + fnt.get_descent(fnt_size)
	for i in lines.size():
		var size := fnt.get_string_size(lines[i], HORIZONTAL_ALIGNMENT_LEFT, -1, fnt_size)
		_rects[i] = Rect2(0.0, 0.0, size.x, size.y)

```

# res://addons/richer_text/scripts/rtxt_shadow.gd
```gd
@tool
class_name RTxtShadow extends Resource
## Handles shadow settings for easy reuse.

@export var enabled: bool = true:
	set(e):
		enabled = e
		changed.emit()

## In pixels.
@export_range(0.0, 16.0, 0.1, "suffix:pixels") var distance := 4.0:
	set(o):
		distance = o
		changed.emit()

@export_range(-180.0, 180.0, 0.1, "radians_as_degrees") var angle := PI*.25:
	set(d):
		angle = d
		changed.emit()

@export_color_no_alpha var color := Color.BLACK:
	set(c):
		color = c
		changed.emit()

@export_range(0.0, 1.0) var alpha := 0.25:
	set(a):
		alpha = a
		changed.emit()

## Relative to font_size.
@export var outline_size := 0.1:
	set(o):
		outline_size = o
		changed.emit()

```

# res://addons/richer_text/scripts/rtxt_ticker.gd
```gd
@tool
class_name RTxtTicker extends RTxtModifier

@export var speed := 1.0
@export var reverse := false
@export var divider := "   ●   "

func _preparse(bbcode: String) -> String:
	return "[ticker id=%s]%s]" % [get_instance_id(), divider.join(bbcode.split("\n")) + divider]

```

# res://addons/richer_text/scripts/sound.gd
```gd
class_name Sound extends Resource

@export_file("*.mp3", "*.wav", "*.ogg") var paths: PackedStringArray
@export var pitch_rand_min := 0.95
@export var pitch_rand_max := 1.05
@export var volume_rand_min := -0.05
@export var volume_rand_max := 0.05

func play(node: Node):
	var path := Array(paths).pick_random()
	if not path or not FileAccess.file_exists(path):
		return
	var snd := AudioStreamPlayer.new()
	node.add_child(snd)
	snd.stream = load(path)
	snd.pitch_scale = randf_range(pitch_rand_min, pitch_rand_max)
	snd.volume_linear = randf_range(volume_rand_min, volume_rand_max)
	snd.play()
	snd.finished.connect(snd.queue_free)

```

# res://addons/richer_text/scripts/urichtext.gd
```gd
class_name URichText extends RefCounted
## Various RichText helpers.

## For use with print_rich.
static func to_rich_string(value: Variant, indent := "\t") -> String:
	return _pretty(value, indent)

static func _pretty(value: Variant, indent_str: String, indent := 0) -> String:
	var out := ""
	var prefix := indent_str.repeat(indent)
	match typeof(value):
		TYPE_OBJECT:
			out += "Object(%s)\n" % [wrap_color((value as Object).get_instance_id(), Color.PURPLE)]
		TYPE_DICTIONARY:
			out += prefix + "\n"
			for key in value.keys():
				out += prefix + wrap_color("[i]%s[/i]" % key, Color.WHITE) + ": " + _pretty(value[key], indent_str, indent + 1)
		TYPE_ARRAY:
			out += prefix + "\n"
			for item in value:
				out += prefix + "- " + _pretty(item, indent_str, indent + 1)
		TYPE_BOOL, TYPE_NIL, TYPE_INT, TYPE_FLOAT:
			out += wrap_color(value) + "\n"
		TYPE_STRING:
			out += wrap_color('"' + value + '"') + "\n"
		TYPE_VECTOR2, TYPE_VECTOR2I:
			out += "Vector(%s, %s)\n" % [wrap_color(value.x), wrap_color(value.y)]
		TYPE_VECTOR3, TYPE_VECTOR3I:
			out += "Vector(%s, %s)\n" % [wrap_color(value.x), wrap_color(value.y), wrap_color(value.z)]
		TYPE_COLOR:
			out += "Color(%s)\n" % [wrap_color("#" + (value as Color).to_html(), value)]
		_:
			out += str(value) + "\n"
	return out

static func wrap_color(text: Variant, color: Variant = null) -> String:
	if color == null:
		match typeof(text):
			TYPE_STRING: color = Color.ORANGE
			TYPE_BOOL, TYPE_NIL: color = Color.TOMATO#EditorInterface.get_editor_settings().get_setting("color")
			TYPE_FLOAT, TYPE_INT: color = Color.CYAN#EditorInterface.get_editor_settings().get_setting("text_editor/theme/highlighting/number_color")
			_: color = Color.WHITE
	return "[color=#%s]%s[/color]" % [color.to_html(), text]

```

# res://addons/richer_text/text_effects/anims/rte_back.gd
```gd
@tool
extends RTxtEffect
## Bounces text in.

## Syntax: [back scale=8.0][]
var bbcode = "back"

func _process_custom_fx(c: CharFXTransform):
	var a := 1.0 - delta
	var scale := get_float(&"scale", 1.0)
	offset.y += ease_back(a) * font_size * scale
	alpha *= (1.0 - a)
	_send_transform_back()
	return true

```

# res://addons/richer_text/text_effects/anims/rte_console.gd
```gd
@tool
extends RTxtEffect

## Syntax: [console][]
var bbcode = "console"

const SPACE := " "
const CURSOR := "█"
const CURSOR_COLOR := Color.GREEN_YELLOW

func _update() -> bool:
	var lbl := label
	
	if lbl.progress == 1.0:
		if lbl.visible_character-1 == absolute_index and sin(time * 16.0) > 0.0:
			chr = CURSOR
			color = CURSOR_COLOR
			offset = Vector2.ZERO
	
	else:
		if lbl.visible_character == absolute_index:
			if chr == SPACE:
				alpha = 0.0
			else:
				chr = CURSOR
				color = CURSOR_COLOR
				offset = Vector2.ZERO
		
		else:
			alpha *= delta
	
	_send_transform_back()
	return super()

```

# res://addons/richer_text/text_effects/anims/rte_fader.gd
```gd
@tool
extends RTxtEffect
## Fades words in one at a time.

## Syntax: [fader][/fader]
var bbcode := "fader"

func _update() -> bool:
	alpha *= delta
	_send_transform_back()
	return true

```

# res://addons/richer_text/text_effects/anims/rte_fallin.gd
```gd
@tool
extends RTxtEffect
## Characters fall in one at a time.

## Syntax: [fallin][]
var bbcode = "fallin"

func _update() -> bool:
	var delta: float = ease_back_out(delta)
	alpha *= delta
	var cs := size * Vector2(0.5, -0.25)
	transform *= Transform2D.IDENTITY.translated(cs)
	transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * (1.0 + (1.0 - delta) * 2.0))
	transform *= Transform2D.IDENTITY.translated(-cs)
	_send_transform_back()
	return true

```

# res://addons/richer_text/text_effects/anims/rte_focus.gd
```gd
@tool
extends RTxtEffect

## Syntax: [focus color][]
var bbcode = "focus"

func _update() -> bool:
	var a := 1.0 - delta
	var scale := get_float(&"scale", 1.0)
	color.s = lerp(color.s, 0.0, a)
	color.a = lerp(color.a, 0.0, a)
	var r = hash(text[absolute_index]) * 33.33 + absolute_index * 4545.5454 * TAU
	offset += Vector2(cos(r), sin(r)) * label.size * scale * (a * a)
	_send_transform_back()
	return true

```

# res://addons/richer_text/text_effects/anims/rte_fromcursor.gd
```gd
@tool
extends RTxtEffect
## Fades words in one at a time.

## Syntax: [cfac][]
var bbcode = "fromcursor"

func _update() -> bool:
	# Send position back early so ctc isn't weird.
	_send_transform_back()
	alpha *= delta
	position = mouse.lerp(position, pow(delta, 0.25))
	return true

```

# res://addons/richer_text/text_effects/anims/rte_growin.gd
```gd
@tool
extends RTxtEffect
## Grows characters in one at a time.

## Syntax: [growin][]
var bbcode = "growin"

func _update() -> bool:
	var d := ease_back_out(delta, 2.0)
	alpha *= d
	var cs := size * Vector2(0.5, -0.25)
	transform *= Transform2D.IDENTITY.translated(cs)
	transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * d)
	transform *= Transform2D.IDENTITY.translated(-cs)
	_send_transform_back()
	return true

```

# res://addons/richer_text/text_effects/anims/rte_offin.gd
```gd
@tool
extends RTxtEffect
## Characters are offset into place.

## Syntax: [offin][]
var bbcode = "offin"

func _update() -> bool:
	alpha *= delta
	offset.x = -size.x * (1.0 - delta)
	_send_transform_back()
	return true

```

# res://addons/richer_text/text_effects/anims/rte_prickle.gd
```gd
@tool
extends RTxtEffect
## Fades characters in more randomly.
## You should set 'fade_speed' to a low value for this to look right. 

## Syntax: [prickle pow=2][]
var bbcode = "prickle"

func _update() -> bool:
	var power := get_float(&"pow", 2.0)
	var a := delta
	a = clamp(a * 2.0 - rnd(), 0.0, 1.0)
	a = pow(a, power)
	alpha = a
	_send_transform_back()
	return true

```

# res://addons/richer_text/text_effects/anims/rte_redact.gd
```gd
@tool
extends RTxtEffect

## Syntax: [redact freq wave][]
var bbcode = "redact"

const SPACE := " "
const BLOCK := "█"
const MID_BLOCK := "▓"

func _update() -> bool:
	var a := delta
	if a == 0 and (chr != SPACE or index % 2 == 0):
		#var freq := get_float("freq", 1.0)
		#var scale := get_float("scale", 1.0)
		chr = "X"
		color = Color.BLACK
	_send_transform_back()
	return true

```

# res://addons/richer_text/text_effects/anims/rte_wfc.gd
```gd
@tool
extends RTxtEffect
## Simulates a "Wave Function Collapse" for each character.

## Syntax: [wfc][]
var bbcode = "wfc"

const SPACE := " "
const SYMBOLS := "10"

func _update() -> bool:
	var a := delta
	var aa := a + rnd() * a
	if aa < 1.0 and chr != SPACE:
		chr = SYMBOLS[rnd_time(8.0) * len(SYMBOLS)]
		color.v -= .5
	alpha = a
	_send_transform_back()
	return true

```

# res://addons/richer_text/text_effects/effects/rte_beat.gd
```gd
@tool
extends RTxtEffect
## Pulses it's scale and color every second.

## [beat][]
var bbcode := "beat"

func _update() -> bool:
	var cs := size * Vector2(0.5, -0.3)
	var speed := 2.0
	var pulse := pow(maxf(sin(time * speed), 0.0) * maxf(sin(time * 2.0 * speed), 0.0), 4.0)
	_char_fx.transform *= Transform2D.IDENTITY.translated(cs)
	_char_fx.transform *= Transform2D.IDENTITY.scaled(Vector2.ONE + Vector2(1.4, 0.8) * pulse)
	_char_fx.transform *= Transform2D.IDENTITY.translated(-cs)
	color = lerp(Color.WHITE, color, pulse * 2.)
	return true

```

# res://addons/richer_text/text_effects/effects/rte_clown.gd
```gd
@tool
extends RTxtEffect

var bbcode := "clown"

func _update() -> bool:
	_char_fx.outline
	return true

```

# res://addons/richer_text/text_effects/effects/rte_curspull.gd
```gd
@tool
extends RTxtEffect
## Pulls or pushes characters away from the cursor.
## Use a negative number for reverse effect.

## Syntax: [curspull 1.0][]
const bbcode = "curspull"

func _update() -> bool:
	var pull := get_float("pull", 1.0)
	var dif := position - mouse
	var dis := dif.length()
	var nrm := dif.normalized() * -pull
	position += nrm * clampf(pow(dis * .1, 4.0), 0.1, 4.0)
	return true

```

# res://addons/richer_text/text_effects/effects/rte_cuss.gd
```gd
@tool
extends RTxtEffect
## "Censors" a word by replacing vowels with symbols.

## Syntax: [cuss][]
const bbcode = "cuss"

const VOWELS := "aeiouAEIOU"
const CUSS_CHARS := "&$!@*#%"
const IGNORE := " !?.,;\""

func _update() -> bool:
	# Never censor first letter.
	if index != 0:
		# Always censor vowels.
		if chr in VOWELS:
			chr = CUSS_CHARS[int(rnd_smooth(5.0) * len(CUSS_CHARS))]
			color = Color.RED
		# Don't censor last letter.
		elif absolute_index + 1 < len(text) and not text[absolute_index + 1] in IGNORE:
			# Sometimes censor other letters.
			if rnd_time() > TAU * 0.75:
				chr = CUSS_CHARS[int(rnd_smooth(5.0) * len(CUSS_CHARS))]
				color = Color.RED
	return true

```

# res://addons/richer_text/text_effects/effects/rte_glow.gd
```gd
@tool
class_name RTE_Glow extends RTxtEffect
## TODO: Unfinished test class

@export var glow_color := Color.TOMATO
@export var glow_outline_color := Color.GREEN_YELLOW
@export var glow_speed := 1.0

func _update() -> bool:
	color = lerp(glow_color, glow_outline_color, sin(time * glow_speed))
	return true

```

# res://addons/richer_text/text_effects/effects/rte_heart.gd
```gd
@tool
extends RTxtEffect
## Hear beat jumping, and turning into a heart shape.

## Syntax: [heart scale=1.0 freq=8.0][]
var bbcode = "heart"

const TO_CHANGE := "oOaA"

func _update() -> bool:
	var scale := get_float("scale", 16.0)
	var freq := get_float("freq", 2.0)
	var x = index / scale - time * freq
	var t = abs(cos(x)) * max(0.0, smoothstep(0.712, 0.99, sin(x))) * 2.5;
	color = color.lerp(Color.BLUE.lerp(Color.RED, t), t)
	offset.y -= t * 4.0
	
	if offset.y < -1.0:
		if chr in TO_CHANGE and label.parser.emoji_font:
			var efont: Font = load(label.parser.emoji_font)
			if efont:
				font = efont.get_rids()[0]
				transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * 0.6)
				offset.y -= 6.0
				chr = "❤️"
			else:
				chr = "•"
	
	return true

```

# res://addons/richer_text/text_effects/effects/rte_jit.gd
```gd
# Makes words shake around.
@tool
extends RTxtEffect

# Syntax: [jit scale=1.0 freq=8.0][]
var bbcode = "jit"

const SPLITTERS := " .!?,-"

var _word := 0.0
var _last := ""
var _offset := 0

func _update() -> bool:
	if index == 0:
		_word = 0
		_offset = absolute_index
	
	var scale := get_float("scale", 2.0)
	var freq := get_float("jit", 1.0)
	
	if text[absolute_index] in SPLITTERS or _last in SPLITTERS:
		_word += PI * .33
	
	var s := fmod((_word + time + _offset) * PI * 1.25, TAU)
	var p := sin(time * freq * 16.0) * .5
	offset.x += sin(s) * p * scale
	offset.y += cos(s) * p * scale
	_last = text[absolute_index]
	return true

```

# res://addons/richer_text/text_effects/effects/rte_jit2.gd
```gd
@tool
extends RTxtEffect
## Makes words shake around.

## Syntax: [jit2 scale=1.0 freq=8.0][]
var bbcode = "jit2"

func _update() -> bool:
	var scale := get_float("scale", 1.0)
	var freq := get_float("freq", 16.0)
	var s := fmod((index + time) * PI * 1.25, TAU)
	var p := sin(time * freq + absolute_index) * .33
	offset.x += sin(s) * p * scale
	offset.y += cos(s) * p * scale
	return true

```

# res://addons/richer_text/text_effects/effects/rte_jump.gd
```gd
@tool
class_name RTE_Jump extends RTxtEffect
## Jumps up and down.

## Syntax: [jump angle=45]]
var bbcode := "jump"

const SPLITTERS := " .,"

@export_range(-180.0, 180.0, 1.0, "radians_as_degrees") var jump_angle := 0.0
@export_range(0.0, 1.0, 0.01) var jump_scale := 1.0

var _w_char = 0
var _last = 999

func _update() -> bool:
	if absolute_index < _last or chr in SPLITTERS:
		_w_char = absolute_index
	
	_last = absolute_index
	var a := jump_angle + deg_to_rad(get_float(&"angle", 0.0))
	var s := -absf(sin(-time * 6.0 + _w_char * PI * .025))
	s *= jump_scale * get_float(&"scale", 1.0) * font_size * .125 * weight
	position += Vector2(sin(a), cos(a)) * s
	return true

```

# res://addons/richer_text/text_effects/effects/rte_jump2.gd
```gd
@tool
extends RTxtEffect

## Syntax: [jump2 angle=45][]
var bbcode := "jump2"

func _update() -> bool:
	var a := deg_to_rad(get_float(&"angle", 0.0))
	var s := sin(-time * 4.0 + index * PI * .125)
	s = -abs(pow(s, 4.0)) * 2.0
	s *= get_float(&"size", 1.0) * font_size * .125
	position += Vector2(sin(a), cos(a)) * s
	return true

```

# res://addons/richer_text/text_effects/effects/rte_l33t.gd
```gd
@tool
extends RTxtEffect
## Converts numbers to letters in a way that is still readable with effort.

## Syntax: [l33t][]
var bbcode = "l33t"

var leet = {
	"L": "1",
	"l": "1",
	"I": "1",
	"i": "1",
	"E": "3",
	"e": "3",
	"T": "7",
	"t": "7",
	"S": "5",
	"s": "5",
	"A": "4",
	"a": "4",
	"O": "0",
	"o": "0",
}

func _update() -> bool:
	if chr in leet:
		if rnd_time() > .2:
			chr = leet[chr]
	return true

```

# res://addons/richer_text/text_effects/effects/rte_mega.gd
```gd
@tool
class_name RTE_Mega extends RTxtEffect
## Add noise or a simple sway to the position, rotation, scale, or skew.

## Syntax: [meta][/meta]
## Meant to be used by JuicyText.
var bbcode := "meta"

@export_group("Color", "mega_color_")
@export var mega_color_enabled := true ## Animate colors?
@export var mega_color_include_own := true ## Will blend between it's own and the list.
@export var mega_color_list: PackedColorArray ## List of colors to blend between.
@export_range(0.0, 1.0) var mega_color_freq := 1.0
@export_range(0.0, 1.0) var mega_color_noise := 1.0
@export var mega_color_speed := 1.0

@export_group("Position", "mega_position_")
@export var mega_position_enabled := true ## Animate position?
@export var mega_position_scale := Vector2(0.0, 0.2) ## Scaled to font_size.
@export_range(0.0, 1.0) var mega_position_freq := 1.0
@export_range(0.0, 1.0) var mega_position_noise := 1.0
@export var mega_position_speed := 1.0

@export_group("Rotation", "mega_rotation_")
@export var mega_rotation_enabled := true
@export_range(0.0, 1.0) var mega_rotation_scale := 0.1
@export_range(0.0, 1.0) var mega_rotation_freq := 1.0
@export_range(0.0, 1.0) var mega_rotation_noise := 1.0
@export var mega_rotation_speed := 1.0

@export_group("Scale", "mega_scale_")
@export var mega_scale_enabled := true
@export var mega_scale_scale := Vector2(0.1, 0.1)
@export_range(0.0, 1.0) var mega_scale_freq := 1.0
@export_range(0.0, 1.0) var mega_scale_noise := 1.0
@export var mega_scale_speed := 1.0

@export_group("Skew", "mega_skew_")
@export var mega_skew_enabled := true
@export_range(0.0, 1.0) var mega_skew_scale := 0.1
@export_range(0.0, 1.0) var mega_skew_freq := 1.0
@export_range(0.0, 1.0) var mega_skew_noise := 1.0
@export var mega_skew_speed := 1.0
## center = (0.5, 0.5)
## bottom = (0.5, 1.0)
## top = (0.5, 0.0)
@export var mega_skew_pivot := Vector2(0.5, 0.5)

func _update() -> bool:
	if mega_position_enabled:
		var x := rnd_noise(mega_position_noise, mega_position_speed, mega_position_freq, PI)
		var y := rnd_noise(mega_position_noise, mega_position_speed, mega_position_freq, TAU)
		position += Vector2(x, y) * mega_position_scale * font_size  * weight
	
	if mega_rotation_enabled:
		rotation = rnd_noise(mega_rotation_noise, mega_rotation_speed, mega_rotation_freq, 0.0) * TAU * mega_rotation_scale * weight
	
	if mega_scale_enabled:
		scale = Vector2.ONE + mega_scale_scale * rnd_noise(mega_scale_noise, mega_scale_speed, mega_scale_freq, 3.0) * weight
	
	if mega_skew_enabled:
		skew_pivoted(rnd_noise(mega_skew_noise, mega_skew_speed, mega_skew_freq, 2.0) * mega_skew_scale * weight, mega_skew_pivot)
	
	if mega_color_enabled:
		var new_color: Color
		# TODO: Improve this. I just guessed around.
		var t := time * mega_color_speed + index * mega_color_freq
		t += lerpf(0.0, rnd(mega_color_freq, 321), mega_color_noise)
		if mega_color_include_own:
			new_color = cycle_colors(mega_color_list + PackedColorArray([color]), t, color)
		else:
			new_color = cycle_colors(mega_color_list, t, color)
		color = lerp_hsv(color, new_color, weight)
	

	
	return true

```

# res://addons/richer_text/text_effects/effects/rte_off.gd
```gd
@tool
extends RTxtEffect
## Offsets characters by an amount.

## Syntax: [off][]
var bbcode = "off"

func to_float(s: String):
	if s.begins_with("."):
		return ("0" + s).to_float()
	return s.to_float()

func _update() -> bool:
	var off := get_var(&"off", Vector2.ZERO)
	match typeof(off):
		TYPE_FLOAT, TYPE_INT: offset.y += off
		TYPE_VECTOR2: offset += off
		TYPE_ARRAY: offset += Vector2(off[0], off[1])
	return true

```

# res://addons/richer_text/text_effects/effects/rte_rain.gd
```gd
@tool
extends RTxtEffect

## Syntax: [rain][]
var bbcode = "rain"

func _update() -> bool:
	var r = fmod(cos(rnd_time() * .125 + sin(index * .5 + time * .6) * .25) + time * .5, 1.0)
	offset.y += (r - .25) * 8.0
	alpha = lerp(alpha, 0.0, r)
	return true

```

# res://addons/richer_text/text_effects/effects/rte_secret.gd
```gd
@tool
extends RTxtEffect
## Invisible unless cursor is near it.

## Syntax: [secret][]
const bbcode = "secret"

func _update() -> bool:
	var dif := transform.origin - mouse
	var dis := dif.length()
	alpha = clampf(8.0 - (dis / 8.0), 0.0, 1.0)
	return true

```

# res://addons/richer_text/text_effects/effects/rte_sin.gd
```gd
@tool
class_name RTE_Sin extends RTxtEffect
## Sine wave effect.

## [sin sin=float speed=float freq=float skew=float][/sin]
var bbcode := "sin"

@export var sin_scale := 1.0
@export var freq := 0.5
@export var speed := 1.0
@export var skew_scale := 0.2

func _update() -> bool:
	var t := time * get_float(&"speed", speed)
	t += range.x * get_float(&"freq", freq) * font_size
	position.y += sin(t) * font_size * .25 * get_float(&"sin", sin_scale) * weight
	skew_y = cos(t) * get_float(&"skew", skew_scale) * weight
	return true

```

# res://addons/richer_text/text_effects/effects/rte_sparkle.gd
```gd
@tool
extends RTxtEffect

## [sparkle]]
var bbcode := "sparkle"

func _update() -> bool:
	var s = 1.0 - color.s
	color.h = wrapf(color.h + sin(-time * 4.0 + _char_fx.glyph_index * 2.0) * s * .033, 0.0, 1.0)
	color.v = clamp(color.v + sin(time * 4.0 + _char_fx.glyph_index) * .25, 0.0, 1.0)
	return true

```

# res://addons/richer_text/text_effects/effects/rte_sway.gd
```gd
@tool
class_name RTE_Sway extends RTxtEffect
## Sways the character back and forth.

## [sway][/sway]
var bbcode := "sway"

func _update():
	var sway := sin(time * 2.0) * 0.25
	var s := size * Vector2(0.5, -0.25)
	if _juicy:
		skew = sway
	else:
		transform *= Transform2D.IDENTITY.translated(s)
		transform *= Transform2D(0.0, Vector2.ONE, sway, Vector2.ZERO)
		transform *= Transform2D.IDENTITY.translated(-s)
	return true

```

# res://addons/richer_text/text_effects/effects/rte_sweep.gd
```gd
@tool
extends RTxtEffect

var bbcode := "sweep"

func _update() -> bool:
	var interval := 2.5
	var band_width := 0.15
	var total := text.length() - 1.0
	if total <= 0:
		return true
	
	var progress := fmod(time, interval) / interval
	var norm_index := float(range.x) / total
	
	if absf(norm_index - progress) < band_width:
		var strength := 1.0 - (absf(norm_index - progress) / band_width)
		color = color.lerp(Color(1, 1, 1), strength)
	
	return true

```

# res://addons/richer_text/text_effects/effects/rte_uwu.gd
```gd
@tool
extends RTxtEffect
## Makes text cuter.
## "R" & "L" become "W" -> Royal Rumble = Woyaw Wumbwe.
## Ideally a monospaced font should be used.

## Syntax: [uwu][]
var bbcode = "uwu"

func _update() -> bool:
	match chr:
		"r", "l": chr = "w"
		"R", "L": chr = "W"
	return true

```

# res://addons/richer_text/text_effects/effects/rte_wack.gd
```gd
@tool
extends RTxtEffect
## Wacky random animations.
## Randomly scales and rotates characters.

var bbcode := "wack"

func _update() -> bool:
	var cs := size * Vector2(0.5, -0.3)
	var r := rnd()
	transform *= Transform2D.IDENTITY.translated(cs)
	transform *= Transform2D.IDENTITY.rotated((cos(index + time) + sin(r + time * 3.0)) * .125)
	transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * (1.0 + cos(r * .5 + index * 3.0 + time * 1.3) * .125))
	transform *= Transform2D.IDENTITY.translated(-cs)
	return true

```

# res://addons/richer_text/text_effects/effects/rte_wave.gd
```gd
@tool
extends RTxtEffect

## Syntax: [wave][]
var bbcode = "www"

func _update() -> bool:
	var wave := get_float(&"wave", 1.0)
	var freq := get_float(&"freq", 1.0)
	
#	c.offset.y += sin(c.elapsed_time + c.absolute_index * f) * t.size * 32
	
#	var scale:float = char_fx.env.get("scale", 16.0)
#	var freq:float = char_fx.env.get("freq", 2.0)
#
#	var x =  char_fx.absolute_index / scale - char_fx.elapsed_time * freq
#	var t = abs(cos(x)) * max(0.0, smoothstep(0.712, 0.99, sin(x))) * 2.5;
#	char_fx.color = lerp(char_fx.color, lerp(Color.blue, Color.red, t), t)
#	char_fx.offset.y -= t * 4.0
#
#	var c = char_fx.character
#	if char_fx.offset.y < -1.0:
#		if char_fx.character in TO_CHANGE:
#			char_fx.character = HEART
#
	return true

```

# res://addons/richer_text/text_effects/effects/rte_woo.gd
```gd
@tool
class_name RTE_Woo extends RTxtEffect

## Syntax: [woo scale=1.0 freq=8.0][/woo]
var bbcode = "woo"

func _update() -> bool:
	var spd := get_float(&"spd", 2.0)
	var freq := get_float(&"freq", 2.0)
	if rnd_smooth(spd, freq) > 0.5:
		var c := chr
		chr = c.to_upper() if c == c.to_lower() else c.to_upper()
	return true

```

# res://addons/richer_text/text_effects/mods/rte_curve.gd
```gd
@tool
extends RTxtEffect
## Used by the RichTextCurve modifier.

## [curve id=richer text curve instance id]]
var bbcode := "curve"

var path: Path2D

func _update():
	var curve: RTxtCurver = get_instance()
	if not path and curve and curve.curve:
		path = label.get_node(curve.curve)
	if path:
		var coffset := curve._sizes[index]
		coffset.x += curve.offset * (path.curve.get_baked_length() - label.get_content_width())
		var trans := path.curve.sample_baked_with_rotation(coffset.x)
		position = trans.origin + path.global_position - label.global_position
		#position.y += coffset.y
		if curve.rotate:
			rotate(trans.get_rotation())
		if curve.skew:
			skew = trans.get_rotation()
	return true

```

# res://addons/richer_text/text_effects/mods/rte_link.gd
```gd
@tool
class_name RTxtLinkEffect extends RTxtEffect
## Customize animation by overriding _update_unhovered() _update_hovered() and _update_clicked()
## Change timing.

const PROPS: PackedStringArray = ["color", "elapsed_time", "glyph_count", "glyph_flags", "glyph_index", "outline", "range", "relative_index", "transform", "offset", "font"]

@export var hover_duration := 0.2
@export var hover_trans := Tween.TRANS_LINEAR
@export var hover_ease := Tween.EASE_IN_OUT

@export var unhover_duration := 0.1
@export var unhover_trans := Tween.TRANS_LINEAR
@export var unhover_ease := Tween.EASE_IN_OUT

@export var clicked_in_duration := 0.2
@export var clicked_in_trans := Tween.TRANS_LINEAR
@export var clicked_in_ease := Tween.EASE_IN_OUT
@export var clicked_wait := 0.5
@export var clicked_out_duration := 0.2
@export var clicked_out_trans := Tween.TRANS_LINEAR
@export var clicked_out_ease := Tween.EASE_IN_OUT

var bbcode := "link"
var _states: Dictionary[int, float]
var _states_clicked: Dictionary[int, float]
var _clicked: Dictionary[int, bool]
var _tweens: Dictionary[int, Tween]
var _tweens_clicked: Dictionary[int, Tween]
var _hovered := -1

func _clear():
	_states.clear()
	_states_clicked.clear()
	_clicked.clear()
	_tweens.clear()
	_tweens_clicked.clear()
	_hovered = -1

## Override for unhovered state animation.
func _update_unhovered() -> bool:
	color = Color.HOT_PINK
	return true

## Override for hovered state animation.
func _update_hovered() -> bool:
	color = Color.GREEN_YELLOW
	return true

## Override for clicked state animation.
func _update_clicked() -> bool:
	color = Color.DEEP_SKY_BLUE
	return true

func _get_rank_order() -> int:
	return 100

func _tween(index: int, from: float, to: float, duration: float, trans: int, ease: int):
	var tween: Tween = _tweens.get(index)
	if tween: tween.kill()
	tween = label.create_tween()
	tween.tween_method(func(x): _states[index] = x, _states.get(index, from), to, duration).set_trans(trans).set_ease(ease)
	_tweens[index] = tween
	return tween
	
func _link_hovered(index: int):
	_tween(index, 0.0, 1.0, hover_duration, hover_trans, hover_ease)
	
func _link_unhovered(index: int):
	_tween(index, 1.0, 0.0, unhover_duration, unhover_trans, unhover_ease)

func _link_clicked(index: int):
	var tween: Tween = _tweens_clicked.get(index)
	if tween: tween.kill()
	_clicked[index] = true
	tween = label.create_tween()
	tween.tween_method(func(x): _states_clicked[index] = x, _states_clicked.get(index, 0.0), 1.0, clicked_in_duration).set_trans(clicked_in_trans).set_ease(clicked_in_ease)
	tween.tween_interval(clicked_wait)
	tween.tween_method(func(x): _states_clicked[index] = x, 1.0, 0.0, clicked_out_duration).set_trans(clicked_out_trans).set_ease(clicked_out_ease)
	tween.tween_callback(func(): _clicked[index] = false)
	_tweens_clicked[index] = tween

func _duplicate(c: CharFXTransform) -> CharFXTransform:
	var out := CharFXTransform.new()
	for prop in PROPS:
		out[prop] = c[prop]
	return out

func _update() -> bool:
	var link_index := get_int()
	var cfx := _char_fx
	var amount := _states.get(link_index, 0.0)
	
	if amount == 0.0:
		_update_unhovered()
	elif amount == 1.0:
		_update_hovered()
	else:
		var a := _duplicate(cfx)
		_char_fx = a
		_update_unhovered()
		var b := _duplicate(cfx)
		_char_fx = b
		_update_hovered()
		
		cfx.color = lerp(a.color, b.color, amount)
		cfx.transform = a.transform.interpolate_with(b.transform, amount)
		cfx.offset = lerp(a.offset, b.offset, amount)
	
	if _clicked.get(link_index, false):
		var a := _duplicate(cfx)
		_char_fx = a
		_update_clicked()
		
		var amount_clicked := _states_clicked.get(link_index, 0.0)
		cfx.color = lerp(cfx.color, a.color, amount_clicked)
		cfx.transform = cfx.transform.interpolate_with(a.transform, amount_clicked)
		cfx.offset = lerp(cfx.offset, a.offset, amount_clicked)
	
	if not label:
		return false #????
	
	# HACK: Record which character is part of which link.
	var link_data := label._link_regions
	if not link_index in link_data:
		link_data[link_index] = PackedInt32Array()
	if not range.x in link_data[link_index]:
		link_data[link_index].append(range.x)
	
	## TODO: Apply transform.
	var poly := PackedVector2Array([
		Vector2(position.x, position.y),
		Vector2(position.x + size.x, position.y),
		Vector2(position.x + size.x, position.y - font_size),
		Vector2(position.x, position.y - font_size)
	])
	if index == 0:
		#label.add_draw(func(c: RicherTextLabel):
			#var ply := label._link_rects[link_index]
			#var clrs: PackedColorArray
			#clrs.resize(ply.size())
			#clrs.fill(Color(Color.RED, 0.1))
			#c.draw_polygon(ply, clrs))
		label._link_rects[link_index] = poly
	else:
		label._link_rects[link_index] = Geometry2D.convex_hull(label._link_rects[link_index] + poly)
	
	return true

## Called by RicherTextLabel in _input().
func _check_mouse_over(lbl: RicherTextLabel, mouse_position: Vector2):
	var link_data: Dictionary = lbl._link_regions
	var hovering := -1
	var scatter: RTxtScatterer = lbl.get_modifier(RTxtScatterer)
	if scatter:
		for link_index in link_data:
			var link_list: PackedInt32Array = link_data[link_index]
			for i in link_list:
				if i < scatter._char_bounds.size():
					var bounds: PackedVector2Array = scatter._char_bounds[i]
					if Geometry2D.is_point_in_polygon(mouse_position, bounds):
						hovering = link_index
	else:
		for link_index in label._link_rects:
			var bounds := label._link_rects[link_index]
			if Geometry2D.is_point_in_polygon(mouse_position, bounds):
				hovering = link_index
	label.hovered_link = hovering

```

# res://addons/richer_text/text_effects/mods/rte_revel.gd
```gd
extends RTxtEffect

var bbcode := "revel"

var xpos := 0.0

func _update() -> bool:
	var re := get_instance()
	var x := get_bool("x")
	var y := get_int("y")
	#_char_fx.visible = x != re.visible
	alpha = (1.0 - re.amount) if x else re.amount
	if not x:
		position.y -= font_height
	position.y -= font_height * y
	#if index == 0:
		#xpos = position.x * .5
	#if not x:
		#position.x -= label.get_content_width() * .5
		#position.x -= xpos
	#position.x += label.size.x * .5
	#position.x -= label.size.x * .5
	#position.x -= label.size.x * .5
	
	return true

```

# res://addons/richer_text/text_effects/mods/rte_scatr.gd
```gd
@tool
extends RTxtEffect
## Draws text at a nodes position. Allowing for a single label to draw in multiple places.

## [scatr id=node instance id]]
var bbcode := "scatr"

func _update() -> bool:
	var scatter: RTxtScatterer = get_instance()
	var opos := _char_fx.transform.origin
	
	var point: Node = get_instance(&"pid")
	var line_index: int = get_float("ln")
	var rect := scatter._rects[line_index]
	var point_rotation := 0.0
	var point_scale := Vector2.ONE
	
	if point:
		if point is CanvasItem:
			rect.position -= point.global_position
			if point is Node2D:
				if scatter.copy_rotation:
					point_rotation = (point as Node2D).rotation
				if scatter.copy_scale:
					point_scale = (point as Node2D).scale
		elif point is Node3D:
			var vp := label.get_viewport()
			var cam := vp.get_camera_3d()
			var pos := cam.unproject_position(point.global_position)
			rect.position += pos
		
		match scatter.horizontal_alignment:
			HORIZONTAL_ALIGNMENT_CENTER: rect.position.x += rect.size.x * .5
			HORIZONTAL_ALIGNMENT_RIGHT: rect.position.x += rect.size.x
		
		match scatter.vertical_alignment:
			VERTICAL_ALIGNMENT_CENTER: rect.position.y += rect.size.y * .5
			VERTICAL_ALIGNMENT_BOTTOM: rect.position.y += rect.size.y
		
		if scatter.viewport_clamp:
			var min_x := -scatter.viewport_margin.x
			var min_y := -scatter.viewport_margin.y
			var max_x: int = ProjectSettings.get("display/window/size/viewport_width") - scatter.viewport_margin.x
			var max_y: int = ProjectSettings.get("display/window/size/viewport_height") - scatter.viewport_margin.y
			if rect.position.x > min_x: rect.position.x = min_x
			if rect.position.x - rect.size.x < -max_x: rect.position.x = -max_x + rect.size.x
			if rect.position.y > min_y: rect.position.y = min_y
			if rect.position.y - scatter._line_height < -max_y: rect.position.y = -max_y + scatter._line_height
			
		rect.position += label.global_position
		
		if point_rotation != 0.0 or point_scale != Vector2.ONE:
			var pivot := rect.size * 0.5
			var rel := position - pivot - Vector2(0.0, scatter._line_height * line_index)
			rel = rel * point_scale
			rel = rel.rotated(point_rotation)
			
			var new_origin := pivot + rel
			_char_fx.transform = Transform2D(point_rotation, new_origin)
		else:
			rect.position.y += scatter._line_height * line_index
		
		if point_scale != Vector2.ONE:
			_char_fx.transform = _char_fx.transform.scaled_local(point_scale)
		
		position -= rect.position
	
	var r := Rect2(Vector2.ZERO, Vector2(size.x, -label.font_size))
	r = r.grow_individual(1, 0, 1, 0)
	var rect_points: PackedVector2Array = [
		r.position, Vector2(r.position.x, r.end.y), r.end, Vector2(r.end.x, r.position.y)
	]
	rect_points *= Transform2D(0.0, _char_fx.transform.get_scale(), 0.0, Vector2.ZERO)
	rect_points *= Transform2D(_char_fx.transform.get_rotation(), Vector2.ONE, 0.0, _char_fx.transform.get_origin()).affine_inverse()
	scatter._char_bounds[_char_fx.range.x] = rect_points
	
	return true

```

# res://addons/richer_text/text_effects/mods/rte_ticker.gd
```gd
extends RTxtEffect

var bbcode := "ticker"

func _update() -> bool:
	var ticker: RTxtTicker = get_instance()
	var w := label.get_content_width()
	var x := time * ticker.speed * weight * (-1 if ticker.reverse else 1) * font_size
	position.x = wrapf(position.x - x, -font_size, w - font_size)
	return true

```

# res://addons/richer_text/text_effects/outlines/rtoe_hypno.gd
```gd
@tool
class_name RTxtOE_Hypno extends RTxtOutlineEffect

func _update() -> bool:
	var list: Array = _char_fx.outline_states
	var n := list.size()
	for i in n:
		var phase := fmod(time + float(i), 1.0)
		var osize := lerp(i*10, i*10+10, phase)
		var is_odd := int(fmod(time + float(i), 2.)) % 2 == 0
		var ocolr := Color.GREEN_YELLOW if is_odd else Color.DEEP_PINK
		if i == n-1:
			ocolr.a = 1.0-phase
		list[i].size = osize
		list[i].color = ocolr
	return true

```

# res://addons/richer_text/text_effects/outlines/rtoe_rainbow.gd
```gd
@tool
class_name RTxtOE_Rainbow extends RTxtOutlineEffect

@export_group("Rainbow", "rainbow_")
@export_range(0.0, 1.0) var rainbow_saturation := 1.0
@export_range(0.0, 1.0) var rainbow_lightness := 0.8
@export_range(0.0, 1.0) var rainbow_frequency := 0.01
@export_range(0.0, 8.0) var rainbow_speed := 1.0
@export_range(1.0, 32.0) var rainbow_size := 8.0

func _update() -> bool:
	var list: Array = _char_fx.outline_states
	var n := list.size()
	for i in n:
		list[i].size = (1+i) * rainbow_size
		list[i].color = Color.from_ok_hsl(
			rnd_smoothu(rainbow_speed, rainbow_frequency, 123.41),
			rainbow_saturation,
			rainbow_lightness,
			1.0 - (i+1.0) / float(n))
	return true

```

# res://addons/twee/builder/twee_class_writer.gd
```gd
extends RefCounted
## GDScript is created with static funcs that are used in the tween to get properties.
## This lets us "mutate" at runtime, allowing for randomization and lerping towards properties that changes since the tween was created.

static var REGEX_ROOT := RegEx.create_from_string(r'@(?=(?:[A-Za-z_]|[%~][A-Za-z_]))')
static var REGEX_NODE := RegEx.create_from_string(r'\^(?=(?:[A-Za-z_]|[%~][A-Za-z_]))')

var _source_code: String
var _methods: Dictionary
var _return_methods: Dictionary

func _init():
	## !signal_args
	## ~initial_state
	## @node
	_source_code = "#WARNING: AUTOGENERATED - CHANGES WILL BE LOST"+\
		"\nstatic var signal_args: Dictionary"+\
		"\nstatic var initial_state: Dictionary"+\
		"\nstatic var for_nodes: Dictionary"

func create(properties := {}, print_source := false) -> GDScript:
	var head := ""
	var gd := GDScript.new()
	_source_code += "\n# %s" % Time.get_unix_time_from_system()
	gd.source_code = _source_code
	if print_source: print(_source_code)
	gd.reload()
	for prop in properties:
		gd[prop] = properties[prop]
	return gd

func add_static_func(expr: String, returns := true) -> StringName:
	var inpt := expr
	REGEX_ROOT = RegEx.create_from_string(r'@(?=(?:[A-Za-z_]|[%~][A-Za-z_]))')
	REGEX_NODE = RegEx.create_from_string(r'\^(?=(?:[A-Za-z_]|[%~][A-Za-z_]))')
	expr = REGEX_ROOT.sub(expr, "_root.", true)
	expr = expr.replace("@", "_root")
	expr = REGEX_NODE.sub(expr, "_node.", true)
	expr = expr.replace("^", "_node")
	expr = expr.replace("~", "initial_state[_node].")
	
	var h := hash(expr)
	if returns:
		if h in _return_methods:
			return _return_methods[h]
		var method_name := "_rm%s" % len(_return_methods)
		_source_code += "\nstatic func %s(_root: Node, _node: Node): return %s" % [method_name, expr]
		_return_methods[h] = method_name
		return method_name
	# Compiler gets annoyed if you return stuff for no reason...
	else:
		if h in _methods:
			return _methods[h]
		var method_name := "_m%s" % len(_methods)
		_source_code += "\nstatic func %s(_root: Node, _node: Node): %s" % [method_name, expr]
		_methods[h] = method_name
		return method_name

```

# res://addons/twee/builder/twee_lexer.gd
```gd
class_name TweeLexer extends RefCounted

const Token := preload("twee_tokens.gd")

var tokens: PackedStringArray
var i := 0

func _init(_tokens):
	tokens = _tokens

func peek(offset := 0) -> String:
	return tokens[i + offset] if (i + offset < tokens.size()) else ""

func eof() -> bool:
	return i >= tokens.size()

func advance() -> void:
	i += 1

func skip(what: Array) -> void:
	while not eof() and peek() in what:
		advance()

func expect(tok: String) -> void:
	if eof() or peek() != tok:
		_error("Expected '%s', got '%s'" % [tok, peek()])
	advance()

func accept(tok: String) -> bool:
	if not eof() and peek() == tok:
		advance()
		return true
	return false

func expect_end() -> void:
	if not eof() and peek() not in [Token.NEWLINE, Token.DEDENT, Token.COLON]:
		_error("Expected end of statement, got %s" % peek())

func _error(msg: String) -> void:
	push_error("[ParseError @ %d] %s" % [i, msg])

```

# res://addons/twee/builder/twee_parser.gd
```gd
@tool
extends RefCounted

const Token := preload("twee_tokens.gd")

const default_tween_duration := 1.0 ## Default seconds to tween if a duration wasn't explicitly given.
const default_pause_duration := 1.0 ## Default seconds to wait if WAIT wasn't explicitly given.
const default_event_signal_or_method := &"event" ## Will attempt to pass "string" events to this.

static var all_props: PackedStringArray

static func parse(tokens: PackedStringArray) -> Array[Dictionary]:
	all_props.clear()
	var parsed := _parse(tokens)
	var steps: Array[Dictionary] = parsed[0]
	return steps

static func _parse(tokens: PackedStringArray, i := 0) -> Array[Variant]:
	var commands: Array[Dictionary]
	while i < tokens.size():
		var t := tokens[i]
		
		# consume top-level newlines quickly
		if t == Token.NEWLINE or t == Token.SPACE:
			i += 1
			continue
			
		# End of block
		if t == Token.DEDENT:
			i += 1
			break
		
		if t == Token.LOOP:
			commands.append({ type=Token.LOOP, loop=0 })
			i += 1
			var args := []
			while i < tokens.size() and tokens[i] != Token.NEWLINE:
				args.append(tokens[i])
				i += 1
			if args:
				commands[-1].loop = int(args[0])
			continue
		
		# block-like keywords with optional args (block, parallel, choice, on)
		if t in [ Token.BLOCK, Token.PARALLEL, Token.PARALLEL_SHORT, Token.CHOICE, Token.ON, Token.FOR ]:
			var keyword := t
			if t == Token.PARALLEL_SHORT:
				keyword = Token.PARALLEL
			i += 1
			var args := []
			# collect tokens until colon (or we hit end)
			while i < tokens.size() and tokens[i] != Token.COLON:
				if tokens[i] != Token.NEWLINE:
					args.append(tokens[i])
				i += 1
			# skip colon if present
			if i < tokens.size() and tokens[i] == Token.COLON:
				i += 1
			# skip NEWLINEs after colon
			while i < tokens.size() and tokens[i] == Token.NEWLINE:
				i += 1
			# only parse nested block if there's an INDENT
			if i < tokens.size() and tokens[i] == Token.INDENT:
				i += 1
				var block := { type=keyword, args=args }
				var got := _parse(tokens, i)
				block.children = got[0]
				commands.append(block)
				i = got[1]
				continue
			# no INDENT -> treat as empty block/attribute container
			commands.append({ type=keyword, args=args, children=[] })
			continue
		
		# Pause.
		if t == Token.WAIT:
			commands.append({ type=Token.WAIT, wait=default_pause_duration })
			i += 1
			continue
		
		# Pause (lone float)
		if t.is_valid_float():
			commands.append({ type=Token.WAIT, wait=float(t) })
			i += 1
			continue
		
		# String event.
		if _is_wrapped(t):
			commands.append({ type=Token.STRING, value=_unwrap(t) })
			i += 1
			continue
		
		# Method call.
		if t.ends_with("("):
			i += 1
			var deep := 1
			var meth := t
			while i < tokens.size():
				meth += tokens[i]
				if tokens[i] == "(": deep += 1
				if tokens[i] == ")":
					deep -= 1
					if deep == 0:
						i += 1
						break
				i += 1
			commands.append({ type="METH", meth=meth })
			continue
		
		# TODO: Warp
		if t == Token.WARP:
			i += 1
			if i < tokens.size():
				commands.append({ type=Token.WARP, expr=tokens[i] })
				i += 1
			continue
		
		# Tween step (mode + optional duration + props)
		if t in [ "L", "LINEAR", "E", "EASE", "EI", "EASEIN", "EO", "EASEOUT", "EOI", "EASEOUTIN" ] or\
			t.begins_with("E_") or t.begins_with("EASE_") or\
			t.begins_with("EI_") or t.begins_with("EASEIN_") or\
			t.begins_with("EO_") or t.begins_with("EASEOUT_") or\
			t.begins_with("EOI_") or t.begins_with("EASEOUTIN_"):
			var cmd := { type=Token.PROPERTIES_TWEENED, mode=t, duration=default_tween_duration, props={} }
			i += 1
			# optional duration
			if i < tokens.size() and tokens[i].is_valid_float():
				cmd.duration = float(tokens[i])
				i += 1
			# parse properties (guaranteed to advance)
			var got := _parse_props(tokens, i)
			cmd.props = got[0]
			i = got[1]
			commands.append(cmd)
			continue

		# Standalone property line(s)
		# ensure token is a non-keyword identifier before calling _parse_props
		if _is_valid_property(t):
			var got := _parse_props(tokens, i)
			var cmd := { type=Token.PROPERTIES, props=got[0] }
			i = got[1]
			commands.append(cmd)
			continue
		# fallback: consume one token to avoid infinite loops
		i += 1
	return [commands, i]

static func _parse_props(tokens: PackedStringArray, i: int) -> Array:
	var props := {}

	while i < tokens.size():
		var token := tokens[i]

		# stop on structural tokens
		if token in [Token.PARALLEL, Token.PARALLEL_SHORT, Token.CHOICE, Token.BLOCK, Token.ON, Token.WARP, Token.INDENT, Token.DEDENT, Token.NEWLINE, Token.COLON, Token.LOOP]:
			break

		# property must be a valid identifier like "modulate" or "position.x"
		if not _is_valid_property(token):
			i += 1
			continue

		var prop := { val="" }
		var name := token.replace(".", ":")
		i += 1

		# collect expression tokens
		var expr_tokens := []
		var paren_level := []
		while i < tokens.size():
			var v := tokens[i]
			
			if v == ".":
				expr_tokens.append(v)
				i += 1
				continue
			
			if v.ends_with("("):
				paren_level.append([expr_tokens.size(), 0])
			elif v == ")":
				var count := paren_level.pop_back()
				var start_index: int = count[0]
				# Is not a function?
				if expr_tokens[start_index] == "(":
					var commas: int = count[1]
					match commas:
						0: pass
						1: expr_tokens[start_index] = "Vector2("
						2: expr_tokens[start_index] = "Vector3("
						3: expr_tokens[start_index] = "Color("
			elif v == ",":
				paren_level[-1][1] += 1
			
			# break if top-level property/structural token and no open parens
			elif paren_level.size() == 0 and (v in [Token.NEWLINE, Token.DEDENT, Token.COLON] or _is_valid_property(v)):
				break

			expr_tokens.append(v)
			i += 1

		if expr_tokens.size() > 0:
			for j in expr_tokens.size():
				if expr_tokens[j].begins_with("%"):
					var parts: PackedStringArray = expr_tokens[j].split(".", true, 1)
					expr_tokens[j] = "node.get_node(\"%s\").%s" % [parts[0], parts[1]]
			
			prop.val = "".join(expr_tokens)
		
		if not name in all_props:
			all_props.append(name)
		props[name] = prop

	return [props, i]

static func _is_wrapped(t: String, head := '"', tail := '"') -> bool:
	return t.begins_with(head) and t.ends_with(tail)

static func _is_valid_property(t: String) -> bool:
	if t.begins_with("%"): return true
	if "(" in t: return true
	if t != t.to_lower(): return false
	if "." in t: return t.replace(".", "_").is_valid_unicode_identifier()
	return t.is_valid_unicode_identifier()

static func _unwrap(s: String, head := '"', tail := '"') -> String:
	return s.trim_prefix(head).trim_suffix(tail)

```

# res://addons/twee/builder/twee_tokenizer.gd
```gd
extends RefCounted

const Token := preload("twee_tokens.gd")

static func tokenize(src: String) -> PackedStringArray:
	src = src.replace("!", "signal_args.")
	
	var tokens := PackedStringArray()
	var lines := src.split("\n", false)
	var indent_stack := [0]
	for line in lines:
		if line.strip_edges().is_empty():
			continue
		var stripped := line.lstrip("\t")
		var indent := line.length() - stripped.length()
		if indent > indent_stack[-1]:
			indent_stack.append(indent)
			tokens.append(Token.INDENT)
		elif indent < indent_stack[-1]:
			while indent < indent_stack[-1]:
				indent_stack.pop_back()
				tokens.append(Token.DEDENT)
		var REGEX := RegEx.create_from_string(
	r'("[^"]*"|\d+\.\d+|\d+|![a-zA-Z_]\w*(?:\(\))?|(?:[@^~%]?[a-zA-Z_]\w*)(?:\.[a-zA-Z_]\w*)*\(?|[@^()+\-*/%:,.])'
)
		var i := 0
		while i < stripped.length():
			var m := REGEX.search(stripped, i)
			if m == null: break
			tokens.append(m.get_string())
			i = m.get_end()
		tokens.append(Token.NEWLINE)
	while indent_stack.size() > 1:
		indent_stack.pop_back()
		tokens.append(Token.DEDENT)
	return tokens

```

# res://addons/twee/builder/twee_tokens.gd
```gd
extends RefCounted

const TRANS_NAMES: PackedStringArray = [
	"LINEAR", "L",
	"EASE", "E",
	"EASE_IN", "EI",
	"EASE_OUT", "EO",
	"EASE_OUT_IN", "EOI",
	
	"EASE_BACK", "E_BACK", "EI_BACK", "EO_BACK", "EOI_BACK",
	# TODO
]

const INDENT := "INDENT"
const DEDENT := "DEDENT"
const NEWLINE := "NEWLINE"
const COLON := ":"
const LOOP := "LOOP"
const WAIT := "WAIT"
const STRING := "STR"
const BLOCK := "BLOCK"
const PARALLEL := "PARALLEL"
const PARALLEL_SHORT := "PLL"
const ON := "ON"
const PROPERTIES_TWEENED := "PROPS_TWEENED"
const PROPERTIES := "PROPS"
#const REL := "+"
#const REL_NEG := "-"
#const REL_RUNTIME := "!"
const SPACE := "SPACE"
const PASS := "PASS"
const CHOICE := "CHOICE" # TODO
const WARP := "WARP" # TODO

const FOR := &"FOR"		# Beginning of a loop for nodes.
const CHILD := &"CHILD"	# 
const GROUP := &"GROUP"
const FIND := &"FIND"
const PROP := &"PROP"

#const T_INDENT := &"INDENT"
#const T_DEDENT := &"DEDENT"
#const T_NEWLINE := &"NEWLINE"
#const T_COLON := &":"
#const T_LOOP := &"LOOP"
#const T_WAIT := &"WAIT"
#const T_STRING := &"STR"
#const T_BLOCK := &"BLOCK"
#const T_PARALLEL := &"PARALLEL"
#const T_PARALLEL_SHORT := &"PLL"
#const T_ON := &"ON"
#const T_PROPERTIES_TWEENED := &"PROPS_TWEENED"
#const T_PROPERTIES := &"PROPS"
#const T_REL := &"+"
#const T_REL_NEG := &"-"
#const T_REL_RUNTIME := &"!"
#const T_SPACE := &"SPACE"
#
#const T_PASS := &"PASS" # TODO:
#const T_CHOICE := &"CHOICE" # TODO:
#const T_WARP := &"WARP" # TODO:

```

# res://addons/twee/nodes/twee_button.gd
```gd
@tool
class_name TweeButton extends TweeNode
## Meant to be a child of the TweeButtonList

signal other_chosen() ## Different node was chosen. Meant for a fade out.
signal chosen() ## I was chosen. Meant for a fade out.
signal hovered()
signal unhovered()
signal focused()
signal unfocused()

@export var mouse_hoverable := true: set=set_mouse_hoverable

func _init() -> void:
	if not Engine.is_editor_hint():
		if is_control():
			var con := as_control()
			con.focus_entered.connect(focus)
			con.focus_exited.connect(unfocus)

func set_mouse_hoverable(h: bool):
	mouse_hoverable = h
	var con := as_control()
	if mouse_hoverable:
		con.mouse_entered.connect(hover)
		con.mouse_exited.connect(unhover)
	else:
		con.mouse_entered.disconnect(hover)
		con.mouse_exited.disconnect(unhover)

func is_button() -> bool: return (self as Object) is Button
func as_button() -> Button: return (self as Object) as Button

func hover():
	if is_button():
		if not as_button().disabled: hovered.emit()

func unhover():
	if is_button():
		if not as_button().disabled: unhovered.emit()

func focus():
	if is_button():
		if not as_button().disabled: focused.emit()

func unfocus():
	if is_button():
		if not as_button().disabled: unfocused.emit()

func _get_configuration_warnings() -> PackedStringArray:
	var parent := get_parent()
	if parent and not parent is TweeButtonList:
		return ["TweeButton meant to be child of TweeButtonList."]
	return []

```

# res://addons/twee/nodes/twee_button_list.gd
```gd
@tool
class_name TweeButtonList extends TweeNode

signal selected(node: Node)

@export var disable_on_pressed := false
@export var focus_on_hovered := true
@export var focus_highlight: Control
var hovered := -1: set=set_hovered
var buttons: Array[TweeButton]

func _init() -> void:
	if not Engine.is_editor_hint():
		#remove_child(focus_highlight)
		child_entered_tree.connect(_child_entered)
		child_exiting_tree.connect(_child_exited)

func clear():
	for i in range(buttons.size()-1, -1, -1):
		remove_child(buttons[i])
		buttons[i].queue_free()
	buttons.clear()
	hovered = -1

func select() -> bool:
	if hovered != -1:
		_pressed(buttons[hovered])
		return true
	return false

func set_hovered(h: int) -> void:
	h = wrapi(h, 0, buttons.size())
	if hovered == h: return
	var last_hovered := hovered
	hovered = h
	for i in buttons.size():
		var node := buttons[i]
		if i == hovered: node.hover()
		elif i == last_hovered: node.unhover()

func _child_entered(child: Node):
	if not child is TweeButton: return
	if not child in buttons: buttons.append(child)
	if child is Button:
		var btn := child as Object as Button
		btn.pressed.connect(_pressed.bind(child))
		btn.focused.connect(_focused.bind(child))
		btn.unfocused.connect(_unfocused.bind(child))

func _child_exited(child: Node):
	if not child is TweeButton: return
	if child in buttons: buttons.erase(child)
	if child is Button:
		var btn := child as Object as Button
		btn.pressed.disconnect(_pressed)

func _unfocused(node: TweeButton):
	if focus_highlight:
		focus_highlight.modulate.a = 0.1
	
func _focused(node: TweeButton):
	if focus_highlight:
		focus_highlight.global_position = node.global_position
		focus_highlight.modulate.a = 1.0

func _pressed(node: TweeButton):
	for child in get_children():
		if child is TweeButton:
			if child == node:
				child.chosen.emit()
			else:
				child.other_chosen.emit()
		
		if disable_on_pressed and child is Button:
			(child as Button).disabled = true
	
	selected.emit(node)

func disable(...args):
	for child in get_children():
		if child is Button:
			child.text = str(args)
			child.disabled = true

func quit():
	get_tree().quit()

```

# res://addons/twee/nodes/twee_node.gd
```gd
@tool
@icon("res://addons/twee/icon.svg")
class_name TweeNode extends Node
## Applies a list of Twees to a Node.

signal event(str: String)

## Primary node that @ will reference.
@export var target: Node:
	get: return target if target else self

## Which node to loop for children on.
@export var for_child_target: Node:
	get: return for_child_target if for_child_target else self

## Scripts to apply to the nodes.
@export_storage var twees: Array[Twee]:
	set(t):
		twees = t
		notify_property_list_changed()

@export_storage var playing := false
@export_tool_button("Reload") var _tool_reload := reload
@export_tool_button("Kill") var _tool_kill := kill
@export_tool_button("Pause/Resume") var _took_toggle_play := func(): pause() if playing else play()

func _ready() -> void:
	if not Engine.is_editor_hint():
		reload()
	else:
		event.connect(print)

func play():
	playing = true
	for twn in twees:
		if twn and not twn.is_running(target):
			twn.play(target)

func pause():
	playing = false
	for twn in twees:
		if twn and twn.is_running(target):
			twn.pause(target)

func reload():
	playing = true
	for twn in twees:
		if twn: twn.reload(target, for_child_target)

func kill():
	playing = false
	for twn in twees:
		if twn: twn.kill(target)
	for meta_key in get_meta_list():
		if meta_key.begins_with("tweeny"):
			set_meta(meta_key, null)

func is_control() -> bool:
	return (self as Object) is Control

func as_control() -> Control:
	return (self as Object) as Control

#region Editor

func _get(property: StringName) -> Variant:
	if property.begins_with("_TWEE_"):
		var parts := property.trim_prefix("_TWEE_").rsplit("_", true, 1)
		var index := int(parts[1])
		return twees[index][parts[0]]
	return null

func _set(property: StringName, value: Variant) -> bool:
	if property.begins_with("_TWEE_"):
		var parts := property.trim_prefix("_TWEE_").rsplit("_", true, 1)
		var index := int(parts[1])
		twees[index][parts[0]] = value
		return true
	return false

func _property_can_revert(property: StringName) -> bool:
	if property.begins_with("_TWEE_"):
		var parts := property.trim_prefix("_TWEE_").rsplit("_", true, 1)
		return parts[0] in Twee.new()
	return false

func _property_get_revert(property: StringName) -> Variant:
	if property.begins_with("_TWEE_"):
		var parts := property.trim_prefix("_TWEE_").rsplit("_", true, 1)
		return Twee.new().get(parts[0])
	return null

func _get_property_list() -> Array[Dictionary]:
	var props: Array[Dictionary]
	for i in twees.size():
		var twee := twees[i]
		if not twee: continue
		props.append({ name="_TWEE_code_%s"%i, type=TYPE_STRING, hint=PROPERTY_HINT_EXPRESSION })
	props.append({ name="twees", type=TYPE_ARRAY, hint=PROPERTY_HINT_ARRAY_TYPE, hint_string="Twee" })
	return props

#endregion

```

# res://addons/twee/resources/twee.gd
```gd
@tool
@icon("res://addons/twee/icon.svg")
class_name Twee extends Resource

const Tokenizer := preload("../builder/twee_tokenizer.gd")
const Token := preload("../builder/twee_tokens.gd")
const Parser := preload("../builder/twee_parser.gd")
const ClassWriter := preload("../builder/twee_class_writer.gd")

@export_custom(PROPERTY_HINT_EXPRESSION, "") var code: String:
	set(t):
		code = t
		changed.emit()

@export_group("Defaults", "default_")
var _properties: Dictionary[StringName, Dictionary]

func get_property_type(node: Node, prop: StringName) -> int:
	if not prop in _properties:
		for p in node.get_property_list():
			if p.name == prop:
				_properties[prop] = p.type
				return p.type
	return _properties.get(prop, TYPE_NIL)

#region Access Tween

func _get_meta_key(node: Node) -> StringName:
	# For debug purposes, we'll use node id and resource id to create a meta key.
	# Resource instance id's are negative, and meta fields can't take a "-", so we remove it.
	var tween_prop := StringName("twee_%s_%s" % [node.get_instance_id(), str(get_instance_id()).substr(1)])
	return tween_prop

func get_tween(node: Node) -> Tween:
	var mk := _get_meta_key(node)
	if node.has_meta(mk):
		return node.get_meta(mk)
	return null

func is_running(node: Node) -> bool:
	var twn := get_tween(node)
	return twn and twn.is_running()

func kill(node: Node):
	var mk := _get_meta_key(node)
	if node.has_meta(mk):
		node.get_meta(mk).kill()
		node.set_meta(mk, null)

func play(node: Node):
	var twn := get_tween(node)
	if twn: twn.play()

func pause(node: Node):
	var twn := get_tween(node)
	if twn: twn.pause()

#endregion

func reload(root: Node, for_child_node: Node = null):
	if not code.strip_edges():
		push_warning("Code was empty.")
		return
	
	if not for_child_node:
		for_child_node = root
	
	var tween_prop := _get_meta_key(root)
	_properties = {}
	
	var toks := Tokenizer.tokenize(code)
	var pars := Parser.parse(toks)
	var print_source := false
	var twee_class := ClassWriter.new()
	_create_class(twee_class, pars)
	var scr := twee_class.create({  }, print_source)
	set_twee_script(root, scr)
	var twn := _create_tween(root, tween_prop, pars, root, scr, for_child_node)
	return twn

func set_twee_script(node: Node, script: GDScript):
	var id := "tweescript_%s_%s" % [node.get_instance_id(), abs(get_instance_id())]
	node.set_meta(id, script)

func get_twee_script(node: Node) -> GDScript:
	var id := "tweescript_%s_%s" % [node.get_instance_id(), abs(get_instance_id())]
	return node.get_meta(id)

static func prnt_tokens(cd: String):
	var toks := Tokenizer.tokenize(cd)
	print(toks)

static func prnt_parsed(cd: String):
	var toks := Tokenizer.tokenize(cd)
	var pars := Parser.parse(toks)
	print(JSON.stringify(pars, "\t", false))

static func prnt_source_code(cd: String):
	var toks := Tokenizer.tokenize(cd)
	var pars := Parser.parse(toks)
	var class_writer := ClassWriter.new()
	_create_class(class_writer, pars)
	var script_class := class_writer.create({})
	print(script_class.source_code)

static func _create_class(class_writer: ClassWriter, steps: Array[Dictionary]):
	for step in steps:
		match step.type:
			Token.FOR:
				match step.args[0]:
					Token.CHILD: _create_class(class_writer, step.children)
			Token.ON:
				for signal_id in step.args:
					_create_class(class_writer, step.children)
			Token.PARALLEL:
				_create_class(class_writer, step.children)
			Token.BLOCK:
				_create_class(class_writer, step.children)
			"METH":
				# Mutate
				step.meth = class_writer.add_static_func(step.meth, false)
			Token.LOOP: pass
			Token.WAIT: pass
			Token.STRING: pass
			Token.PROPERTIES_TWEENED:
				# Mutate
				for prop in step.props:
					var prop_info: Dictionary = step.props[prop]
					if not "mutated" in prop_info:
						prop_info.mutated = true
						prop_info.val = class_writer.add_static_func(prop_info.val)
			Token.PROPERTIES:
				# Mutate
				for prop in step.props:
					var prop_info: Dictionary = step.props[prop]
					if not "mutated" in prop_info:
						prop_info.mutated = true
						prop_info.val = class_writer.add_static_func(prop_info.val)

func _create_tween(node: Node, tween_prop: Variant, steps: Array[Dictionary], root: Node, scr: GDScript, for_child_node: Node) -> Tween:
	var twn: Tween = null
	for step in steps:
		match step.type:
			Token.FOR:
				match step.args[0]:
					Token.CHILD:
						for subnode in for_child_node.get_children():
							_create_tween(subnode, tween_prop, step.children, root, scr, for_child_node)
					Token.GROUP:
						for subnode in node.get_tree().get_nodes_in_group(step.args[1]):
							_create_tween(subnode, tween_prop, step.children, root, scr, for_child_node)
					Token.PROP:
						for subnode in for_child_node[step.args[1]]:
							if subnode:
								_create_tween(subnode, tween_prop, step.children, root, scr, for_child_node)
					Token.FIND:
						for subnode in for_child_node.find_children(step.args[1], step.args[2]):
							_create_tween(subnode, tween_prop, step.children, root, scr, for_child_node)
			Token.ON:
				for signal_id in step.args:
					node[signal_id].connect(func(...args):
						var sig_info := get_signal_info(node, signal_id)
						for i in args.size():
							if i < sig_info.args.size():
								var arg_info = sig_info.args[i]
								scr.signal_args[arg_info.name] = args[i]
						_create_tween(node, tween_prop, step.children, root, scr, for_child_node)
						)
			Token.PARALLEL:
				if not twn: twn = _tween(node, tween_prop)
				twn.set_parallel()
				_create_tween(node, twn, step.children, node, scr, for_child_node)
			Token.BLOCK:
				if not twn: twn = _tween(node, tween_prop)
				_create_tween(node, twn, step.children, node, scr, for_child_node)
			"METH":
				if not twn: twn = _tween(node, tween_prop)
				twn.tween_callback(scr.call.bind(step.meth, root, node))
			Token.LOOP:
				if twn:
					twn.set_loops(step.loop)
				else:
					push_error("No tween to repeat.")
			Token.WAIT:
				if not twn: twn = _tween(node, tween_prop)
				twn.tween_interval(step.wait)
			Token.STRING:
				# Call signal.
				if root.has_signal(&"_event"):
					if not twn: twn = _tween(node, tween_prop)
					twn.tween_callback(root[&"_event"].emit.bind(step.value))
				# Call method.
				elif root.has_method(&"_event"):
					if not twn: twn = _tween(node, tween_prop)
					twn.tween_callback(root[&"_event"].bind(step.value))
				else:
					push_warning("No event signal to emit.")
			Token.PROPERTIES_TWEENED:
				if not twn: twn = _tween(node, tween_prop)
				var duration: float = step.duration
				var sub := node.create_tween()
				sub.set_parallel()
				for prop in step.props:
					var prop_info: Dictionary = step.props[prop]
					var pt: Tweener
					var vars := {}
					var op := get_object_and_property(node, prop)
					var true_object: Object = op[0]
					var true_prop: String = op[1]
					var value: Variant = true_object.get_indexed(true_prop)
					vars[prop + "_a"] = value
					vars[prop + "_b"] = value
					if not node in scr.initial_state: scr.initial_state[node] = {}
					if not prop in scr.initial_state[node]: scr.initial_state[node][prop] = value
					sub.tween_callback(func():
						var a := true_object.get_indexed(true_prop)
						var b := scr.call(prop_info.val, root, node)
						vars[prop + "_a"] = a
						vars[prop + "_b"] = b if b != null else a)
					pt = sub.tween_method(func(t: float):
						var a: Variant = vars[prop + "_a"]
						var b: Variant = vars[prop + "_b"]
						true_object.set_indexed(true_prop, lerp(a, type_convert(b, typeof(a)), t)), 0.0, 1.0, duration)
					var mode: StringName = step.get(&"mode", &"LINEAR")
					if mode != &"LINEAR" and mode != &"L":
						var parts := mode.split("_", true, 1)
						match parts[0]:
							"EASE", "E": pt.set_trans(Tween.TRANS_SINE)
							"EASEIN", "EI": pt.set_ease(Tween.EASE_IN)
							"EASEOUT", "EO": pt.set_ease(Tween.EASE_OUT)
							"EASEOUTIN", "EOI": pt.set_ease(Tween.EASE_OUT_IN)
						if parts.size() == 1:
							pt.set_trans(Tween.TRANS_SINE)
						else:
							match parts[1]:
								#"SINE": pt.set_trans(Tween.TRANS_SINE)
								"QUINT": pt.set_trans(Tween.TRANS_QUINT)
								"QUART": pt.set_trans(Tween.TRANS_QUART)
								"QUAD": pt.set_trans(Tween.TRANS_QUAD)
								"EXPO": pt.set_trans(Tween.TRANS_EXPO)
								"ELASTIC": pt.set_trans(Tween.TRANS_ELASTIC)
								"CUBIC": pt.set_trans(Tween.TRANS_CUBIC)
								"CIRC": pt.set_trans(Tween.TRANS_CIRC)
								"BOUNCE": pt.set_trans(Tween.TRANS_BOUNCE)
								"BACK": pt.set_trans(Tween.TRANS_BACK)
								"SPRING": pt.set_trans(Tween.TRANS_SPRING)
				twn.tween_subtween(sub)
			Token.PROPERTIES:
				for prop in step.props:
					var prop_info: Dictionary = step.props[prop]
					if not node in scr.initial_state: scr.initial_state[node] = {}
					if not prop in scr.initial_state[node]:
						var op := get_object_and_property(node, prop)
						var true_object: Object = op[0]
						var true_prop: String = op[1]
						scr.initial_state[node][prop] = true_object.get_indexed(true_prop)
				if not twn: twn = _tween(node, tween_prop)
				twn.tween_callback(func():
					for prop in step.props:
						var prop_info: Dictionary = step.props[prop]
						var op := get_object_and_property(node, prop)
						var true_object: Object = op[0]
						var true_prop: String = op[1]
						var result: Variant = scr[prop_info.val].call(root, node)
						true_object.set_indexed(true_prop, result)
						)
	return twn

static func get_object_and_property(node: Node, prop: String) -> Array:
	var subnode: Node = node
	if prop.begins_with("%"):
		var parts := prop.split(":", true, 1)
		subnode = node.get_node_or_null(parts[0])
		prop = parts[1]
	var node_and_resource := subnode.get_node_and_resource(prop)
	var n: Node = node_and_resource[0]
	var r: Resource = node_and_resource[1]
	var p: NodePath = node_and_resource[2]
	return [r if r else n if n else node, p if p else prop]

static func get_signal_info(node: Node, signame: StringName) -> Dictionary:
	for sig in node.get_signal_list():
		if sig.name == signame:
			return sig
	return {}

static func _tween(node: Node, tween_prop: Variant) -> Tween:
	if tween_prop is StringName:
		if node.has_meta(tween_prop):
			node.get_meta(tween_prop).kill()
		var twn := node.create_tween()
		node.set_meta(tween_prop, twn)
		twn.finished.connect(node.set_meta.bind(tween_prop, null))
		return twn
	elif tween_prop is Tween:
		var twn: Tween = node.create_tween()
		(tween_prop as Tween).tween_subtween(twn)
		return twn
	return null

```

# res://addons/twee/twee_plugin.gd
```gd
@tool
extends EditorPlugin

var inspector_plugin := TweeInspector.new()# preload("twee_inspector.gd").new()
const Tokenizer := preload("builder/twee_tokenizer.gd")

func _enter_tree():
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)

class TweeInspector extends EditorInspectorPlugin:
	func _can_handle(object: Object) -> bool:
		return object is TweeNode

	func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
		if object is TweeNode and name.begins_with("_TWEE_"):
			var hl := CodeHighlighter.new()
			var settings := EditorInterface.get_editor_settings()
			for b in [
				"Color", "Vector2", "Vector3", "Transform2D", "Transform3D", "Basis", "Quaternion",
				"Node", "Node2D", "Node3D", "Object", "Resource", "Dictionary", "Array", "PackedStringArray" ]:
				hl.add_keyword_color(b, settings.get("text_editor/theme/highlighting/user_type_color"))
			
			var node_color = settings.get("text_editor/theme/highlighting/gdscript/node_path_color")
			#var props := 0
			#for prop in object.get_property_list():
				#if prop.usage & PROPERTY_USAGE_DEFAULT:
					#hl.add_keyword_color(prop.name, Color.PALE_VIOLET_RED)
					#props += 1
			
			var trans_color =  Color.AQUAMARINE #settings.get("text_editor/theme/highlighting/comment_markers/critical_color")
			for key in ["L", "LINEAR", "EASE", "E", "EASE_IN", "EI", "EASE_OUT", "EO",
				"E_BACK", "EI_BACK", "EO_BACK", "EOI_BACK"]:
				hl.add_keyword_color(key, trans_color)
			
			#for prop in object.get_signal_list():
				#hl.add_keyword_color(prop.name, Color.PALE_VIOLET_RED)
			
			hl.number_color = settings.get("text_editor/theme/highlighting/number_color")
			hl.symbol_color = settings.get("text_editor/theme/highlighting/symbol_color")
			hl.function_color = settings.get("text_editor/theme/highlighting/function_color")
			hl.member_variable_color = settings.get("text_editor/theme/highlighting/member_variable_color")
			hl.add_color_region("\"", "\"", settings.get("text_editor/theme/highlighting/string_color"))
			hl.add_color_region("'", "'", settings.get("text_editor/theme/highlighting/string_color"))
			var bool_color = settings.get("text_editor/theme/highlighting/keyword_color")
			hl.add_keyword_color("true", bool_color)
			hl.add_keyword_color("false", bool_color)
			var builtin_color = Color.PALE_GOLDENROD#settings.get("text_editor/theme/highlighting/gdscript/annotation_color")
			for prop in ["ON", "PARALLEL", "BLOCK", "LOOP", "FOR", "CHILD", "GROUP", "FIND", "PROP"]:
				hl.add_keyword_color(prop, builtin_color)
			hl.add_color_region("#", "", settings.get("text_editor/theme/highlighting/comment_color"), true)
			
			var vbox := VBoxContainer.new()
			vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			var hbox := HBoxContainer.new()
			vbox.add_child(hbox)
			hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			for btn_dat in [
				["Tokens", func(): Twee.prnt_tokens(object[name]), "Print tokens to output."],
				["Parsed", func(): Twee.prnt_parsed(object[name]), "Print parser to output."],
				["Source", func(): Twee.prnt_source_code(object[name]), "Print source_code to output."],
				["Run", func(): pass, "Not Implemented..."],
				["End", func(): pass, "Not Implemented..."]
				]:
				var btn := Button.new()
				hbox.add_child(btn)
				btn.text = btn_dat[0]
				btn.pressed.connect(btn_dat[1])
				btn.tooltip_text = btn_dat[2]
				btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			
			var editor := CodeEdit.new()
			vbox.add_child(editor)
			editor.gutters_draw_line_numbers = true
			editor.text = object.get(name)
			editor.syntax_highlighter = hl
			editor.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			editor.highlight_current_line = true
			editor.highlight_all_occurrences = true
			editor.text_changed.connect(func(): object.set(name, editor.text))
			editor.custom_minimum_size.y = 300.0
			add_property_editor(name, vbox)
			return true
		return false

```

# res://addons/yaml/editor/code_edit.gd
```gd
class_name YAMLCodeEdit extends CodeEdit

var syntax_highlighter_script = preload("res://addons/yaml/editor/syntax_highlighting/syntax_highlighter.gd")

func _init() -> void:
	# YAML indentation
	set_indent_size(2)
	set_indent_using_spaces(true)
	indent_automatic = true
	indent_automatic_prefixes = [":"]

	# Syntax highlighting
	if not syntax_highlighter:
		syntax_highlighter = syntax_highlighter_script.new()

```

# res://addons/yaml/editor/code_editor.gd
```gd
@tool
class_name YAMLCodeEditor extends CodeEdit

signal content_changed
signal save_requested
signal close_requested
signal undo_requested
signal redo_requested
signal validation_requested
signal zoom_changed(zoom_level)  # New signal for zoom changes

var error_indicators := {}
var snapshot_debounce_timer: Timer
var error_line_color: Color = Color(1.0, 0.3, 0.3, 0.1)
var syntax_highlighter_script = preload("res://addons/yaml/editor/syntax_highlighting/editor_syntax_highlighter.gd")
var suppress_text_changed: bool = false

# Zoom functionality variables
var zoom_level: float = 1.0  # 100%
var default_font_size: int = 14  # Default font size

func _ready() -> void:
	# Clear text to reset the editor state
	text = ""

	# YAML indentation
	set_indent_size(2)
	set_indent_using_spaces(true)
	indent_automatic_prefixes = [":"]
	scroll_smooth = true
	set_highlight_current_line(true)

	# Syntax highlighting
	if not syntax_highlighter:
		syntax_highlighter = syntax_highlighter_script.new()

	# Do not lose selection when focus is lost
	deselect_on_focus_loss_enabled = false
	set_focus_mode(Control.FOCUS_ALL)

	# Create debounce timer for content changes
	snapshot_debounce_timer = Timer.new()
	add_child(snapshot_debounce_timer)
	snapshot_debounce_timer.one_shot = true
	snapshot_debounce_timer.wait_time = 0.3  # 300ms
	snapshot_debounce_timer.timeout.connect(_on_snapshot_debounce_timeout)

	# Connect signals
	text_changed.connect(_on_text_changed)
	gui_input.connect(_on_gui_input_focus)

	# Register YAML code completion
	register_yaml_code_completion()

	# Apply initial font size
	_update_font_size()

func _on_text_changed() -> void:
	if suppress_text_changed:
		return

	# Clear error indicators when text changes
	clear_error_indicators()

	# Request a snapshot with debounce
	snapshot_debounce_timer.start()

func _on_snapshot_debounce_timeout() -> void:
	# Emit content changed signal
	content_changed.emit()

	# Request validation
	validation_requested.emit()

func _on_gui_input_focus(event: InputEvent) -> void:
	# Grab focus when clicked
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		grab_focus()

func cut_selection() -> void:
	if has_selection():
		# Cut the selected text to clipboard
		DisplayServer.clipboard_set(get_selected_text())
		delete_selection()
	else:
		# If no selection, cut the current line (like default script editor)
		var line := get_caret_line()
		var line_text := get_line(line)
		DisplayServer.clipboard_set(line_text)

		# Delete the current line
		select(line, 0, line, line_text.length())
		delete_selection()

		# If this isn't the last line, also remove the line break
		if line < get_line_count() - 1:
			select(line, 0, line + 1, 0)
			delete_selection()

	# Trigger content changed
	text_changed.emit()

func copy_selection() -> void:
	if has_selection():
		# Copy selected text to clipboard
		DisplayServer.clipboard_set(get_selected_text())
	else:
		# If no selection, copy the current line
		var line := get_caret_line()
		var line_text := get_line(line)
		DisplayServer.clipboard_set(line_text)

func paste_clipboard() -> void:
	# Get clipboard content
	var clipboard = DisplayServer.clipboard_get()
	if clipboard.is_empty():
		return

	if has_selection():
		# Replace selected text with clipboard content
		delete_selection()

	# Insert clipboard content at caret position
	insert_text_at_caret(clipboard)
	text_changed.emit()

# Zoom management functions
func zoom_in() -> void:
	zoom_level = min(zoom_level + 0.07, 3.0)  # Max 200%
	_update_font_size()
	zoom_changed.emit(zoom_level)

func zoom_out() -> void:
	zoom_level = max(zoom_level - 0.07, 0.25)  # Min 50%
	_update_font_size()
	zoom_changed.emit(zoom_level)

func zoom_reset() -> void:
	zoom_level = 1.0
	_update_font_size()
	zoom_changed.emit(zoom_level)

func set_zoom(zoom: float) -> void:
	zoom_level = max(0.25, min(3.0, zoom))
	_update_font_size()
	zoom_changed.emit(zoom_level)

func _update_font_size() -> void:
	var new_size = int(default_font_size * zoom_level)
	add_theme_font_size_override("font_size", new_size)

func _unhandled_key_input(event: InputEvent) -> void:
	# Handle tab key before focus system gets it
	if event is InputEventKey and event.pressed and has_focus():
		match event.keycode:
			KEY_TAB:
				if event.shift_pressed:
					# Handle Shift+Tab for unindent
					_handle_unindent()
				else:
					# Handle Tab for indent
					_handle_indent()
				get_viewport().set_input_as_handled()
				return

func _gui_input(event: InputEvent) -> void:
	# Handle shortcuts for saving/closing
	if event is InputEventKey and event.pressed:
		match event.get_keycode_with_modifiers():
			KEY_MASK_CTRL | KEY_S:
				save_requested.emit()
				get_viewport().set_input_as_handled()
			KEY_MASK_CTRL | KEY_W:
				close_requested.emit()
				get_viewport().set_input_as_handled()
			KEY_ENTER, KEY_KP_ENTER:
				# Handle auto-continuation of YAML structures
				_handle_enter_key()
				get_viewport().set_input_as_handled()
			KEY_MASK_CTRL | KEY_Z:
				# Handle undo
				undo_requested.emit()
				get_viewport().set_input_as_handled()
			KEY_MASK_CTRL | KEY_Y, KEY_MASK_CTRL | KEY_MASK_SHIFT | KEY_Z:
				# Handle redo (supports both Ctrl+Y and Ctrl+Shift+Z)
				redo_requested.emit()
				get_viewport().set_input_as_handled()
			KEY_MASK_CTRL | KEY_EQUAL, KEY_MASK_CTRL | KEY_KP_ADD:
				zoom_in()
			KEY_MASK_CTRL | KEY_MINUS, KEY_MASK_CTRL | KEY_KP_SUBTRACT:
				zoom_out()
			KEY_MASK_CTRL | KEY_0, KEY_MASK_CTRL | KEY_KP_0:
				zoom_reset()

func set_text_and_preserve_state(new_text: String, preserve_state: bool = true) -> void:
	if preserve_state:
		# Save current state
		var previous_caret_pos := get_caret_column()
		var previous_line := get_caret_line()
		var previous_scroll_v := get_v_scroll_bar().value
		var previous_scroll_h := get_h_scroll_bar().value

		# Set text without triggering our own text_changed handler
		suppress_text_changed = true
		text = new_text
		suppress_text_changed = false

		# Restore state if possible
		if previous_line < get_line_count():
			set_caret_line(previous_line)
			var line_length := get_line(previous_line).length()
			if previous_caret_pos <= line_length:
				set_caret_column(previous_caret_pos)

		# Restore scroll position (with a small delay to ensure the text is updated first)
		call_deferred("_restore_scroll_position", previous_scroll_v, previous_scroll_h)
	else:
		# Just set the text without preserving state
		suppress_text_changed = true
		text = new_text
		suppress_text_changed = false

func _restore_scroll_position(v_scroll: float, h_scroll: float) -> void:
	# Wait for one frame to ensure the text has been updated and rendered
	if get_tree():
		await get_tree().process_frame
		get_v_scroll_bar().value = v_scroll
		get_h_scroll_bar().value = h_scroll

func _handle_indent() -> void:
	# Get current line and text
	var line := get_caret_line()
	var line_text := get_line(line)

	# Get selection so we can handle multi-line indentation
	var selection_active := has_selection()
	var selection_from := get_selection_from_line()
	var selection_to := get_selection_to_line()

	if selection_active:
		# Indent multiple lines
		begin_complex_operation()
		for i in range(selection_from, selection_to + 1):
			set_line(i, "  " + get_line(i))
		end_complex_operation()
	else:
		# Simple indent - insert 2 spaces at caret position
		insert_text_at_caret("  ")

	# Trigger text changed to update the document
	text_changed.emit()

func _handle_unindent() -> void:
	# Get current line and text
	var line := get_caret_line()
	var text := get_line(line)

	# Get selection so we can handle multi-line unindentation
	var selection_active := has_selection()
	var selection_from := get_selection_from_line()
	var selection_to := get_selection_to_line()

	if selection_active:
		# Unindent multiple lines
		begin_complex_operation()
		for i in range(selection_from, selection_to + 1):
			var line_text := get_line(i)
			if line_text.begins_with("  "):
				set_line(i, line_text.substr(2))
			elif line_text.begins_with(" "):
				set_line(i, line_text.substr(1))
		end_complex_operation()
	else:
		# Simple unindent - remove up to 2 spaces from beginning of line
		if text.begins_with("  "):
			set_line(line, text.substr(2))
			set_caret_column(max(0, get_caret_column() - 2))
		elif text.begins_with(" "):
			set_line(line, text.substr(1))
			set_caret_column(max(0, get_caret_column() - 1))

func _handle_enter_key() -> void:
	var line := get_caret_line()
	var line_text := get_line(line)

	# Auto-continuation for lists
	if "- " in line_text:
		var indent_level := 0
		for c in line_text:
			if c == ' ':
				indent_level += 1
			else:
				break

		# Insert the line with the same indentation and list marker
		var new_line := "\n" + " ".repeat(indent_level) + "- "
		insert_text_at_caret(new_line)
	else:
		# Regular line break with preserved indentation
		var indent_level := 0
		for c in line_text:
			if c == ' ':
				indent_level += 1
			else:
				break

		# Increased indentation if the line ends with a colon
		if line_text.strip_edges().ends_with(":"):
			indent_level += 2

		insert_text_at_caret("\n" + " ".repeat(indent_level))

func register_yaml_code_completion() -> void:
	# Register common YAML keywords and patterns for code completion
	var keyword_list: PackedStringArray = [
		"true",
		"false",
		"null",
		"~",
		"INF",
		"-INF"
	]

	# Add keywords and tags to completion
	for keyword in keyword_list:
		add_code_completion_option(CodeCompletionKind.KIND_CONSTANT, keyword, keyword)

	## YAML tags
	var tag_list: PackedStringArray = [
		"!Resource",
		"!AABB",
		"!Basis",
		"!Color",
		"!NodePath",
		"!PackedByteArray",
		"!PackedColorArray",
		"!PackedFloat32Array",
		"!PackedFloat64Array",
		"!PackedInt32Array",
		"!PackedInt64Array",
		"!PackedStringArray",
		"!PackedVector2Array",
		"!PackedVector3Array",
		"!Plane",
		"!Projection",
		"!Quaternion",
		"!Rect2",
		"!Rect2i",
		"!StringName",
		"!Transform2D",
		"!Transform3D",
		"!Vector2",
		"!Vector2i",
		"!Vector3",
		"!Vector3i",
		"!Vector4",
		"!Vector4i"
	]

	for tag in tag_list:
		add_code_completion_option(CodeCompletionKind.KIND_CLASS, tag, tag)

func mark_error_line(line: int, message: String) -> void:
	if line < 0 or line >= get_line_count():
		return

	# Set line background to error color
	var error_color: Color = EditorInterface.get_editor_settings().get_setting("text_editor/theme/highlighting/mark_color")
	set_line_background_color(line, error_color)

	# Set gutter icon
	var error_icon := get_theme_icon("StatusError", "EditorIcons")
	if error_icon:
		set_line_gutter_icon(line, 0, error_icon)

	# Store for later reference
	error_indicators[line] = message

func clear_error_indicators() -> void:
	for line: int in error_indicators:
		set_line_background_color(line, Color(0, 0, 0, 0))
		set_line_gutter_icon(line, 0, null)

	error_indicators.clear()

func get_current_line_col_info() -> Array[int]:
	var line := get_caret_line() + 1
	var col := get_caret_column() + 1
	return [line, col]

```

# res://addons/yaml/editor/document.gd
```gd
@tool
class_name YAMLEditorDocument extends RefCounted

# Primary document data
var path: String
var content: String
var is_modified: bool = false
var validation_result: YAMLResult

# History management
class HistoryState extends RefCounted:
	var text: String
	var caret_line: int = 0
	var caret_column: int = 0

	func _init(p_text: String, p_line: int = 0, p_column: int = 0) -> void:
		text = p_text
		caret_line = p_line
		caret_column = p_column

	func _to_string() -> String:
		return "HistoryState(text_length=%d, line=%d, column=%d)" % [text.length(), caret_line, caret_column]

# Limit history size to prevent excessive memory use
const MAX_HISTORY := 100

var history_states: Array[HistoryState] = []
var current_history_index: int = -1
var saved_history_index: int = -1

# Signals
signal content_changed(document)
signal validation_changed(document)
signal modified_changed(document)

# Constructor
func _init(p_path: String, p_content: String = "") -> void:
	path = p_path
	content = p_content
	validation_result = YAMLResult.new()  # Empty result

	# Take initial snapshot if content isn't empty
	if not p_content.is_empty():
		_add_history_state(HistoryState.new(p_content))

# File path utilities
func get_file_name() -> String:
	return path.get_file()

func is_untitled() -> bool:
	return path.begins_with("untitled")

# Content management
func set_content(new_content: String, caret_line: int = 0, caret_column: int = 0) -> void:
	if content == new_content:
		return

	content = new_content
	_add_history_state(HistoryState.new(new_content, caret_line, caret_column))
	set_modified(true)
	content_changed.emit(self)

# Modification state
func set_modified(modified: bool) -> void:
	if is_modified == modified:
		return

	is_modified = modified
	modified_changed.emit(self)

# Validation management
func set_validation_result(result: YAMLResult) -> void:
	validation_result = result
	validation_changed.emit(self)

func has_error() -> bool:
	return validation_result and validation_result.has_error()

# History management
func can_undo() -> bool:
	return current_history_index > 0  # Need at least one previous state

func can_redo() -> bool:
	return current_history_index < history_states.size() - 1

func undo() -> HistoryState:
	if not can_undo():
		return null

	current_history_index -= 1
	var state := history_states[current_history_index]
	content = state.text

	# Update modification state
	set_modified(current_history_index != saved_history_index)
	content_changed.emit(self)

	return state

func redo() -> HistoryState:
	if not can_redo():
		return null

	current_history_index += 1
	var state := history_states[current_history_index]
	content = state.text

	# Update modification state
	set_modified(current_history_index != saved_history_index)
	content_changed.emit(self)

	return state

func mark_saved() -> void:
	saved_history_index = current_history_index
	set_modified(false)

func _add_history_state(state: HistoryState) -> void:
	# If we're not at the end of history, truncate future states
	if current_history_index < history_states.size() - 1:
		history_states = history_states.slice(0, current_history_index + 1)

	# Add the new state
	history_states.append(state)
	current_history_index = history_states.size() - 1

	if history_states.size() > MAX_HISTORY:
		var excess := history_states.size() - MAX_HISTORY
		history_states = history_states.slice(excess)
		current_history_index -= excess

		# Adjust saved index if needed
		if saved_history_index >= 0:
			saved_history_index -= excess
			if saved_history_index < 0:
				saved_history_index = -1

```

# res://addons/yaml/editor/document_manager.gd
```gd
@tool
class_name YAMLEditorDocumentManager extends Node

signal document_changed(document)
signal document_created(document)
signal document_closed(document)

# Dictionary of open documents: {path: YAMLEditorDocument}
var documents: Dictionary = {}
var current_document: YAMLEditorDocument = null

# UI components
var file_list: YAMLEditorFileList
var code_editor: YAMLCodeEditor
var file_popup_menu: PopupMenu

# Reference to the singleton
var file_system: YAMLFileSystem

# Track recently saved files to avoid external update conflicts
var recently_saved_files: Dictionary = {}
var ignore_update_timer: Timer

func _ready() -> void:
	# Get singleton reference
	file_system = YAMLFileSystem.get_singleton()

	# Listen for external file updates
	file_system.file_updated.connect(_on_external_file_updated)
	file_system.file_renamed.connect(_on_file_renamed)

	# Create file popup menu
	file_popup_menu = PopupMenu.new()
	add_child(file_popup_menu)

	# Add menu items
	file_popup_menu.add_item("Save", 0)
	file_popup_menu.add_item("Save As...", 1)
	file_popup_menu.add_separator()
	file_popup_menu.add_item("Close", 2)
	file_popup_menu.add_separator()
	file_popup_menu.add_item("Show in FileSystem", 3)

	# Connect popup menu signals
	file_popup_menu.id_pressed.connect(_on_file_popup_menu_id_pressed)

	# Create timer for clearing recent saves
	ignore_update_timer = Timer.new()
	add_child(ignore_update_timer)
	ignore_update_timer.one_shot = true
	ignore_update_timer.wait_time = 0.5  # 500ms
	ignore_update_timer.timeout.connect(_on_ignore_update_timer_timeout)

func setup(p_file_list: YAMLEditorFileList, p_code_editor: YAMLCodeEditor) -> void:
	file_list = p_file_list
	code_editor = p_code_editor

	# Connect signals from file list component
	file_list.file_selected.connect(_on_file_selected)
	file_list.file_context_requested.connect(_on_file_context_requested)

func create_document(path: String, content: String = "") -> YAMLEditorDocument:
	var normalized_path = _normalize_path(path)

	# Check if document already exists with normalized path
	if documents.has(normalized_path):
		return documents[normalized_path]

	var document := YAMLEditorDocument.new(normalized_path, content)

	# Connect document signals
	document.content_changed.connect(_on_document_content_changed)
	document.modified_changed.connect(_on_document_modified_changed)

	# Store document
	documents[normalized_path] = document
	document_created.emit(document)

	return document

func open_file(path: String) -> void:
	var normalized_path = _normalize_path(path)

	# Check if already open
	if documents.has(normalized_path):
		set_current_document(documents[normalized_path])
		return

	# Look for any document with the same base filename
	var filename = normalized_path.get_file()
	for existing_path in documents.keys():
		if existing_path.get_file() == filename and existing_path != normalized_path:
			# Check if they point to the same actual file
			if _paths_point_to_same_file(normalized_path, existing_path):
				set_current_document(documents[existing_path])
				return

	# Use the file system singleton to read the file
	var content := file_system.read_file(normalized_path)
	if typeof(content) == TYPE_INT:  # Error code
		push_error("Could not open file '%s': %s" % [normalized_path, error_string(content)])
		return

	# Create new document
	var document := create_document(normalized_path, content)
	document.mark_saved()  # Initial state is saved

	# Switch to the new document
	set_current_document(document)

	# Notify the file system
	file_system.notify_file_opened(normalized_path)

func close_document(document: YAMLEditorDocument) -> bool:
	if document == null:
		return true

	if document.is_modified:
		# Show confirmation dialog for unsaved changes
		var dialog := ConfirmationDialog.new()
		dialog.title = "Unsaved Changes"
		dialog.dialog_text = "Save changes to '" + document.get_file_name() + "' before closing?"
		dialog.add_button("Don't Save", true, "dont_save")
		dialog.add_cancel_button("Cancel")

		dialog.confirmed.connect(
			func():
				# Save was chosen
				if save_document(document):
					_close_document_internal(document)
				dialog.queue_free()
		)

		dialog.custom_action.connect(
			func(action):
				if action == "dont_save":
					_close_document_internal(document)
				dialog.queue_free()
		)

		dialog.canceled.connect(func(): dialog.queue_free())

		add_child(dialog)
		dialog.popup_centered()
		return false

	return _close_document_internal(document)

func _close_document_internal(document: YAMLEditorDocument) -> bool:
	if document == null:
		return false

	# Find the document in our dictionary
	var path_to_remove = ""
	for path in documents.keys():
		if documents[path] == document:
			path_to_remove = path
			break

	if path_to_remove.is_empty():
		return false

	# Notify document is being closed
	document_closed.emit(document)

	# Remove document
	documents.erase(document.path)

	# If this was the current document, switch to another
	if current_document == document:
		current_document = null

		# Select another document if available
		if not documents.is_empty():
			set_current_document(documents.values()[0])
		else:
			# Clear the editor if no documents left
			code_editor.text = ""

	# Update UI
	update_ui()

	# Notify the file system
	file_system.notify_file_closed(document.path)

	return true

func save_document(document: YAMLEditorDocument) -> bool:
	if document == null:
		return false

	# Don't save untitled files directly
	if document.is_untitled():
		return false  # Caller should handle "Save As" dialog

	# Mark this file as recently saved to ignore update notifications
	recently_saved_files[document.path] = Time.get_unix_time_from_system()
	ignore_update_timer.start()

	# Use the file system singleton to save the file
	var result := file_system.save_file(document.path, document.content)
	if result != OK:
		push_error("Could not save file '%s': %s" % [document.path, error_string(result)])
		recently_saved_files.erase(document.path)  # Remove from recently saved if error
		return false

	# Mark document as saved
	document.mark_saved()

	# Update UI
	update_ui()

	return true

func save_document_as(document: YAMLEditorDocument, new_path: String) -> bool:
	if document == null or new_path.is_empty():
		return false

	var normalized_new_path = _normalize_path(new_path)

	# Check if we're trying to save to a path that's already open
	if documents.has(normalized_new_path) and documents[normalized_new_path] != document:
		push_error("Cannot save as '%s' - file is already open" % normalized_new_path)
		return false

	# Remember the old path
	var old_path := document.path

	# Update document path
	document.path = normalized_new_path

	# Update the documents dictionary
	if old_path != normalized_new_path:
		documents.erase(old_path)
		documents[normalized_new_path] = document

	# Save the document
	if save_document(document):
		# If old path was temporary, clean up
		if old_path != normalized_new_path  and old_path.begins_with("untitled"):
			file_system.notify_file_closed(old_path)

		# Update UI
		update_ui()

		# Notify file system
		file_system.notify_file_opened(new_path)

		return true

	# Restore old path if save failed
	if old_path != normalized_new_path:
		document.path = old_path
		documents.erase(normalized_new_path)
		documents[old_path] = document

	return false

func new_file() -> void:
	# Create a new untitled file
	var untitled_name := "untitled.yaml"
	var index := 1

	while documents.has(untitled_name):
		index += 1
		untitled_name = "untitled%d.yaml" % index

	# Create a new document
	var document := create_document(untitled_name)
	document.set_modified(true)  # New document is always modified

	# Switch to the new document
	set_current_document(document)

	# Set focus to code editor
	code_editor.grab_focus()

	# Notify the file system
	file_system.notify_file_opened(untitled_name)

func set_current_document(document: YAMLEditorDocument) -> void:
	if document == null or document == current_document:
		return

	current_document = document

	# Update editor content
	if is_instance_valid(code_editor):
		code_editor.set_text_and_preserve_state(document.content)

	# Update UI
	update_ui()

	# Emit signal
	document_changed.emit(document)

func update_document_content(document: YAMLEditorDocument, new_content: String) -> void:
	if document == null:
		return

	var caret_line := 0
	var caret_column := 0

	if is_instance_valid(code_editor):
		caret_line = code_editor.get_caret_line()
		caret_column = code_editor.get_caret_column()

	document.set_content(new_content, caret_line, caret_column)

func _normalize_path(path: String) -> String:
	# Convert to absolute path and normalize
	var normalized = path

	# Handle different path formats
	if normalized.begins_with("res://"):
		normalized = ProjectSettings.globalize_path(normalized)

	# Convert to canonical form
	normalized = normalized.simplify_path()

	# Convert back to res:// format if it was originally a project path
	if path.begins_with("res://"):
		normalized = ProjectSettings.localize_path(normalized)

	return normalized

func _paths_point_to_same_file(path1: String, path2: String) -> bool:
	# For project files, compare the res:// paths
	if path1.begins_with("res://") and path2.begins_with("res://"):
		return path1 == path2

	# For absolute paths, normalize and compare
	var abs_path1 = ProjectSettings.globalize_path(path1) if path1.begins_with("res://") else path1
	var abs_path2 = ProjectSettings.globalize_path(path2) if path2.begins_with("res://") else path2

	return abs_path1.simplify_path() == abs_path2.simplify_path()

func _on_document_content_changed(document: YAMLEditorDocument) -> void:
	# Update UI if this is the current document
	if document == current_document:
		update_ui()

func _on_document_modified_changed(document: YAMLEditorDocument) -> void:
	# Update UI if this is the current document
	if document == current_document:
		update_ui()

func update_ui() -> void:
	if not is_instance_valid(file_list):
		return

	# Prepare file data for the file list component
	var file_data := {}
	for path in documents:
		var document = documents[path]
		file_data[path] = {
			"name": document.get_file_name(),
			"modified": document.is_modified
		}

	# Update the file list component
	var current_path = current_document.path if current_document else ""
	file_list.update_files(file_data, current_path)

func _on_file_selected(path: String) -> void:
	if path.is_empty():
		return

	var normalized_path = _normalize_path(path)
	if not documents.has(normalized_path):
		return

	set_current_document(documents[normalized_path])

func _on_file_context_requested(path: String, at_position: Vector2) -> void:
	if path.is_empty():
		return

	var normalized_path = _normalize_path(path)
	if not documents.has(normalized_path):
		return

	set_current_document(documents[normalized_path])

	# Calculate the global position for the popup
	var global_rect := Rect2(file_list.get_global_mouse_position(), Vector2.ZERO)
	file_popup_menu.popup_on_parent(global_rect)

func _on_file_popup_menu_id_pressed(id: int) -> void:
	var path := file_list.get_selected_file_path()
	if path.is_empty():
		return

	var normalized_path = _normalize_path(path)
	if not documents.has(normalized_path):
		return

	var document: YAMLEditorDocument = documents[normalized_path]

	match id:
		0:  # Save
			save_document(document)
		1:  # Save As
			# Main editor should handle the save as dialog
			set_current_document(document)
		2:  # Close
			close_document(document)
		3:  # Show in FileSystem
			if not document.is_untitled() and document.path.begins_with("res://"):
				EditorInterface.get_file_system_dock().navigate_to_path(document.path)

func _on_external_file_updated(path: String) -> void:
	var normalized_path = _normalize_path(path)

	# Only process if the file is open and it's a YAML file
	if documents.has(normalized_path) and file_system.is_yaml_file(normalized_path):
		# Check if we just saved this file ourselves
		if recently_saved_files.has(normalized_path):
			var save_time: int = recently_saved_files[normalized_path]
			var current_time := Time.get_unix_time_from_system()

			# If saved less than 1 second ago, ignore this update
			if current_time - save_time < 1.0:
				return

		var document: YAMLEditorDocument = documents[normalized_path]

		# Check if the document has unsaved changes
		if not document.is_modified:
			# Document is not modified locally, safe to reload
			var content = file_system.read_file(normalized_path)
			if typeof(content) != TYPE_INT:  # Not an error
				# Update document content
				document.content = content
				document.mark_saved()

				# If this is the current document, update the editor
				if document == current_document:
					# Preserve cursor position and scroll state
					var previous_caret_line := code_editor.get_caret_line()
					var previous_caret_column := code_editor.get_caret_column()
					var previous_scroll_v := code_editor.get_v_scroll_bar().value
					var previous_scroll_h := code_editor.get_h_scroll_bar().value

					code_editor.text = content

					# Restore position if possible
					if previous_caret_line < code_editor.get_line_count():
						code_editor.set_caret_line(previous_caret_line)
						var line_length := code_editor.get_line(previous_caret_line).length()
						if previous_caret_column <= line_length:
							code_editor.set_caret_column(previous_caret_column)

					# Restore scroll position
					code_editor.get_v_scroll_bar().value = previous_scroll_v
					code_editor.get_h_scroll_bar().value = previous_scroll_h

					update_ui()
		else:
			# Document has unsaved changes, show conflict dialog
			if document == current_document:
				var dialog := ConfirmationDialog.new()
				dialog.title = "External Changes Detected"
				dialog.dialog_text = "The file '" + document.get_file_name() + "' has been modified externally. Do you want to reload it and lose your changes?"
				dialog.confirmed.connect(
					func():
						var content := file_system.read_file(path)
						if typeof(content) != TYPE_INT:
							document.content = content
							document.mark_saved()

							if document == current_document:
								code_editor.text = content

							update_ui()
						dialog.queue_free()
				)
				dialog.canceled.connect(func(): dialog.queue_free())
				add_child(dialog)
				dialog.popup_centered()

func _on_ignore_update_timer_timeout() -> void:
	# Clear out any old saved entries
	var current_time := Time.get_unix_time_from_system()
	var keys_to_remove: PackedStringArray = []

	for path in recently_saved_files:
		var save_time = recently_saved_files[path]
		if current_time - save_time >= 1.0:
			keys_to_remove.append(path)

	for path in keys_to_remove:
		recently_saved_files.erase(path)

func _on_file_renamed(old_path: String, new_path: String) -> void:
	var normalized_old_path = _normalize_path(old_path)
	var normalized_new_path = _normalize_path(new_path)

	# If we have this document open, update our references
	if documents.has(normalized_old_path):
		var document: YAMLEditorDocument = documents[normalized_old_path]
		document.path = normalized_new_path

		documents.erase(normalized_old_path)
		documents[normalized_new_path] = document

		update_ui()

func handle_filesystem_change() -> void:
	# Check if any of our open res:// files no longer exist
	var missing_files: PackedStringArray = []

	for path in documents.keys():
		if path.begins_with("res://") and not file_system.file_exists(path):
			missing_files.append(path)

	# Handle missing files
	for old_path in missing_files:
		var document: YAMLEditorDocument = documents[old_path]

		# Try to find a file with the same name but different path in the filesystem
		var filename := old_path.get_file()
		var filesystem_root := EditorInterface.get_resource_filesystem().get_filesystem()
		var new_path := file_system.find_file_in_filesystem(filesystem_root, filename)

		if not new_path.is_empty():
			var normalized_new_path = _normalize_path(new_path)

			# Found potential match - update the document path
			document.path = normalized_new_path
			documents.erase(old_path)
			documents[normalized_new_path] = document

			# If this is the current document, emit signal
			if document == current_document:
				document_changed.emit(document)

			# Update UI
			update_ui()

			# Notify file system
			file_system.notify_file_closed(old_path)
			file_system.notify_file_opened(normalized_new_path)
			file_system.notify_file_renamed(old_path, normalized_new_path)
		else:
			# Keep it open but mark as potentially moved/deleted to avoid losing unsaved changes
			pass

func has_unsaved_changes() -> bool:
	for document in documents.values():
		if document.is_modified:
			return true
	return false

func get_open_documents() -> Array:
	return documents.values()

func get_open_paths() -> Array:
	return documents.keys()

func has_document(path: String) -> bool:
	return documents.has(path)

func get_document(path: String) -> YAMLEditorDocument:
	return documents.get(path, null)

func get_current_document() -> YAMLEditorDocument:
	return current_document

```

# res://addons/yaml/editor/editor_shortcuts.gd
```gd
@tool
class_name YAMLEditorShortcuts

# This helper class registers editor shortcuts for the YAML editor

const SHORTCUTS = [
	{
		"name": "Save",
		"shortcut": KEY_MASK_CTRL | KEY_S,
		"callback": "_on_save_shortcut"
	},
	{
		"name": "Save As",
		"shortcut": KEY_MASK_CTRL | KEY_MASK_SHIFT | KEY_S,
		"callback": "_on_save_as_shortcut"
	},
	{
		"name": "Close File",
		"shortcut": KEY_MASK_CTRL | KEY_W,
		"callback": "_on_close_shortcut"
	},
	{
		"name": "New File",
		"shortcut": KEY_MASK_CTRL | KEY_N,
		"callback": "_on_new_shortcut"
	},
	{
		"name": "Open File",
		"shortcut": KEY_MASK_CTRL | KEY_O,
		"callback": "_on_open_shortcut"
	},
	{
		"name": "Validate YAML",
		"shortcut": KEY_F4,
		"callback": "_on_validate_shortcut"
	},
	{
		"name": "Undo",
		"shortcut": KEY_MASK_CTRL | KEY_Z,
		"callback": "_on_undo_shortcut"
	},
	{
		"name": "Redo",
		"shortcut": KEY_MASK_CTRL | KEY_MASK_SHIFT | KEY_Z,
		"callback": "_on_redo_shortcut"
	},
	{
		"name": "Cut",
		"shortcut": KEY_MASK_CTRL | KEY_X,
		"callback": "_on_cut_shortcut"
	},
	{
		"name": "Copy",
		"shortcut": KEY_MASK_CTRL | KEY_C,
		"callback": "_on_copy_shortcut"
	},
	{
		"name": "Paste",
		"shortcut": KEY_MASK_CTRL | KEY_V,
		"callback": "_on_paste_shortcut"
	},
	{
		"name": "Select All",
		"shortcut": KEY_MASK_CTRL | KEY_A,
		"callback": "_on_select_all_shortcut"
	},
	{
		"name": "Find",
		"shortcut": KEY_MASK_CTRL | KEY_F,
		"callback": "_on_find_shortcut"
	},
	{
		"name": "Find Next",
		"shortcut": KEY_F3,
		"callback": "_on_find_next_shortcut"
	},
	{
		"name": "Find Previous",
		"shortcut": KEY_MASK_SHIFT | KEY_F3,
		"callback": "_on_find_previous_shortcut"
	},
	{
		"name": "Replace",
		"shortcut": KEY_MASK_CTRL | KEY_R,
		"callback": "_on_replace_shortcut"
	},
	# Zoom shortcuts
	{
		"name": "Zoom In",
		"shortcut": KEY_MASK_CTRL | KEY_EQUAL,
		"callback": "_on_zoom_in_shortcut"
	},
	{
		"name": "Zoom In (Numpad)",
		"shortcut": KEY_MASK_CTRL | KEY_KP_ADD,
		"callback": "_on_zoom_in_shortcut"
	},
	{
		"name": "Zoom Out",
		"shortcut": KEY_MASK_CTRL | KEY_MINUS,
		"callback": "_on_zoom_out_shortcut"
	},
	{
		"name": "Zoom Out (Numpad)",
		"shortcut": KEY_MASK_CTRL | KEY_KP_SUBTRACT,
		"callback": "_on_zoom_out_shortcut"
	},
	{
		"name": "Reset Zoom",
		"shortcut": KEY_MASK_CTRL | KEY_0,
		"callback": "_on_zoom_reset_shortcut"
	},
	{
		"name": "Reset Zoom (Numpad)",
		"shortcut": KEY_MASK_CTRL | KEY_KP_0,
		"callback": "_on_zoom_reset_shortcut"
	}
]

static func register_shortcuts(editor_plugin: EditorPlugin, target_object: Object) -> void:
	# Create shortcut inputs for the YAML editor
	var editor_settings := editor_plugin.get_editor_interface().get_editor_settings()
	var shortcuts_settings := editor_settings.get_setting("shortcuts") if editor_settings.has_setting("shortcuts") else {}

	# Create a unique editor name for our shortcuts
	var editor_name := "YAML Editor"

	# Register each shortcut
	for shortcut_data in SHORTCUTS:
		var shortcut_name: String = "yaml_editor/" + shortcut_data.name.to_lower().replace(" ", "_")
		var input_event := InputEventKey.new()
		input_event.keycode = shortcut_data.shortcut

		# Create a shortcut
		var shortcut := Shortcut.new()
		shortcut.events = [input_event]

		# Register the shortcut with Godot's input map
		if not InputMap.has_action(shortcut_name):
			InputMap.add_action(shortcut_name)
			InputMap.action_add_event(shortcut_name, input_event)

	# Connect to the target object's _unhandled_key_input method if it exists
	if !target_object.has_method("_unhandled_key_input"):
		# Create connections for shortcuts if the target doesn't handle key input directly
		for shortcut_data in SHORTCUTS:
			var shortcut_name: String = "yaml_editor/" + shortcut_data.name.to_lower().replace(" ", "_")
			if target_object.has_method(shortcut_data.callback):
				InputMap.action_add_event(shortcut_name, InputEventAction.new())
				# Connect the shortcut action to the target's callback
				var root := editor_plugin.get_tree().root
				root.connect("input_event",
					func(event):
						if event is InputEventKey and event.pressed:
							if event.get_keycode_with_modifiers() == shortcut_data.shortcut:
								target_object.call(shortcut_data.callback)
								print("called a thing")
								root.get_viewport().set_input_as_handled()
				)

static func unregister_shortcuts() -> void:
	# Remove all registered shortcuts
	for shortcut_data in SHORTCUTS:
		var shortcut_name: String = "yaml_editor/" + shortcut_data.name.to_lower().replace(" ", "_")
		if InputMap.has_action(shortcut_name):
			InputMap.erase_action(shortcut_name)

```

# res://addons/yaml/editor/file_list.gd
```gd
@tool
class_name YAMLEditorFileList extends VBoxContainer

signal file_selected(path)
signal file_context_requested(path, position)

# References to UI components
@export var filter_input: LineEdit
@export var file_list: ItemList

# File data
var files: Dictionary = {}  # {path: {name, modified}}
var filtered_files: Array = []
var current_path: String = ""

func _ready() -> void:
	# SessionManager will handle loading of the files
	file_list.clear()

	# Connect internal signals
	if is_instance_valid(file_list):
		file_list.item_selected.connect(_on_item_selected)
		file_list.item_clicked.connect(_on_item_clicked)

	if is_instance_valid(filter_input):
		filter_input.text_changed.connect(_on_filter_text_changed)
		filter_input.right_icon = get_theme_icon("Search", "EditorIcons")

# Public API
func update_files(p_files: Dictionary, p_current_path: String) -> void:
	files = p_files.duplicate()
	current_path = p_current_path
	_update_ui()

func mark_file_modified(path: String, is_modified: bool) -> void:
	if files.has(path):
		files[path].modified = is_modified
		_update_ui()

func get_selected_file_path() -> String:
	if not is_instance_valid(file_list):
		return ""

	var selected_items := file_list.get_selected_items()
	if selected_items.is_empty():
		return ""

	var selected_index := selected_items[0]
	if selected_index >= 0 and selected_index < filtered_files.size():
		return filtered_files[selected_index]

	return ""

# UI update
func _update_ui() -> void:
	if not is_instance_valid(file_list):
		return

	var current_selection := get_selected_file_path()

	file_list.clear()
	filtered_files.clear()

	var filter_text := filter_input.text.to_lower() if is_instance_valid(filter_input) else ""

	var current_index := -1
	var index := 0

	for path: String in files.keys():
		var file_data: Dictionary = files[path]
		var file_name := path.get_file()

		if not filter_text.is_empty() and file_name.to_lower().find(filter_text) == -1:
			continue

		var display_name := file_name
		if file_data.modified:
			display_name += " (*)"

		file_list.add_item(display_name)
		filtered_files.append(path)
		file_list.set_item_tooltip(index, path)

		if path == current_path:
			current_index = index

		if path == current_selection:
			file_list.select(index)

		index += 1

	if current_index >= 0 and (file_list.get_selected_items().is_empty() or current_path != current_selection):
		file_list.select(current_index)

# Signal handlers
func _on_filter_text_changed(_text: String) -> void:
	_update_ui()

func _on_item_selected(index: int) -> void:
	if index >= 0 and index < filtered_files.size():
		file_selected.emit(filtered_files[index])

func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index >= 0 and index < filtered_files.size():
		if mouse_button_index == MOUSE_BUTTON_RIGHT:
			file_list.select(index)
			file_context_requested.emit(filtered_files[index], at_position)

```

# res://addons/yaml/editor/file_system.gd
```gd
@tool
class_name YAMLFileSystem extends Node

signal file_opened(path)
signal file_saved(path)
signal file_updated(path)
signal file_closed(path)
signal file_renamed(old_path, new_path)

# Reference to editor interface for filesystem operations
var editor_interface: EditorInterface

# Singleton pattern
static var _instance: YAMLFileSystem
static func get_singleton() -> YAMLFileSystem:
	if not _instance:
		_instance = YAMLFileSystem.new()
		Engine.get_main_loop().root.call_deferred("add_child", _instance)
	return _instance

func _init() -> void:
	if _instance != null:
		push_error("YAMLFileSystem singleton already exists")
		return
	_instance = self
	# Mark as persistent so it doesn't get destroyed on scene changes
	process_mode = Node.PROCESS_MODE_ALWAYS

# Set the editor interface reference
func set_editor_interface(p_editor_interface: EditorInterface) -> void:
	editor_interface = p_editor_interface

# File operations with signals
func save_file(path: String, content: String) -> Error:
	var was_new_file = not file_exists(path)

	var file := FileAccess.open(path, FileAccess.WRITE)
	if not file:
		return FileAccess.get_open_error()

	file.store_string(content)
	file_saved.emit(path)
	file_updated.emit(path)

	# If this was a new file, notify Godot's filesystem
	if was_new_file and editor_interface:
		call_deferred("_refresh_filesystem", path)

	return OK

func read_file(path: String) -> Variant:
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		return FileAccess.get_open_error()

	return file.get_as_text()

# Check if a file exists
func file_exists(path: String) -> bool:
	return FileAccess.file_exists(path)

# Utility to check if a path is a YAML file
func is_yaml_file(path: String) -> bool:
	return path.get_extension().to_lower() in ["yaml", "yml"]

# For external updates, allow code to manually trigger the signal
func notify_file_updated(path: String) -> void:
	file_updated.emit(path)

# Called when a file is opened in the editor
func notify_file_opened(path: String) -> void:
	file_opened.emit(path)

# Called when a file is closed in the editor
func notify_file_closed(path: String) -> void:
	file_closed.emit(path)

# Called when a file is renamed (by the filesystem or editor)
func notify_file_renamed(old_path: String, new_path: String) -> void:
	file_renamed.emit(old_path, new_path)

# Find a file by name in the filesystem
func find_file_in_filesystem(dir: EditorFileSystemDirectory, filename: String) -> String:
	# Check files in current directory
	for i in range(dir.get_file_count()):
		var file_path := dir.get_file_path(i)
		if file_path.get_file() == filename:
			return file_path

	# Recursively check subdirectories
	for i in range(dir.get_subdir_count()):
		var subdir := dir.get_subdir(i)
		var result := find_file_in_filesystem(subdir, filename)
		if not result.is_empty():
			return result

	return ""

func _refresh_filesystem(path: String) -> void:
	if editor_interface:
		editor_interface.get_resource_filesystem().update_file(path)

```

# res://addons/yaml/editor/find_replace_bar.gd
```gd
@tool
class_name YAMLEditorFindReplaceBar extends Control

signal replace_performed
signal replace_all_performed

@export_category("Find Panel Components")
@export var find_input: LineEdit
@export var matches_label: Label
@export var previous_button: Button
@export var next_button: Button
@export var match_case_checkbox: CheckBox
@export var whole_words_checkbox: CheckBox
@export var find_button_container: HBoxContainer
@export var find_options_container: HBoxContainer

@export_category("Replace Panel Components")
@export var replace_input: LineEdit
@export var replace_button: Button
@export var replace_all_button: Button
@export var selection_only_checkbox: CheckBox
@export var replace_button_container: HBoxContainer
@export var replace_options_container: HBoxContainer

@export_category("Visibility Toggle")
@export var hide_button: Button

@export_category("Node References")
@export var editor: YAMLCodeEditor
@export var vbox_container: VBoxContainer  # Container holding both panels
@export var find_panel: Control  # First row (find)
@export var replace_panel: Control  # Second row (replace)

# Matching state
var matches: Array[Vector2i] = []  # Store line/column pairs of matches
var current_match_index: int = -1  # Index of current selection in matches array
var search_regex: RegEx = RegEx.new()

func _ready() -> void:
	# Setup UI
	previous_button.icon = get_theme_icon("MoveUp", "EditorIcons")
	next_button.icon = get_theme_icon("MoveDown", "EditorIcons")
	hide_button.icon = get_theme_icon("Close", "EditorIcons")

	# Connect signals
	find_input.text_changed.connect(_on_find_input_changed)
	find_input.text_submitted.connect(_on_find_input_submitted)
	previous_button.pressed.connect(_on_previous_button_pressed)
	next_button.pressed.connect(_on_next_button_pressed)
	match_case_checkbox.toggled.connect(_on_option_changed)
	whole_words_checkbox.toggled.connect(_on_option_changed)
	hide_button.pressed.connect(_on_hide_button_pressed)

	replace_button.pressed.connect(_on_replace_button_pressed)
	replace_all_button.pressed.connect(_on_replace_all_button_pressed)
	selection_only_checkbox.toggled.connect(_on_option_changed)

	# Disable buttons initially
	previous_button.disabled = true
	next_button.disabled = true
	replace_button.disabled = true
	replace_all_button.disabled = true

	# Hide by default
	visible = false

	# Make sure editor preserves selection when focus changes
	if editor:
		editor.set_deselect_on_focus_loss_enabled(false)

var find_panel_visible: bool:
	get(): return find_input.visible
	set(value):
		find_input.visible = value
		find_button_container.visible = value
		find_options_container.visible = value

var replace_panel_visible: bool:
	get(): return replace_input.visible
	set(value):
		replace_input.visible = value
		replace_button_container.visible = value
		replace_options_container.visible = value

# Public methods
func show_find_panel() -> void:
	if not is_instance_valid(editor):
		return

	visible = true
	find_panel_visible = true

	# If there's a selection, use it as search text
	if editor.has_selection():
		find_input.text = editor.get_selected_text()

	# Run initial search and update UI
	trigger_search()

	# Focus the search input
	find_input.grab_focus()
	find_input.select_all()

func show_replace_panel() -> void:
	if not is_instance_valid(editor):
		return

	visible = true
	find_panel_visible = true
	replace_panel_visible = true

	# If there's a selection, use it as search text
	if editor.has_selection():
		find_input.text = editor.get_selected_text()

	# Run initial search and update UI
	trigger_search()

	# Focus the search input
	find_input.grab_focus()
	find_input.select_all()

func hide_panel() -> void:
	find_panel_visible = false
	replace_panel_visible = false
	visible = false

	# Clear search when hiding
	if is_instance_valid(editor):
		editor.set_search_text("")
		editor.set_search_flags(0)
		editor.queue_redraw()

# Core functionality
func trigger_search() -> void:
	if not is_instance_valid(editor):
		return

	# Store old cursor position to find closest match
	var old_cursor_line = editor.get_caret_line()
	var old_cursor_column = editor.get_caret_column()

	# Update TextEdit search settings for highlighting
	var search_text = find_input.text
	editor.set_search_text(search_text if visible else "")

	var flags = 0
	if match_case_checkbox.button_pressed:
		flags |= TextEdit.SEARCH_MATCH_CASE
	if whole_words_checkbox.button_pressed:
		flags |= TextEdit.SEARCH_WHOLE_WORDS
	editor.set_search_flags(flags)

	# Find all matches
	matches.clear()
	current_match_index = -1

	if search_text.is_empty():
		_update_match_label()
		_update_button_states()
		return

	# Create regex pattern
	_create_search_regex(search_text, match_case_checkbox.button_pressed, whole_words_checkbox.button_pressed)

	# Find all matches using regex
	for line_num in range(editor.get_line_count()):
		var line_text = editor.get_line(line_num)
		var search_results = search_regex.search_all(line_text)

		for result in search_results:
			matches.append(Vector2i(line_num, result.get_start()))

	# Determine which match to select
	if matches.is_empty():
		current_match_index = -1
	else:
		# Find closest match to current cursor position
		var best_distance = -1
		var best_match = 0

		for i in range(matches.size()):
			var pos = matches[i]

			# Check if this match is after cursor
			if pos.x > old_cursor_line or (pos.x == old_cursor_line and pos.y >= old_cursor_column):
				var distance = (pos.x - old_cursor_line) * 1000 + (pos.y - old_cursor_column)
				if best_distance < 0 or distance < best_distance:
					best_distance = distance
					best_match = i

		# If no match after cursor, wrap to first match
		if best_distance < 0:
			current_match_index = 0
		else:
			current_match_index = best_match

	# Always ensure we have a selected match if there are any matches
	if matches.size() > 0 and current_match_index == -1:
		current_match_index = 0

	# Select the current match if appropriate
	if current_match_index >= 0 and not (selection_only_checkbox.button_pressed and replace_panel.visible):
		_select_current_match()

	# Update UI
	_update_match_label()
	_update_button_states()

func find_next() -> void:
	if matches.is_empty() or not is_instance_valid(editor):
		return

	# Don't navigate if selection only is active
	if replace_panel.visible and selection_only_checkbox.button_pressed:
		return

	# Move to next match
	current_match_index = (current_match_index + 1) % matches.size()
	_select_current_match()
	_update_match_label()

func find_previous() -> void:
	if matches.is_empty() or not is_instance_valid(editor):
		return

	# Don't navigate if selection only is active
	if replace_panel.visible and selection_only_checkbox.button_pressed:
		return

	# Move to previous match
	current_match_index = (current_match_index - 1 + matches.size()) % matches.size()
	_select_current_match()
	_update_match_label()

# Helper methods
func _create_search_regex(search_text: String, case_sensitive: bool, whole_words: bool) -> void:
	# Escape special regex characters
	var pattern = ""
	for i in range(search_text.length()):
		var c = search_text[i]
		# Escape regex special characters
		if c in "\\.*+?^$[](){}|":
			pattern += "\\" + c
		else:
			pattern += c

	# Add word boundary anchors if needed
	if whole_words:
		pattern = "\\b%s\\b" % pattern

	if not case_sensitive:
		pattern = "(?i)%s" % pattern

	search_regex = RegEx.new()
	search_regex.compile(pattern)

func _select_current_match() -> void:
	if current_match_index < 0 or current_match_index >= matches.size():
		return

	var match_pos = matches[current_match_index]
	var search_length = find_input.text.length()

	# Select the text
	editor.set_caret_line(match_pos.x)
	editor.set_caret_column(match_pos.y)
	editor.select(match_pos.x, match_pos.y, match_pos.x, match_pos.y + search_length)

	# Center the view
	editor.center_viewport_to_caret()

func _update_match_label() -> void:
	if not visible:
		return

	var count = matches.size()

	matches_label.visible = true

	if count > 0:
		matches_label.modulate = Color.WHITE
		matches_label.text = "%d of %d matches" % [current_match_index + 1, count]
	elif not find_input.text.is_empty():
		matches_label.modulate = EditorInterface.get_editor_settings().get_setting("text_editor/theme/highlighting/brace_mismatch_color")
		matches_label.text = "No matches"
	else:
		matches_label.visible = false
		matches_label.text = ""

func _update_button_states() -> void:
	var has_matches = matches.size() > 0
	var selection_only_active = replace_panel.visible and selection_only_checkbox.button_pressed

	# Disable navigation buttons if selection only is checked
	previous_button.disabled = not has_matches or selection_only_active
	next_button.disabled = not has_matches or selection_only_active

	# Enable/disable replace buttons
	if selection_only_active and editor.has_selection():
		var has_matches_in_selection = get_matches_in_selection().size() > 0
		replace_button.disabled = not has_matches_in_selection
		replace_all_button.disabled = not has_matches_in_selection
	else:
		replace_button.disabled = not has_matches
		replace_all_button.disabled = not has_matches

# Get matches within the current selection when Selection Only is active
func get_matches_in_selection() -> Array[Vector2i]:
	var result: Array[Vector2i] = []

	if not editor.has_selection() or not selection_only_checkbox.button_pressed:
		return matches.duplicate()

	var search_text = find_input.text
	var selection_from_line = editor.get_selection_from_line()
	var selection_from_column = editor.get_selection_from_column()
	var selection_to_line = editor.get_selection_to_line()
	var selection_to_column = editor.get_selection_to_column()

	# Convert selection to absolute character index
	var selection_start_index = _get_absolute_index(selection_from_line, selection_from_column)
	var selection_end_index = _get_absolute_index(selection_to_line, selection_to_column)

	for match_pos in matches:
		# Convert match position to absolute character index
		var match_start_index = _get_absolute_index(match_pos.x, match_pos.y)
		var match_end_index = match_start_index + search_text.length()

		# Check if match is fully contained in selection
		if match_start_index >= selection_start_index and match_end_index <= selection_end_index:
			result.append(match_pos)

	return result

# Get the next match after the cursor that's inside the selection
func get_next_match_in_selection() -> Vector2i:
	if not editor.has_selection() or not selection_only_checkbox.button_pressed:
		return Vector2i(-1, -1)

	var matches_in_selection = get_matches_in_selection()
	if matches_in_selection.is_empty():
		return Vector2i(-1, -1)

	var cursor_line = editor.get_caret_line()
	var cursor_column = editor.get_caret_column()

	# Sort matches by position
	matches_in_selection.sort_custom(func(a, b):
		if a.x == b.x:
			return a.y < b.y
		return a.x < b.x
	)

	# Find the first match after cursor
	for match_pos in matches_in_selection:
		if match_pos.x > cursor_line or (match_pos.x == cursor_line and match_pos.y >= cursor_column):
			return match_pos

	# If no match after cursor, wrap to first match
	return matches_in_selection[0]

func _get_absolute_index(line: int, column: int) -> int:
	# Calculate absolute character index from line and column
	var index = 0
	for i in range(line):
		index += editor.get_line(i).length() + 1  # +1 for newline

	index += column
	return index

# Signal handlers
func _on_find_input_changed(_text: String) -> void:
	trigger_search()

func _on_find_input_submitted(_text: String) -> void:
	find_next()

func _on_option_changed(_toggled: bool) -> void:
	trigger_search()

func _on_previous_button_pressed() -> void:
	find_previous()

func _on_next_button_pressed() -> void:
	find_next()

func _on_hide_button_pressed() -> void:
	hide_panel()

func _on_replace_button_pressed() -> void:
	if not is_instance_valid(editor):
		return

	var search_text = find_input.text
	if search_text.is_empty() or matches.is_empty():
		return

	var replace_text = replace_input.text

	# Different behavior based on Selection Only mode
	if selection_only_checkbox.button_pressed and editor.has_selection():
		# Get next match in selection
		var match_pos = get_next_match_in_selection()
		if match_pos.x < 0:  # No match in selection
			return

		# Replace the text
		var line_text = editor.get_line(match_pos.x)
		var new_line_text = line_text.substr(0, match_pos.y) + replace_text + line_text.substr(match_pos.y + search_text.length())
		editor.set_line(match_pos.x, new_line_text)

		# Move cursor to the end of the replaced text for next find
		var cursor_line = match_pos.x
		var cursor_column = match_pos.y + replace_text.length()

		# Update the document's content
		editor.text_changed.emit()

		# Refresh search
		trigger_search()

		# Restore cursor position for next replacement
		editor.set_caret_line(cursor_line)
		editor.set_caret_column(cursor_column)
	else:
		# Normal replace mode - use the current highlighted match
		if current_match_index < 0 or current_match_index >= matches.size():
			return

		# Get current match
		var match_pos = matches[current_match_index]

		# Replace the text
		var line_text = editor.get_line(match_pos.x)
		var new_line_text = line_text.substr(0, match_pos.y) + replace_text + line_text.substr(match_pos.y + search_text.length())
		editor.set_line(match_pos.x, new_line_text)

		# Update the document's content
		editor.text_changed.emit()

		# Refresh search
		trigger_search()

	replace_performed.emit()

func _on_replace_all_button_pressed() -> void:
	if not is_instance_valid(editor):
		return

	var search_text = find_input.text
	if search_text.is_empty() or matches.is_empty():
		return

	var replace_text = replace_input.text

	# Determine which matches to replace
	var matches_to_replace: Array[Vector2i]

	if selection_only_checkbox.button_pressed and editor.has_selection():
		matches_to_replace = get_matches_in_selection()
	else:
		matches_to_replace = matches.duplicate()

	if matches_to_replace.is_empty():
		return

	# Sort matches in reverse order (to not affect positions of earlier matches)
	matches_to_replace.sort_custom(func(a, b):
		if a.x == b.x:
			return a.y > b.y
		return a.x > b.x
	)

	# Process replacements
	var lines = editor.text.split("\n", false)
	var replacements_count = 0

	for match_pos in matches_to_replace:
		# Replace text in the line
		var line_text = lines[match_pos.x]
		lines[match_pos.x] = line_text.substr(0, match_pos.y) + replace_text + line_text.substr(match_pos.y + search_text.length())
		replacements_count += 1

	# Only update if we made changes
	if replacements_count > 0:
		# Set the new text
		editor.text = "\n".join(lines)

		# Update the document's content
		editor.text_changed.emit()

		# Refresh search
		trigger_search()

	replace_all_performed.emit()

```

# res://addons/yaml/editor/menu_bar.gd
```gd
@tool
class_name YAMLEditorMenuBar extends MenuBar

signal new_file
signal open_file
signal save_requested
signal save_as_requested
signal close_requested

signal undo_requested
signal redo_requested

signal cut_requested
signal copy_requested
signal paste_requested
signal select_all_requested

signal find_requested
signal find_next_requested
signal find_previous_requested
signal replace_requested

@export var file_menu: PopupMenu
@export var edit_menu: PopupMenu
@export var search_menu: PopupMenu

func _ready() -> void:
	# Wait for UI to be ready
	await get_tree().process_frame

	# Set up the menu bar
	_setup_menus()

func _setup_menus() -> void:
	# File menu
	file_menu.clear()
	file_menu.add_item("New", 0, KEY_MASK_CTRL | KEY_N)
	file_menu.add_item("Open...", 1, KEY_MASK_CTRL | KEY_O)
	file_menu.add_separator()
	file_menu.add_item("Save", 2, KEY_MASK_CTRL | KEY_S)
	file_menu.add_item("Save As...", 3, KEY_MASK_CTRL | KEY_MASK_SHIFT | KEY_S)
	file_menu.add_separator()
	file_menu.add_item("Close", 4, KEY_MASK_CTRL | KEY_W)

	# Edit menu
	edit_menu.clear()
	edit_menu.add_item("Undo", 0, KEY_MASK_CTRL | KEY_Z)
	edit_menu.add_item("Redo", 1, KEY_MASK_CTRL | KEY_MASK_SHIFT | KEY_Z)
	edit_menu.add_separator()
	edit_menu.add_item("Cut", 2, KEY_MASK_CTRL | KEY_X)
	edit_menu.add_item("Copy", 3, KEY_MASK_CTRL | KEY_C)
	edit_menu.add_item("Paste", 4, KEY_MASK_CTRL | KEY_V)
	edit_menu.add_separator()
	edit_menu.add_item("Select All", 5, KEY_MASK_CTRL | KEY_A)

	# Search menu
	search_menu.clear()
	search_menu.add_item("Find...", 0, KEY_MASK_CTRL | KEY_F)
	search_menu.add_item("Find Next", 1, KEY_F3)
	search_menu.add_item("Find Previous", 2, KEY_MASK_SHIFT | KEY_F3)
	search_menu.add_separator()
	search_menu.add_item("Replace...", 3, KEY_MASK_CTRL | KEY_R)

	# Connect signals
	file_menu.id_pressed.connect(_on_file_menu_id_pressed)
	edit_menu.id_pressed.connect(_on_edit_menu_id_pressed)
	search_menu.id_pressed.connect(_on_search_menu_id_pressed)

func _on_file_menu_id_pressed(id: int) -> void:
	match id:
		0: new_file.emit()
		1: open_file.emit()
		2: save_requested.emit()
		3: save_as_requested.emit()
		4: close_requested.emit()

func _on_edit_menu_id_pressed(id: int) -> void:
	match id:
		0: undo_requested.emit()
		1: redo_requested.emit()
		2: cut_requested.emit()
		3: copy_requested.emit()
		4: paste_requested.emit()
		5: select_all_requested.emit()

func _on_search_menu_id_pressed(id: int) -> void:
	match id:
		0: find_requested.emit()
		1: find_next_requested.emit()
		2: find_previous_requested.emit()
		3: replace_requested.emit()

```

# res://addons/yaml/editor/session_manager.gd
```gd
@tool
class_name YAMLEditorSessionManager extends Node

const CONFIG_PATH := "res://.godot/yaml_editor_session.cfg"
const CONFIG_SECTION := "yaml_editor"
const CONFIG_KEY_OPEN_FILES := "open_files"
const CONFIG_KEY_SPLIT_OFFSET := "split_offset"
const CONFIG_KEY_CURRENT_FILE := "current_file"

var file_manager: YAMLEditorDocumentManager
var file_system: YAMLFileSystem
var config: ConfigFile
var autosave_timer: Timer
var resizable_container: HSplitContainer

func _ready() -> void:
	file_system = YAMLFileSystem.get_singleton()

	config = ConfigFile.new()

	# Setup autosave timer
	autosave_timer = Timer.new()
	add_child(autosave_timer)
	autosave_timer.wait_time = 10.0  # Save session every 10 seconds
	autosave_timer.one_shot = false
	autosave_timer.autostart = true
	autosave_timer.timeout.connect(_on_autosave_timer_timeout)

func setup(p_file_manager: YAMLEditorDocumentManager, p_resizable_container: HSplitContainer) -> void:
	file_manager = p_file_manager
	resizable_container = p_resizable_container

	# Connect to signals
	file_manager.document_changed.connect(_on_session_changed)
	file_manager.document_created.connect(_on_session_changed)
	file_manager.document_closed.connect(_on_session_changed)
	resizable_container.dragged.connect(_on_split_dragged)

func _on_split_dragged(_offset: int) -> void:
	# The split position has changed, save the session
	_on_session_changed()

func save_session() -> void:
	# Don't save anything if we have no files
	if not is_instance_valid(file_manager):
		return

	var documents: Array = file_manager.get_open_documents()

	# Create array of persistent file paths (skip untitled files)
	var persistent_files: PackedStringArray = []
	for document in documents:
		if not document.is_untitled():
			persistent_files.append(document.path)

	# Get current file path
	var current_path := ""
	var current_document := file_manager.get_current_document()
	if current_document and not current_document.is_untitled():
		current_path = current_document.path

	# Save to config file
	config.set_value(CONFIG_SECTION, CONFIG_KEY_OPEN_FILES, persistent_files)
	config.set_value(CONFIG_SECTION, CONFIG_KEY_CURRENT_FILE, current_path)

	# Save the split offset
	if is_instance_valid(resizable_container):
		config.set_value(CONFIG_SECTION, CONFIG_KEY_SPLIT_OFFSET, resizable_container.split_offset)

	var error := config.save(CONFIG_PATH)
	if error != OK:
		push_error("Failed to save YAML editor session: %s" % error_string(error))

func load_session() -> void:
	var error := config.load(CONFIG_PATH)
	if error != OK:
		# No saved session or error loading it
		if error != ERR_FILE_NOT_FOUND:
			push_error("Failed to load YAML editor session: ", error_string(error))
		return

	# Get saved file paths
	var file_paths: PackedStringArray = config.get_value(CONFIG_SECTION, CONFIG_KEY_OPEN_FILES, [])

	# Open each file
	for path in file_paths:
		if file_system.file_exists(path):
			file_manager.open_file(path)

	# Set current file
	var last_current: String = config.get_value(CONFIG_SECTION, CONFIG_KEY_CURRENT_FILE, "")
	if not last_current.is_empty() and file_manager.has_document(last_current):
		var document := file_manager.get_document(last_current)
		file_manager.set_current_document(document)

	# Restore split offset (deferred to ensure UI is ready)
	call_deferred("_restore_split_offset")

func _restore_split_offset() -> void:
	if is_instance_valid(resizable_container):
		var saved_offset: int = config.get_value(CONFIG_SECTION, CONFIG_KEY_SPLIT_OFFSET, resizable_container.split_offset)
		resizable_container.split_offset = saved_offset

func _on_session_changed(_document = null) -> void:
	# Set a short timer to prevent saving too frequently during batch operations
	autosave_timer.start()

func _on_autosave_timer_timeout() -> void:
	save_session()

```

# res://addons/yaml/editor/status_bar.gd
```gd
@tool
class_name YAMLEditorStatusBar extends HBoxContainer

@export var editor: YAMLCodeEditor
@export var status_label: Label
@export var zoom_button: Button
@export var line_column_label: Label

var zoom_popup_menu: PopupMenu

func _ready() -> void:
	# Zoom popup menu
	zoom_popup_menu = PopupMenu.new()
	add_child(zoom_popup_menu)
	zoom_popup_menu.add_item("25 %", 0)
	zoom_popup_menu.add_item("50 %", 1)
	zoom_popup_menu.add_item("75 %", 2)
	zoom_popup_menu.add_item("100 %", 3)
	zoom_popup_menu.add_item("150 %", 4)
	zoom_popup_menu.add_item("200 %", 5)
	zoom_popup_menu.add_item("300 %", 6)
	zoom_popup_menu.id_pressed.connect(_on_zoom_popup_menu_id_pressed)
	zoom_button.pressed.connect(
		func():
			var global_rect := Rect2(get_global_mouse_position(), Vector2.ZERO)
			zoom_popup_menu.popup_on_parent(global_rect)
	)

	status_label.set("theme_override_constants/use_pixel_snap", true)

func _on_zoom_popup_menu_id_pressed(idx: int) -> void:
	match idx:
		0: editor.set_zoom(0.25)
		1: editor.set_zoom(0.5)
		2: editor.set_zoom(0.75)
		3: editor.set_zoom(1.0)
		4: editor.set_zoom(1.5)
		5: editor.set_zoom(2.0)
		6: editor.set_zoom(3.0)
	zoom_popup_menu.hide()

func set_status(text: String, color := Color.WHITE) -> void:
	status_label.text = text
	status_label.modulate = color

func set_line_column(line_column: Array[int]) -> void:
	var line := line_column[0]
	var col := line_column[1]
	line_column_label.text = "%d : %d" % [line, col]

func set_zoom_level(level: float) -> void:
	zoom_button.text = str(int(level * 100)) + " %"

func set_validation_result(result: YAMLResult) -> void:
	if !result.has_error():
		return set_status("")

	var error := result.get_error_message()
	var line := result.get_error_line()
	var col := result.get_error_column()
	var error_text := "Error at (%d, %d): %s" % [line, col, error] if line >= 0 else "Error: %s" % error

	var error_color: Color = EditorInterface.get_editor_settings().get_setting("text_editor/theme/highlighting/brace_mismatch_color")
	set_status(error_text, error_color)

```

# res://addons/yaml/editor/syntax_highlighting/editor_syntax_highlighter.gd
```gd
@tool
class_name YAMLEditorSyntaxHighlighter extends EditorSyntaxHighlighter

var cache: Dictionary = {}
var syntax_parser := YAMLSyntaxParser.new()
var color_provider := YAMLSyntaxParser.ColorProvider.new()

func clear_highlighting_cache() -> void:
	cache.clear()

func _get_line_syntax_highlighting(line: int) -> Dictionary:
	var text: String = get_text_edit().get_line(line)
	if text in cache:
		return cache[text]

	color_provider.update_theme()
	cache[text] = _highlight_line(text)
	return cache[text]

func _highlight_line(text: String) -> Dictionary:
	return syntax_parser.highlight_line(text, color_provider)

```

# res://addons/yaml/editor/syntax_highlighting/syntax_highlighter.gd
```gd
class_name YAMLSyntaxHighlighter extends SyntaxHighlighter

var cache: Dictionary = {}
var syntax_parser := YAMLSyntaxParser.new()
var color_provider := YAMLSyntaxParser.ColorProvider.new()

func clear_highlighting_cache() -> void:
	cache.clear()

func _get_line_syntax_highlighting(line: int) -> Dictionary:
	var text: String = get_text_edit().get_line(line)
	if text in cache:
		return cache[text]

	color_provider.update_theme()
	cache[text] = _highlight_line(text)
	return cache[text]

func _highlight_line(text: String) -> Dictionary:
	return syntax_parser.highlight_line(text, color_provider)

```

# res://addons/yaml/editor/syntax_highlighting/yaml_syntax_parser.gd
```gd
@tool
class_name YAMLSyntaxParser extends RefCounted

## Token types
enum TokenType {
	TEXT,               # For keys only
	COMMENT,            # Comments
	SYMBOL,             # Structural elements like :, -, >, |, &, *, [, ], {, }
	STRING,             # String values (default for unmatched values)
	NUMBER,             # Numeric values
	KEYWORD,            # Booleans, null, merge keys, tags
	DOCUMENT_SEPARATOR, # New document separator
}

var re_patterns := {
	"merge_key": RegEx.create_from_string("^\\s*<<:\\s*\\*[^\\s]+"),
	"multiline_indicator": RegEx.create_from_string("(>|\\|-?)\\s*$"),
	"array_item": RegEx.create_from_string("^(\\s*-(?:\\s*-)*\\s*)(.*)$"),
	"key_value": RegEx.create_from_string("^\\s*([^:]+):(.*)$"),

	# Scalar patterns
	"quoted_string": RegEx.create_from_string("^(['\"])(?:\\\\.|[^\\\\])*\\1$"),
	"number": RegEx.create_from_string("^(?:0[xX][0-9a-fA-F]+|0[oO][0-7]+|0[bB][0-1]+|[-+]?(?:\\d+\\.?\\d*|\\.\\d+)(?:[eE][-+]?\\d+)?)$"),
	"boolean": RegEx.create_from_string("^(true|false)$"),
	"nullish": RegEx.create_from_string("^(null|~)$"),
	"special": RegEx.create_from_string("^(\\.inf|\\.nan)$"),

	# YAML functionality
	"anchor": RegEx.create_from_string("^\\s*&([^\\s]+)"),
	"alias": RegEx.create_from_string("^\\s*\\*([^\\s]+)"),
	"tag": RegEx.create_from_string("!(?:![\\w\\-\\.]+|[^\\s\\[\\]{}'\"`]+)"),
	"top_level_tag": RegEx.create_from_string("^\\s*(!(?:![\\w\\-\\.]+|[^\\s\\[\\]{}'\"`]+))\\s*(.*)$"),
	"document_separator": RegEx.create_from_string("^---$")
}

class ParserState:
	var in_string: bool = false
	var string_char: String = ""
	var stack: Array = []  # For nested flow collections
	var token_start: int = -1
	var colors: Dictionary = {}

	func push(char: String) -> void:
		stack.push_back(char)

	func pop() -> String:
		return stack.pop_back() if not stack.is_empty() else ""

	func peek() -> String:
		return stack.back() if not stack.is_empty() else ""

## Provides colors to the syntax highlighter
class ColorProvider:
	# Default theme colors
	var theme: Dictionary = {
		"text": Color(0.8025, 0.81, 0.8225, 1),
		"comment": Color(0.8025, 0.81, 0.8225, 0.5),
		"symbol": Color(0.67, 0.79, 1, 1),
		"string": Color(1, 0.93, 0.63, 1),
		"number": Color(0.63, 1, 0.88, 1),
		"keyword": Color(1, 0.44, 0.52, 1),
		"document_separator": Color(0.8025, 0.81, 0.8225, 0.5)
	}

	func _init():
		update_theme()

	## Updates the theme colors from Godot Editor settings
	func update_theme() -> void:
		# Only inside the Godot Editor
		if !Engine.is_editor_hint():
			return

		# Read theme from editor settings
		var settings = EditorInterface.get_editor_settings()
		theme = {
			"text": settings.get_setting("text_editor/theme/highlighting/text_color"),
			"comment": settings.get_setting("text_editor/theme/highlighting/comment_color"),
			"symbol": settings.get_setting("text_editor/theme/highlighting/symbol_color"),
			"string": settings.get_setting("text_editor/theme/highlighting/string_color"),
			"number": settings.get_setting("text_editor/theme/highlighting/number_color"),
			"keyword": settings.get_setting("text_editor/theme/highlighting/keyword_color"),
			"document_separator": settings.get_setting("text_editor/theme/highlighting/comment_color"),
		}

	## Get color for tokens
	func get_color_for_type(type: TokenType) -> Color:
		match type:
			YAMLSyntaxParser.TokenType.TEXT: return theme.text
			YAMLSyntaxParser.TokenType.COMMENT: return theme.comment
			YAMLSyntaxParser.TokenType.SYMBOL: return theme.symbol
			YAMLSyntaxParser.TokenType.STRING: return theme.string
			YAMLSyntaxParser.TokenType.NUMBER: return theme.number
			YAMLSyntaxParser.TokenType.KEYWORD: return theme.keyword
			YAMLSyntaxParser.TokenType.DOCUMENT_SEPARATOR: return theme.document_separator
			_: return theme.string # Default fallback is string color

## Highlight a line of YAML
func highlight_line(text: String, color_provider: ColorProvider = ColorProvider.new()) -> Dictionary:
	var comment_pos := _find_comment_start(text)
	var content := text if comment_pos == -1 else text.substr(0, comment_pos).rstrip(" \t")
	var colors := {}

	if content.strip_edges():
		colors = _highlight_line_content(content, color_provider)

	if comment_pos != -1:
		colors[comment_pos] = {"color": color_provider.get_color_for_type(TokenType.COMMENT)}

	return _sort_colors(colors)

# Find the beginning position of a comment
func _find_comment_start(text: String) -> int:
	var in_string := false
	var string_char := ""

	for i in range(text.length()):
		var char := text[i]

		if not in_string:
			if char in ['"', "'"] and (i == 0 or text[i - 1] != '\\'):
				in_string = true
				string_char = char
			elif char == '#' and (i == 0 or text[i - 1] == ' ' or text[i - 1] == '\t'):
				return i
		else:
			if char == string_char and (i == 0 or text[i - 1] != '\\'):
				in_string = false
				string_char = ""

	return -1

# Highlight line content
func _highlight_line_content(text: String, color_provider: ColorProvider) -> Dictionary:
	# Handle document separator
	var separator_match: RegExMatch = re_patterns.document_separator.search(text)
	if separator_match:
		return {0: {"color": color_provider.get_color_for_type(TokenType.DOCUMENT_SEPARATOR)}}

	# Handle merge keys
	var merge_match: RegExMatch = re_patterns.merge_key.search(text)
	if merge_match:
		return {
			merge_match.get_start(0): {"color": color_provider.get_color_for_type(TokenType.KEYWORD)}
		}

	# Check for top-level tags
	var tag_match: RegExMatch = re_patterns.top_level_tag.search(text)
	if tag_match:
		var colors := {}
		# Color just the tag part as keyword (red)
		_add_color(color_provider, colors, tag_match.get_start(1), tag_match.get_end(1), TokenType.KEYWORD)

		# Process any remaining content after the tag
		var remaining = tag_match.get_string(2).strip_edges()
		if remaining:
			var remaining_start = text.find(remaining, tag_match.get_end(1))
			if remaining_start != -1:
				if remaining.begins_with("{") or remaining.begins_with("["):
					colors.merge(_parse_flow_style(color_provider, remaining, remaining_start))
				else:
					_add_scalar_color(color_provider, colors, remaining, remaining_start)
		return colors

	# Handle array items
	var array_match: RegExMatch = re_patterns.array_item.search(text)
	if array_match:
		var colors := {}

		# Color the entire dash section as symbols
		_add_color(color_provider, colors, array_match.get_start(1), array_match.get_end(1), TokenType.SYMBOL)

		# Process the content after the dashes
		var content: String = array_match.get_string(2).strip_edges()
		if content:
			var content_start: int = array_match.get_start(2)
			if content.begins_with("[") or content.begins_with("{"):
				colors.merge(_parse_flow_style(color_provider, content, content_start))
			else:
				_add_scalar_color(color_provider, colors, content, content_start)
		return colors

	# Handle regular key-value pairs
	var key_value_match: RegExMatch = re_patterns.key_value.search(text)
	if key_value_match:
		return _parse_key_value(color_provider, text, key_value_match)

	# Handle flow-style collections at the root level
	if "[" in text or "{" in text:
		return _parse_flow_style(color_provider, text, 0)

	# Handle multi-line string indicators
	var multiline_match: RegExMatch = re_patterns.multiline_indicator.search(text)
	if multiline_match:
		var colors := {}
		# Color the indicator (> or |) as symbol
		_add_color(color_provider, colors, multiline_match.get_start(1), multiline_match.get_end(1), TokenType.SYMBOL)
		return colors

	# Default case: treat as string content (for multi-line string content)
	if text.strip_edges():
		return {0: {"color": color_provider.get_color_for_type(TokenType.STRING)}}

	return {}

# Parse flow collections
func _parse_flow_style(color_provider: ColorProvider, text: String, offset: int) -> Dictionary:
	var state := ParserState.new()
	var pos := 0

	while pos < text.length():
		var char := text[pos]

		# Handle string literals
		if char in ['"', "'"] and (pos == 0 or text[pos - 1] != '\\'):
			if not state.in_string:
				state.in_string = true
				state.string_char = char
				state.token_start = pos
			elif char == state.string_char:
				state.in_string = false
				_add_color(color_provider, state.colors, offset + state.token_start, offset + pos + 1, TokenType.STRING)
				state.token_start = -1

		# Handle flow collection brackets when not in string
		elif not state.in_string:
			if char in ['[', '{']:
				state.push(char)
				_add_color(color_provider, state.colors, offset + pos, offset + pos + 1, TokenType.SYMBOL)
				state.token_start = pos + 1

			elif char in [']', '}']:
				var matching := '[' if char == ']' else '{'
				if state.peek() == matching:
					state.pop()
					if state.token_start != -1:
						var token := text.substr(state.token_start, pos - state.token_start).strip_edges()
						if token:
							_add_scalar_color(color_provider, state.colors, token, offset + state.token_start)
					_add_color(color_provider, state.colors, offset + pos, offset + pos + 1, TokenType.SYMBOL)
					state.token_start = -1

			elif char in [':', ',']:
				if state.token_start != -1:
					var token := text.substr(state.token_start, pos - state.token_start).strip_edges()
					if token:
						if char == ':':
							# All map keys should be text colored, regardless of content
							_add_color(color_provider, state.colors, offset + state.token_start, offset + pos, TokenType.TEXT)
						else:
							_add_scalar_color(color_provider, state.colors, token, offset + state.token_start)
				_add_color(color_provider, state.colors, offset + pos, offset + pos + 1, TokenType.SYMBOL)
				state.token_start = pos + 1

			elif char != ' ' and state.token_start == -1:
				state.token_start = pos

		pos += 1

	# Handle any remaining token
	if state.token_start != -1 and state.token_start < pos:
		var token := text.substr(state.token_start, pos - state.token_start).strip_edges()
		if token:
			# Check if this is a key in a map context
			if not state.stack.is_empty() and state.stack.back() == '{' and ':' in text.substr(pos):
				_add_color(color_provider, state.colors, offset + state.token_start, offset + pos, TokenType.TEXT)
			else:
				_add_scalar_color(color_provider, state.colors, token, offset + state.token_start)

	return state.colors

# Parse dictionary key and value
func _parse_key_value(color_provider: ColorProvider, text: String, match: RegExMatch) -> Dictionary:
	var colors := {}

	# Color the key
	_add_color(color_provider, colors, match.get_start(1), match.get_end(1), TokenType.TEXT)

	# Color the colon
	_add_color(color_provider,colors, match.get_end(1), match.get_end(1) + 1, TokenType.SYMBOL)

	# Get and process the value if present
	var value := match.get_string(2).strip_edges()
	if value:
		var value_start := text.find(value, match.get_end(1))
		if value_start != -1:
			# First check for and handle any tags
			var tag_match: RegExMatch = re_patterns.tag.search(value)
			if tag_match:
				_add_color(color_provider, colors, value_start + tag_match.get_start(0),
						  value_start + tag_match.get_end(0), TokenType.KEYWORD)
				# Get remaining content after tag
				var after_tag := value.substr(tag_match.get_end(0)).strip_edges()
				if after_tag:
					var after_tag_start = text.find(after_tag, value_start + tag_match.get_end(0))
					if after_tag_start != -1:
						# Now check for multiline indicator in remaining content
						var indicator_match: RegExMatch = re_patterns.multiline_indicator.search(after_tag)
						if indicator_match:
							_add_color(color_provider, colors, after_tag_start + indicator_match.get_start(1), after_tag_start + indicator_match.get_end(1), TokenType.SYMBOL)
						elif after_tag.begins_with("{") or after_tag.begins_with("["):
							# Process flow style collections after the tag
							colors.merge(_parse_flow_style(color_provider, after_tag, after_tag_start))
						else:
							# Process normal scalar after the tag
							_add_scalar_color(color_provider, colors, after_tag, after_tag_start)
					return colors

			# If no tag, check for multiline indicator in full value
			var indicator_match: RegExMatch = re_patterns.multiline_indicator.search(value)
			if indicator_match:
				_add_color(color_provider, colors, value_start + indicator_match.get_start(1), value_start + indicator_match.get_end(1), TokenType.SYMBOL)
			elif value.begins_with("[") or value.begins_with("{"):
				colors.merge(_parse_flow_style(color_provider, value, value_start))
			else:
				_add_scalar_color(color_provider, colors, value, value_start)
	return colors

# Colors for scalar values
func _add_scalar_color(color_provider: ColorProvider, colors: Dictionary, token: String, start_index: int) -> void:
	# Handle empty or whitespace-only tokens
	token = token.strip_edges()
	if token.is_empty():
		return

	# Check for quoted strings first
	if re_patterns.quoted_string.search(token):
		_add_color(color_provider, colors, start_index, start_index + token.length(), TokenType.STRING)
		return  # Important: return early to prevent parsing tags inside strings

	# Check for tags
	var tag_match: RegExMatch = re_patterns.tag.search(token)
	if tag_match:
		var tag_start := tag_match.get_start(0)
		var tag_end := tag_match.get_end(0)

		# Only color the tag portion
		_add_color(color_provider, colors, start_index + tag_start, start_index + tag_end, TokenType.KEYWORD)

		# Process any remaining content after the tag
		if tag_end < token.length():
			var remaining := token.substr(tag_end).strip_edges()
			if remaining:
				var remaining_start = start_index + token.find(remaining, tag_end)
				if remaining_start != -1:
					if remaining.begins_with("{") or remaining.begins_with("["):
						colors.merge(_parse_flow_style(color_provider, remaining, remaining_start))
					else:
						# Apply appropriate coloring for the remaining content
						if re_patterns.number.search(remaining):
							_add_color(color_provider, colors, remaining_start, remaining_start + remaining.length(), TokenType.NUMBER)
						elif re_patterns.boolean.search(remaining) or re_patterns.nullish.search(remaining) or re_patterns.special.search(remaining):
							_add_color(color_provider, colors, remaining_start, remaining_start + remaining.length(), TokenType.KEYWORD)
						else:
							_add_color(color_provider, colors, remaining_start, remaining_start + remaining.length(), TokenType.STRING)
		return

	# Rest of the scalar checks for non-tag content
	elif re_patterns.number.search(token):
		_add_color(color_provider, colors, start_index, start_index + token.length(), TokenType.NUMBER)
	elif re_patterns.boolean.search(token) or re_patterns.nullish.search(token) or re_patterns.special.search(token):
		_add_color(color_provider, colors, start_index, start_index + token.length(), TokenType.KEYWORD)
	elif re_patterns.anchor.search(token) or re_patterns.alias.search(token):
		_add_color(color_provider, colors, start_index, start_index + token.length(), TokenType.SYMBOL)
	else:
		# Default fallback is string color
		_add_color(color_provider, colors, start_index, start_index + token.length(), TokenType.STRING)

# Add color for a type
func _add_color(color_provider: ColorProvider, colors: Dictionary, start: int, end: int, type: TokenType) -> void:
	colors[start] = {"color": color_provider.get_color_for_type(type)}

# Sort the colors dictionary by index
func _sort_colors(colors: Dictionary) -> Dictionary:
	# Get all indices as an array
	var indices := colors.keys()
	indices.sort()  # Sort indices in ascending order

	# Create new dictionary with sorted indices
	var sorted_colors := {}
	for idx in indices:
		sorted_colors[idx] = colors[idx]

	return sorted_colors

```

# res://addons/yaml/editor/validator.gd
```gd
@tool
class_name YAMLEditorValidator extends Node

signal validation_completed(document)

var _thread: Thread
var _is_validating: bool = false
var _pending_validation: bool = false
var _validation_queue: Array = []

var code_editor: YAMLCodeEditor
var validation_timer: Timer
var file_system: YAMLFileSystem
var file_manager: YAMLEditorDocumentManager

func _ready() -> void:
	file_system = YAMLFileSystem.get_singleton()

	# Create validation timer
	validation_timer = Timer.new()
	add_child(validation_timer)
	validation_timer.one_shot = true
	validation_timer.wait_time = 0.5  # 500ms delay
	validation_timer.timeout.connect(_on_validation_timer_timeout)

func _exit_tree() -> void:
	if _thread and _thread.is_started():
		_thread.wait_to_finish()

func setup(p_code_editor: YAMLCodeEditor, p_file_manager: YAMLEditorDocumentManager) -> void:
	code_editor = p_code_editor
	file_manager = p_file_manager

	# Connect to code editor changes
	code_editor.validation_requested.connect(_on_validation_requested)

	# Connect to document changes
	file_manager.document_changed.connect(_on_document_changed)
	file_manager.document_created.connect(_on_document_created)

func _on_validation_requested() -> void:
	# Reset and start the validation timer
	validation_timer.stop()
	validation_timer.start()

func _on_validation_timer_timeout() -> void:
	var document = file_manager.get_current_document()
	if document:
		validate_document(document)

func _on_document_changed(document: YAMLEditorDocument) -> void:
	# Show any existing validation results
	if document.validation_result:
		validation_completed.emit(document)

	# Run validation if no results exist or document has errors
	if document.validation_result == null or document.has_error():
		validate_document(document)

func _on_document_created(document: YAMLEditorDocument) -> void:
	# Validate new document
	validate_document(document)

func validate_document(document: YAMLEditorDocument) -> void:
	if document == null:
		return

	if _is_validating:
		# Add to validation queue
		if not _validation_queue.has(document):
			_validation_queue.append(document)
		return

	_is_validating = true

	if _thread and _thread.is_started():
		_thread.wait_to_finish()

	_thread = Thread.new()
	_thread.start(_validation_thread_function.bind(document))

func _validation_thread_function(document: YAMLEditorDocument) -> void:
	# YAML validation is thread-safe
	var result = YAML.validate_syntax(document.content)

	# Update document on main thread
	call_deferred("_finish_validation", document, result)

func _finish_validation(document: YAMLEditorDocument, result: YAMLResult) -> void:
	# Update document with validation result
	document.set_validation_result(result)

	# Emit signal
	validation_completed.emit(document)

	# Process any pending validations
	_is_validating = false

	if not _validation_queue.is_empty():
		var next_document = _validation_queue.pop_front()
		validate_document(next_document)

func mark_error_in_editor(line: int, message: String) -> void:
	if is_instance_valid(code_editor):
		code_editor.mark_error_line(line, message)

func clear_errors_in_editor() -> void:
	if is_instance_valid(code_editor):
		code_editor.clear_error_indicators()

```

# res://addons/yaml/editor/yaml_editor.gd
```gd
@tool
class_name YAMLEditor extends Control

# Components
var file_manager: YAMLEditorDocumentManager
var validator: YAMLEditorValidator
var session_manager: YAMLEditorSessionManager

# File system singleton
var file_system: YAMLFileSystem

# Editor reference
var editor: EditorInterface

# UI references
@export var menu_bar: YAMLEditorMenuBar
@export var file_list: YAMLEditorFileList
@export var resizable_container: HSplitContainer
@export var code_edit: YAMLCodeEditor
@export var status_panel: YAMLEditorStatusBar
@export var find_replace_panel: YAMLEditorFindReplaceBar

func _ready() -> void:
	# Get reference to file system singleton first
	file_system = YAMLFileSystem.get_singleton()

	# Initialize components
	file_manager = YAMLEditorDocumentManager.new()
	add_child(file_manager)

	validator = YAMLEditorValidator.new()
	add_child(validator)

	session_manager = YAMLEditorSessionManager.new()
	add_child(session_manager)

	# Wait for UI to be ready
	await get_tree().process_frame

	# Set up components
	file_manager.setup(file_list, code_edit)
	validator.setup(code_edit, file_manager)
	session_manager.setup(file_manager, resizable_container)

	# Connect menu signals for file operations
	menu_bar.new_file.connect(_on_new_button_pressed)
	menu_bar.open_file.connect(_on_open_button_pressed)
	menu_bar.save_requested.connect(_on_save_button_pressed)
	menu_bar.save_as_requested.connect(_on_save_as_button_pressed)
	menu_bar.close_requested.connect(_on_close_current_file)

	# Connect menu signals for edit options
	menu_bar.undo_requested.connect(_on_undo_requested)
	menu_bar.redo_requested.connect(_on_redo_requested)
	menu_bar.cut_requested.connect(_on_cut_requested)
	menu_bar.copy_requested.connect(_on_copy_requested)
	menu_bar.paste_requested.connect(_on_paste_requested)
	menu_bar.select_all_requested.connect(_on_select_all_requested)

	# Connect menu signals for search
	menu_bar.find_requested.connect(_on_find_requested)
	menu_bar.find_next_requested.connect(_on_find_next_requested)
	menu_bar.find_previous_requested.connect(_on_find_previous_requested)
	menu_bar.replace_requested.connect(_on_replace_requested)

	# Connect code editor signals
	code_edit.content_changed.connect(_on_content_changed)
	code_edit.save_requested.connect(_on_save_button_pressed)
	code_edit.close_requested.connect(_on_close_current_file)
	code_edit.undo_requested.connect(_on_undo_requested)
	code_edit.redo_requested.connect(_on_redo_requested)
	code_edit.caret_changed.connect(_on_caret_changed)
	code_edit.zoom_changed.connect(_on_zoom_changed)  # Connect to new zoom signal

	# Connect file manager signals
	file_manager.document_changed.connect(_on_document_changed)

	# Connect validation signals
	validator.validation_completed.connect(_on_validation_completed)

	# Set initial zoom text
	_on_zoom_changed(code_edit.zoom_level)

	# Share editor interface with components via tree metadata
	if editor:
		get_tree().set_meta("editor_interface", editor)

	# Setup the find and replace panels
	find_replace_panel.replace_performed.connect(_on_replace_performed)
	find_replace_panel.replace_all_performed.connect(_on_replace_all_performed)

	# Load previous session
	session_manager.load_session()

func _input(event):
	if event is InputEventKey and event.keycode == KEY_ESCAPE and event.pressed:
		if find_replace_panel.visible:
			find_replace_panel.hide_panel()
			get_viewport().set_input_as_handled()

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.get_keycode_with_modifiers():
			KEY_MASK_CTRL | KEY_F:
				_on_find_requested()
				get_viewport().set_input_as_handled()
			KEY_MASK_CTRL | KEY_R:
				_on_replace_requested()
				get_viewport().set_input_as_handled()
			KEY_F3:
				_on_find_next_requested()
				get_viewport().set_input_as_handled()
			KEY_MASK_SHIFT | KEY_F3:
				_on_find_previous_requested()
				get_viewport().set_input_as_handled()

func _on_zoom_changed(new_zoom_level: float) -> void:
	status_panel.set_zoom_level(new_zoom_level)

func _on_new_button_pressed() -> void:
	file_manager.new_file()

func _on_open_button_pressed() -> void:
	var file_dialog := EditorFileDialog.new()
	file_dialog.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE
	file_dialog.access = EditorFileDialog.ACCESS_FILESYSTEM
	file_dialog.add_filter("*.yaml;YAML Files")
	file_dialog.add_filter("*.yml;YML Files")
	file_dialog.title = "Open YAML File"

	file_dialog.file_selected.connect(
		func(path):
			file_manager.open_file(path)
			file_dialog.queue_free()
	)
	file_dialog.canceled.connect(func(): file_dialog.queue_free())

	add_child(file_dialog)
	file_dialog.popup_centered_ratio(0.7)

func _on_save_button_pressed() -> void:
	var document := file_manager.get_current_document()
	if not document:
		return

	if document.is_untitled():
		_on_save_as_button_pressed()
	else:
		file_manager.save_document(document)

func _on_save_as_button_pressed() -> void:
	var document := file_manager.get_current_document()
	if not document:
		return

	var file_dialog := EditorFileDialog.new()
	file_dialog.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	file_dialog.access = EditorFileDialog.ACCESS_FILESYSTEM
	file_dialog.add_filter("*.yaml;YAML Files")
	file_dialog.add_filter("*.yml;YML Files")
	file_dialog.title = "Save YAML File As"

	if not document.is_untitled():
		file_dialog.current_path = document.path

	file_dialog.file_selected.connect(
		func(path):
			file_manager.save_document_as(document, path)
			file_dialog.queue_free()
	)
	file_dialog.canceled.connect(func(): file_dialog.queue_free())

	add_child(file_dialog)
	file_dialog.popup_centered_ratio(0.7)

func _on_content_changed() -> void:
	var document := file_manager.get_current_document()
	if not document:
		return

	# Update document content
	file_manager.update_document_content(document, code_edit.text)

	# Request validation
	validator.validate_document(document)

func _on_close_current_file() -> void:
	var document := file_manager.get_current_document()
	if document:
		file_manager.close_document(document)

func _on_undo_requested() -> void:
	var document := file_manager.get_current_document()
	if not document:
		return

	var state := document.undo()
	if not state:
		return

	code_edit.set_text_and_preserve_state(document.content)

	# Optionally restore caret position if needed
	if state.caret_line > 0 and state.caret_column > 0:
		if state.caret_line < code_edit.get_line_count():
			code_edit.set_caret_line(state.caret_line)
			if state.caret_column <= code_edit.get_line(state.caret_line).length():
				code_edit.set_caret_column(state.caret_column)

	# Validate after undo
	validator.validate_document(document)

	# And re-trigger search if we did undo
	if find_replace_panel.visible:
		find_replace_panel.trigger_search()

func _on_redo_requested() -> void:
	var document := file_manager.get_current_document()
	if not document:
		return

	var state := document.redo()
	if not state:
		return

	code_edit.set_text_and_preserve_state(document.content)

	# Optionally restore caret position if needed
	if state.caret_line > 0 and state.caret_column > 0:
		if state.caret_line < code_edit.get_line_count():
			code_edit.set_caret_line(state.caret_line)
			if state.caret_column <= code_edit.get_line(state.caret_line).length():
				code_edit.set_caret_column(state.caret_column)

	# Validate after redo
	validator.validate_document(document)

	# And re-trigger search if we did redo
	if find_replace_panel.visible:
		find_replace_panel.trigger_search()

func _on_cut_requested() -> void:
	code_edit.cut_selection()

func _on_copy_requested() -> void:
	code_edit.copy_selection()

func _on_paste_requested() -> void:
	code_edit.paste_clipboard()

func _on_select_all_requested() -> void:
	code_edit.select_all()

# Search-related methods
func _on_find_requested() -> void:
	find_replace_panel.show_find_panel()
	# Hide replace panel if we request just search
	if find_replace_panel.replace_panel_visible:
		find_replace_panel.replace_panel_visible = false

func _on_replace_requested() -> void:
	find_replace_panel.show_replace_panel()

func _on_find_next_requested() -> void:
	if find_replace_panel and find_replace_panel.visible:
		find_replace_panel.find_next()
	else:
		_on_find_requested()

func _on_find_previous_requested() -> void:
	if find_replace_panel and find_replace_panel.visible:
		find_replace_panel.find_previous()
	else:
		_on_find_requested()

func _on_replace_performed() -> void:
	# After a replace, request validation
	code_edit.validation_requested.emit()

	# Update the current document
	_on_content_changed()

func _on_replace_all_performed() -> void:
	# After replace all, request validation
	code_edit.validation_requested.emit()

	# Update the current document
	_on_content_changed()

	# Show a message in the status bar
	if find_replace_panel.visible and find_replace_panel.replace_panel.visible:
		status_panel.set_status("Replacement complete", Color.GREEN)
		# Clear the status after a delay
		if get_tree():
			await get_tree().create_timer(2.0).timeout
			status_panel.set_status("")

func _on_document_changed(document: YAMLEditorDocument) -> void:
	# Update status panel with document info
	_update_line_col_label()

	# Show any validation errors
	if document.has_error():
		_display_validation_error(document)
	else:
		status_panel.set_status("")
		validator.clear_errors_in_editor()

	# Re-trigger search
	if find_replace_panel.visible:
		find_replace_panel.trigger_search()

func _on_caret_changed() -> void:
	status_panel.set_line_column(code_edit.get_current_line_col_info())

func _on_validation_completed(document: YAMLEditorDocument) -> void:
	if document != file_manager.get_current_document():
		return

	if document.has_error():
		_display_validation_error(document)
	else:
		status_panel.set_status("")
		validator.clear_errors_in_editor()

func _display_validation_error(document: YAMLEditorDocument) -> void:
	status_panel.set_validation_result(document.validation_result)

	var result := document.validation_result
	if not result.has_error():
		return

	# Mark error line in editor if possible
	var error := result.get_error_message()
	var line := result.get_error_line()
	if line >= 0:
		validator.mark_error_in_editor(line - 1, error)  # Convert to 0-based line

func _has_unsaved_changes() -> bool:
	return file_manager.has_unsaved_changes()

func get_open_files() -> Array:
	return file_manager.get_open_paths()

func handle_filesystem_change() -> void:
	file_manager.handle_filesystem_change()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		# Save session when editor is closing
		session_manager.save_session()

func _update_line_col_label() -> void:
	# Allow one frame to pass to ensure the UI is updated
	if get_tree():
		await get_tree().process_frame
		_on_caret_changed()

```

# res://addons/yaml/examples/classes/my_custom_class.gd
```gd
class_name MyCustomClass extends Node

@export var string_val: String
@export var int_val: int
@export var float_val: float
@export var color_val: Color

func _init(p_string := "", p_int := 0, p_float := 0.0, p_color = Color.WHITE) -> void:
	string_val = p_string
	int_val = p_int
	float_val = p_float
	color_val = p_color

func hello():
	print(string_val)

static func deserialize(data: Variant):
	if typeof(data) != TYPE_DICTIONARY:
		return YAMLResult.error("Deserializing MyCustomClass expects Dictionary, received %s" % [type_string(typeof(data))])

	var dict: Dictionary = data

	if !dict.has("string_val"):
		return YAMLResult.error("Missing string_val field")
	if !dict.has("int_val"):
		return YAMLResult.error("Missing int_val field")
	if !dict.has("float_val"):
		return YAMLResult.error("Missing float_val field")
	if !dict.has("color_val"):
		return YAMLResult.error("Missing color_val field")

	var string_val: String = dict.get("string_val")
	var int_val: int = dict.get("int_val")
	var float_val: float = dict.get("float_val")
	var color_val: Color = dict.get("color_val")

	return MyCustomClass.new(
		string_val,
		int_val,
		float_val,
		color_val
	)

func serialize() -> Dictionary:
	return {
		"string_val": string_val,
		"int_val": int_val,
		"float_val": float_val,
		"color_val": color_val,
	}

func _to_string() -> String:
	return "MyCustomClass(%s)" % string_val

```

# res://addons/yaml/examples/classes/my_custom_resource.gd
```gd
class_name MyCustomResource extends Resource

@export var string_val: String
@export var int_val: int
@export var float_val: float
@export var color_val: Color

func _init(p_string := "", p_int := 0, p_float := 0.0, p_color = Color.WHITE) -> void:
	string_val = p_string
	int_val = p_int
	float_val = p_float
	color_val = p_color

func hello():
	print(string_val)

static func deserialize(data: Variant):
	if typeof(data) != TYPE_DICTIONARY:
		return YAMLResult.error("Deserializing MyCustomResource expects Dictionary, received %s" % [type_string(typeof(data))])

	var dict: Dictionary = data

	if !dict.has("string_val"):
		return YAMLResult.error("Missing string_val field")
	if !dict.has("int_val"):
		return YAMLResult.error("Missing int_val field")
	if !dict.has("float_val"):
		return YAMLResult.error("Missing float_val field")
	if !dict.has("color_val"):
		return YAMLResult.error("Missing color_val field")

	var string_val: String = dict.get("string_val")
	var int_val: int = dict.get("int_val")
	var float_val: float = dict.get("float_val")
	var color_val: Color = dict.get("color_val")

	return MyCustomResource.new(
		string_val,
		int_val,
		float_val,
		color_val
	)

func serialize() -> Dictionary:
	return {
		"string_val": string_val,
		"int_val": int_val,
		"float_val": float_val,
		"color_val": color_val,
	}

func _to_string() -> String:
	return "MyCustomResource(%s)" % string_val

```

# res://addons/yaml/examples/classes/my_string_class.gd
```gd
class_name MyStringClass extends Object

@export var value: String

func _init(p_value := "") -> void:
	value = p_value

static func deserialize(data: Variant):
	if typeof(data) != TYPE_STRING:
		return YAMLResult.error("Deserializing MyStringClass expects String, received %s" % [type_string(typeof(data))])

	return MyStringClass.new(data)

func serialize() -> String:
	return value

func _to_string() -> String:
	return "MyStringClass(%s)" % value

```

# res://addons/yaml/examples/example_base.gd
```gd
class_name ExampleBase extends Node2D

# Whether to show detailed logs
var LOG_VERBOSE := false

# Extra emoji to make logs visually distinct
var icon := ""

# Hook that runs all examples in the class
func _ready() -> void:
	if !visible:
		return

	print_rich("\n[b][font_size=16]%s%s[/font_size][/b]" % [
		"%s " % icon if icon.length() > 0 else "",
		name
	])

	run_examples()

# Override this to run examples in your class
func run_examples() -> void:
	# Child classes should override this method
	pass

# Logging Helpers
func log_header(text: String) -> void:
	print_rich("\n[b][font_size=16]%s[/font_size][/b]" % text)

func log_subheader(text: String) -> void:
	print_rich("\n[b][font_size=14]%s[/font_size][/b]" % text)

func log_success(text: Variant) -> void:
	print_rich("[color=green]✅ %s[/color]" % str(text))

func log_error(text: Variant) -> void:
	print_rich("[color=red]❌ %s[/color]" % str(text))

func log_warning(text: Variant) -> void:
	print_rich("[color=yellow]⚠️ %s[/color]" % str(text))

func log_info(text: Variant) -> void:
	print_rich("%s" % str(text))

func log_code_block(code: String) -> void:
	print_rich("\n[b]Code:[/b]")
	print_rich("[color=#aaaaff]%s" % code)

func log_result(text: Variant) -> void:
	print_rich("\n[b]Result:[/b]\n%s" % str(text))

# Run a single example with timing
func run_example(title: String, method: Callable) -> void:
	print_rich("\n[b][font_size=14]%s[/font_size][/b]" % title)
	var start_time := Time.get_ticks_usec()

	method.call()

	var elapsed := Time.get_ticks_usec() - start_time
	var t: float = elapsed
	var tl = "µsec"
	if t > 1000:
		t /= 1000.0
		tl = "ms"

	print_rich("\n[color=#888888]Completed in %.2f %s[/color]" % [t, tl])

```

# res://addons/yaml/examples/example_basic_usage.gd
```gd
extends ExampleBase

const YAML_FILE = "res://addons/yaml/examples/data/supported_syntax.yaml"
const OUTPUT_FILE = "user://supported_syntax_copy.yaml"

var yaml_text := """
string: string_value
number: 1234
list:
  - apples
  - oranges
"""

var data

func _init() -> void:
	icon = "📝"

func run_examples() -> void:
	run_example("Validate YAML String Syntax", validate_yaml_string_syntax)
	run_example("Parse YAML Text", parse_yaml_text)
	run_example("Stringify Data", stringify_data)
	run_example("Validate File Syntax", validate_file_syntax)
	run_example("Load File", load_file)
	run_example("Save File", save_file)
	run_example("Load Saved File", load_saved_file)

func validate_yaml_string_syntax() -> void:
	log_code_block(yaml_text)

	log_info("Validating YAML string...")
	var result := YAML.validate_syntax(yaml_text)

	if result.has_error():
		log_error("Validation failed: " + result.get_error())
		return

	log_success("YAML is valid!")

func parse_yaml_text() -> void:
	log_info("Parsing YAML text...")
	var result := YAML.parse(yaml_text)

	if result.has_error():
		log_error("Parse failed: " + result.get_error())
		return

	data = result.get_data()
	log_success("YAML parsed successfully")

	if LOG_VERBOSE:
		log_result(str(data))

		log_info("Accessing data values:")
		log_info("• string value: " + data.string)
		log_info("• number value: " + str(data.number))
		log_info("• list items: " + str(data.list))

func stringify_data() -> void:
	# First ensure we have data to stringify
	if data == null:
		data = YAML.parse(yaml_text).get_data()

	log_info("Converting data structure to YAML string...")
	var result := YAML.stringify(data)

	if result.has_error():
		log_error("Stringify failed: " + result.get_error())
		return

	log_success("Data converted to YAML successfully")

	if LOG_VERBOSE:
		log_result(result.get_data())

		# Verify the round trip
		var yaml_output = result.get_data().strip_edges()
		var original = yaml_text.strip_edges()
		if yaml_output == original:
			log_success("Round-trip verification: Output matches original")
		else:
			log_warning("Round-trip produced different output (semantically equivalent)")
			log_info("Original:\n" + original)
			log_info("Output:\n" + yaml_output)

func validate_file_syntax() -> void:
	log_info("Validating YAML file: " + YAML_FILE)
	var result := YAML.validate_file_syntax(YAML_FILE)

	if result.has_error():
		log_error("File validation failed: " + result.get_error())
		return

	log_success("YAML file is valid")

func load_file() -> void:
	log_info("Loading YAML file: " + YAML_FILE)
	var result := YAML.load_file(YAML_FILE)

	if result.has_error():
		log_error("File loading failed: " + result.get_error())
		return

	data = result.get_data()
	log_success("YAML file loaded successfully")

	if LOG_VERBOSE:
		log_info("File contains " + str(data.size()) + " keys")
		log_result(str(data).substr(0, 500) + "...\n(output truncated)")

func save_file() -> void:
	# Make sure we have data
	if data == null:
		data = {"example": "data", "created": "now", "values": [1, 2, 3]}

	log_info("Saving data to YAML file: " + OUTPUT_FILE)
	var result := YAML.save_file(data, OUTPUT_FILE)

	if result.has_error():
		log_error("File saving failed: " + result.get_error())
		return

	log_success("Data saved to YAML file successfully")

	if LOG_VERBOSE:
		log_result(result.get_data())

func load_saved_file() -> void:
	log_info("Loading previously saved file: " + OUTPUT_FILE)
	var result := YAML.load_file(OUTPUT_FILE)

	if result.has_error():
		log_error("File loading failed: " + result.get_error())
		return

	var loaded_data = result.get_data()
	log_success("Saved file loaded successfully")

	if LOG_VERBOSE:
		log_result(str(loaded_data))

```

# res://addons/yaml/examples/example_custom_class.gd
```gd
extends ExampleBase

func _init() -> void:
	icon = "🧩"
	LOG_VERBOSE = true

func _enter_tree() -> void:
	# Register our custom classes when the node enters the tree
	YAML.register_class(MyCustomClass, "serialize", "deserialize", "ruby/object:MyCustomClass")
	YAML.register_class(MyCustomResource)
	YAML.register_class(MyStringClass)

func _exit_tree() -> void:
	# Clean up registrations when the node exits the tree
	YAML.unregister_class(MyCustomClass)
	YAML.unregister_class(MyCustomResource)
	YAML.unregister_class(MyStringClass)

func run_examples() -> void:
	run_example("Custom Node Class", custom_node_class)
	run_example("Custom Class Errors", custom_class_errors)
	run_example("String-Based Custom Class", custom_string_class)
	run_example("Custom Resource Class", custom_resource)
	run_example("Custom Resource Errors", custom_resource_errors)
	run_example("Class Registration Management", class_registration_management)

func custom_node_class() -> void:
	log_info("Creating instance of MyCustomClass...")
	var object = MyCustomClass.new("hello world", 123, PI)

	log_info("Stringifying custom class instance to YAML...")
	var str_result := YAML.stringify(object)

	if str_result.has_error():
		log_error("Stringify failed: " + str_result.get_error())
		return

	var yaml_text: String = str_result.get_data()
	log_success("Custom class stringified successfully")

	if LOG_VERBOSE:
		log_info("MyCustomClass as YAML:\n" + yaml_text)

	log_info("Parsing YAML back into MyCustomClass...")
	var parse_result := YAML.parse(yaml_text)

	if parse_result.has_error():
		log_error("Parse failed: " + parse_result.get_error())
		return

	var obj: MyCustomClass = parse_result.get_data()

	if obj is MyCustomClass:
		log_success("YAML parsed back into MyCustomClass")
		log_info("string_val: " + obj.string_val)
		log_info("int_val: " + str(obj.int_val))
		log_info("float_val: " + str(obj.float_val))
	else:
		log_error("Failed to parse back into MyCustomClass")

func custom_class_errors() -> void:
	log_info("Testing error handling with invalid MyCustomClass YAML...")

	# Missing required field
	var yaml_text = """
!MyCustomClass
string_val: foo
"""
	log_code_block(yaml_text)
	log_info("Attempting to parse with missing required fields...")

	var result := YAML.parse(yaml_text)

	if result.has_error():
		log_success("Correctly detected missing field error")
		log_info("Error message: " + result.get_error())
	else:
		log_error("Failed to detect missing required field")

	# Invalid data structure
	var invalid_yaml_text = """
!MyCustomClass
[1, 2, 3]
"""
	log_code_block(invalid_yaml_text)
	log_info("Attempting to parse with wrong data structure...")

	var bad_result := YAML.parse(invalid_yaml_text)

	if bad_result.has_error():
		log_success("Correctly detected wrong data structure error")
		log_info("Error message: " + bad_result.get_error())
	else:
		log_error("Failed to detect wrong data structure")

func custom_string_class() -> void:
	log_info("Creating instance of string-based MyStringClass...")
	var object = MyStringClass.new("hello world")

	log_info("Stringifying string-based class to YAML...")
	var str_result := YAML.stringify(object)

	if str_result.has_error():
		log_error("Stringify failed: " + str_result.get_error())
		return

	var text: String = str_result.get_data()
	log_success("String-based class stringified successfully")

	if LOG_VERBOSE:
		log_result("MyStringClass as YAML:\n" + text)

	log_info("Parsing YAML back into MyStringClass...")
	var parse_result := YAML.parse(text)

	if parse_result.has_error():
		log_error("Parse failed: " + parse_result.get_error())
		return

	var obj = parse_result.get_data()

	if obj is MyStringClass:
		log_success("YAML parsed back into MyStringClass")
		log_info("Value: " + obj.value)
	else:
		log_error("Failed to parse back into MyStringClass")

func custom_resource() -> void:
	log_info("Creating instance of MyCustomResource...")
	var resource = MyCustomResource.new("I am resource", 42, 69.69)

	log_info("Stringifying resource class to YAML...")
	var str_result := YAML.stringify(resource)

	if str_result.has_error():
		log_error("Stringify failed: " + str_result.get_error())
		return

	var yaml_text: String = str_result.get_data()
	log_success("Resource class stringified successfully")

	if LOG_VERBOSE:
		log_result("MyCustomResource as YAML:\n" + yaml_text)

	log_info("Parsing YAML back into MyCustomResource...")
	var parse_result := YAML.parse(yaml_text)

	if parse_result.has_error():
		log_error("Parse failed: " + parse_result.get_error())
		return

	var obj = parse_result.get_data()

	if obj is MyCustomResource:
		log_success("YAML parsed back into MyCustomResource")
		log_info("string_val: " + obj.string_val)
		log_info("int_val: " + str(obj.int_val))
		log_info("float_val: " + str(obj.float_val))
	else:
		log_error("Failed to parse back into MyCustomResource")

func custom_resource_errors() -> void:
	log_info("Testing error handling with invalid MyCustomResource YAML...")

	# Missing required field
	var yaml_text = """
!MyCustomResource
color_val: black
"""
	log_code_block(yaml_text)
	log_info("Attempting to parse with missing required fields...")

	var result := YAML.parse(yaml_text)

	if result.has_error():
		log_success("Correctly detected missing field error")
		log_info("Error message: " + result.get_error())
	else:
		log_error("Failed to detect missing required field")

	# Invalid data structure
	var invalid_yaml_text = """
!MyCustomResource
[1, 2, 3]
"""
	log_code_block(invalid_yaml_text)
	log_info("Attempting to parse with wrong data structure...")

	var bad_result := YAML.parse(invalid_yaml_text)

	if bad_result.has_error():
		log_success("Correctly detected wrong data structure error")
		log_info("Error message: " + bad_result.get_error())
	else:
		log_error("Failed to detect wrong data structure")

func class_registration_management() -> void:
	log_subheader("Class Registration Management")

	log_info("Checking if classes are registered...")

	if YAML.has_registered_class("MyCustomClass"):
		log_success("MyCustomClass is registered")
	else:
		log_error("MyCustomClass is not registered properly")

	if YAML.has_registered_class("MyCustomResource"):
		log_success("MyCustomResource is registered")
	else:
		log_error("MyCustomResource is not registered properly")

	if YAML.has_registered_class("MyStringClass"):
		log_success("MyStringClass is registered")
	else:
		log_error("MyStringClass is not registered properly")

	log_info("\nExample of registering with custom methods:")
	var code = """
# Register with custom method names
YAML.register_class(MyCustomClass, "to_yaml", "from_yaml")

# Methods in the class would then be:
func to_yaml():
	# Custom serialization code
	return {...}

static func from_yaml(data):
	# Custom deserialization code
	return MyCustomClass.new(...)
"""
	log_code_block(code)

	log_info("\nBest practices for class registration:")
	log_info("1. Register classes at startup in an autoload/singleton")
	log_info("2. Use consistent naming for serialize/deserialize methods")
	log_info("3. Implement thorough validation in deserialize methods")
	log_info("4. For scripts that might be unloaded, register in _enter_tree and unregister in _exit_tree")

```

# res://addons/yaml/examples/example_error_handling.gd
```gd
extends ExampleBase

func _init() -> void:
	icon = "❌"

func run_examples() -> void:
	run_example("Invalid Indentation", invalid_indentation)
	run_example("Unmatched Quotes", unmatched_quotes)
	run_example("Circular Reference", circular_reference)
	run_example("Validation Example", validation_example)
	run_example("Error Details", error_details)
	run_example("Error Handling Patterns", error_handling_patterns)

func invalid_indentation() -> void:
	var invalid_yaml := """
key: value
  indentation: wrong
"""
	log_code_block(invalid_yaml)
	log_info("Parsing YAML with invalid indentation...")

	var result := YAML.parse(invalid_yaml)

	if result.has_error():
		log_success("Correctly detected error: " + result.get_error())
		log_info("Line: " + str(result.get_error_line()))
		log_info("Column: " + str(result.get_error_column()))
		return

	log_error("Failed to detect invalid indentation")

func unmatched_quotes() -> void:
	var unmatched_quotes := """
message: "This quote is not closed
next_line: value
"""
	log_code_block(unmatched_quotes)
	log_info("Parsing YAML with unmatched quotes...")

	var result = YAML.parse(unmatched_quotes)

	if result.has_error():
		log_success("Correctly detected error: " + result.get_error())
		return

	log_error("Failed to detect unmatched quotes")

func circular_reference() -> void:
	log_info("Creating circular reference in data structure...")

	# Create a circular reference
	var dict1 = {}
	var dict2 = {"ref": dict1}
	dict1["circular"] = dict2

	log_info("Attempting to stringify circular reference...")
	var result := YAML.stringify(dict1)

	if result.has_error():
		log_success("Correctly detected error: " + result.get_error())
		return

	log_error("Failed to detect circular reference")

func validation_example() -> void:
	var invalid_yaml := """
key: value
- invalid
  list
  format
"""
	log_code_block(invalid_yaml)
	log_info("Validating incorrect YAML...")

	var result = YAML.validate_syntax(invalid_yaml)

	if result.has_error():
		log_success("Validation correctly detected error: " + result.get_error())
		return

	log_error("Validation failed to detect invalid YAML")

func error_details() -> void:
	var yaml_with_error := """
valid_line: value
- invalid line: value
another_line: value
"""
	log_code_block(yaml_with_error)
	log_info("Examining error details...")

	var result := YAML.parse(yaml_with_error)

	if result.has_error():
		log_success("Error detected: " + result.get_error())

		# Show detailed error information
		log_info("Error message: " + result.get_error_message())
		log_info("Error line: " + str(result.get_error_line()))
		log_info("Error column: " + str(result.get_error_column()))

		# Highlight the error line
		var yaml_lines = yaml_with_error.split("\n")
		if result.get_error_line() > 0 and result.get_error_line() <= yaml_lines.size():
			var error_line = yaml_lines[result.get_error_line() - 1]
			log_info("Line content: " + error_line)

			if result.get_error_column() > 0:
				var pointer = " ".repeat(result.get_error_column() - 1) + "^"
				log_info(pointer + " Error position")
		return

	log_error("Failed to detect error")

func error_handling_patterns() -> void:
	log_subheader("Error Handling Patterns")

	# Pattern 1: Try-parse pattern
	log_info("Pattern 1: Using try_parse for simplified error handling")
	var yaml_text = """
name: Example
valid: true
"""
	var data = YAML.try_parse(yaml_text)
	if data:
		log_success("try_parse succeeded")
		log_info("Data: " + str(data))
	else:
		log_error("try_parse failed")

	# Pattern 2: get_error vs get_error_message
	log_info("\nPattern 2: Detailed vs Simple Error Messages")
	var invalid_yaml = "key: [invalid"
	var result = YAML.parse(invalid_yaml)
	if result.has_error():
		log_info("Detailed error: " + result.get_error())
		log_info("Simple message: " + result.get_error_message())

	# Pattern 3: Creating custom errors
	log_info("\nPattern 3: Creating custom validation errors")

	var config_yaml = """
name: MyApp
# version is missing
"""
	var parsed = YAML.parse(config_yaml)
	if !parsed.has_error():
		var validation = validate_config(parsed.get_data())
		if validation.has_error():
			log_success("Custom validation error: " + validation.get_error_message())
		else:
			log_info("Config is valid")
	else:
		log_error("Parse error: " + parsed.get_error())

func validate_config(data):
	if !data.has("name"):
		return YAMLResult.error("Configuration missing 'name' field")
	if !data.has("version"):
		return YAMLResult.error("Configuration missing 'version' field")
	return data

```

# res://addons/yaml/examples/example_multi_document.gd
```gd
extends ExampleBase

const MULTI_DOC_FILE = "res://addons/yaml/examples/data/multi_document.yaml"
const OUTPUT_FILE = "user://multi_document_copy.yaml"

var multi_doc_yaml := """
# Configuration Document
name: MyApplication
version: 1.2.3
environment: production
---
# Database Settings
database:
  host: localhost
  port: 5432
  name: myapp_db
  credentials:
	username: admin
	password: secret123
---
# Feature Flags
features:
  enable_new_ui: true
  enable_analytics: false
  enable_caching: true
  max_connections: 100
---
# Logging Configuration
logging:
  level: INFO
  handlers:
	- console
	- file
  file_path: /var/log/myapp.log
""".replace("	", "     ") # Handle Godot's tab indentation

var parsed_documents

func _init() -> void:
	icon = "📑"

func run_examples() -> void:
	run_example("Validate Multi-Document YAML", validate_multi_document)
	run_example("Parse Multi-Document YAML", parse_multi_document)
	run_example("Access Individual Documents", access_individual_documents)
	run_example("Work with Document Count", work_with_document_count)
	run_example("Process All Documents", process_all_documents)
	run_example("Create Multi-Document YAML", create_multi_document)
	run_example("Save Multi-Document File", save_multi_document_file)
	run_example("Load Multi-Document File", load_multi_document_file)

func validate_multi_document() -> void:
	log_info("Validating multi-document YAML string...")
	var result := YAML.validate_syntax(multi_doc_yaml)

	if result.has_error():
		log_error("Validation failed: " + result.get_error())
		return

	log_success("Multi-document YAML is valid!")

func parse_multi_document() -> void:
	log_info("Parsing multi-document YAML...")
	var result := YAML.parse(multi_doc_yaml)

	if result.has_error():
		log_error("Parse failed: " + result.get_error())
		return

	parsed_documents = result
	log_success("Multi-document YAML parsed successfully")

	if LOG_VERBOSE:
		log_info("Has multiple documents: %s" % result.has_multiple_documents())
		log_info("Found " + str(result.get_document_count()) + " documents")

func access_individual_documents() -> void:
	# Ensure we have parsed documents
	if parsed_documents == null:
		parsed_documents = YAML.parse(multi_doc_yaml)

	log_info("Accessing individual documents...")

	# Access first document (configuration)
	var config_doc = parsed_documents.get_document(0)
	if config_doc != null:
		log_success("Document 0 - Configuration:")
		log_info("• App name: " + str(config_doc.name))
		log_info("• Version: " + str(config_doc.version))
		log_info("• Environment: " + str(config_doc.environment))

	# Access second document (database settings)
	var db_doc = parsed_documents.get_document(1)
	if db_doc != null:
		log_success("Document 1 - Database Settings:")
		log_info("• Host: " + str(db_doc.database.host))
		log_info("• Port: " + str(db_doc.database.port))
		log_info("• Database: " + str(db_doc.database.name))

	# Access third document (feature flags)
	var features_doc = parsed_documents.get_document(2)
	if features_doc != null:
		log_success("Document 2 - Feature Flags:")
		log_info("• New UI enabled: " + str(features_doc.features.enable_new_ui))
		log_info("• Analytics enabled: " + str(features_doc.features.enable_analytics))
		log_info("• Max connections: " + str(features_doc.features.max_connections))

	# Try to access non-existent document
	var non_existent = parsed_documents.get_document(10)
	if non_existent == null:
		log_info("Document 10 (non-existent): null")

func work_with_document_count() -> void:
	if parsed_documents == null:
		parsed_documents = YAML.parse(multi_doc_yaml)

	var count = parsed_documents.get_document_count()
	log_info("Total document count: " + str(count))

	log_info("Iterating through all documents by index:")
	for i in range(count):
		var doc = parsed_documents.get_document(i)
		var doc_type = "Unknown"

		# Identify document type by its content
		if doc.has("name") and doc.has("version"):
			doc_type = "Configuration"
		elif doc.has("database"):
			doc_type = "Database Settings"
		elif doc.has("features"):
			doc_type = "Feature Flags"
		elif doc.has("logging"):
			doc_type = "Logging Configuration"

		log_info("• Document " + str(i) + ": " + doc_type)

func process_all_documents() -> void:
	if parsed_documents == null:
		parsed_documents = YAML.parse(multi_doc_yaml)

	log_info("Processing all documents at once...")
	var all_docs = parsed_documents.get_documents()

	log_success("Retrieved " + str(all_docs.size()) + " documents as array")

	if LOG_VERBOSE:
		for i in range(all_docs.size()):
			log_info("Document " + str(i) + " keys: " + str(all_docs[i].keys()))

func create_multi_document() -> void:
	log_info("Creating multi-document YAML from separate data structures...")

	# Create individual document data
	var user_doc = {
		"user": {
			"id": 12345,
			"name": "John Doe",
			"email": "john@example.com"
		}
	}

	var preferences_doc = {
		"preferences": {
			"theme": "dark",
			"language": "en",
			"notifications": true
		}
	}

	var session_doc = {
		"session": {
			"token": "abc123xyz",
			"expires": "2024-12-31T23:59:59Z",
			"permissions": ["read", "write"]
		}
	}

	# Convert each to YAML and combine
	var documents_yaml = []

	for doc_data in [user_doc, preferences_doc, session_doc]:
		var result = YAML.stringify(doc_data)
		if result.has_error():
			log_error("Failed to stringify document: " + result.get_error())
			return
		documents_yaml.append(result.get_data())

	# Combine with document separator
	var combined_yaml = "\n---\n".join(documents_yaml)

	log_success("Created multi-document YAML successfully")

	if LOG_VERBOSE:
		log_result(combined_yaml)

		# Verify by parsing it back
		var verify_result = YAML.parse(combined_yaml)
		if !verify_result.has_error():
			log_success("Verification: " + str(verify_result.get_document_count()) + " documents parsed")

func save_multi_document_file() -> void:
	log_info("Saving multi-document YAML to file: " + OUTPUT_FILE)

	# Create sample multi-document data
	var documents = [
		{"metadata": {"created": "2024-01-01", "version": 1}},
		{"data": {"items": [1, 2, 3], "total": 6}},
		{"summary": {"status": "complete", "processed": true}}
	]

	var yaml_parts = []
	for doc in documents:
		var result = YAML.stringify(doc)
		if result.has_error():
			log_error("Failed to stringify document: " + result.get_error())
			return
		yaml_parts.append(result.get_data())

	var multi_doc_content = "\n---\n".join(yaml_parts)

	# Save to file (note: this saves as plain text, not using YAML.save_file)
	var file = FileAccess.open(OUTPUT_FILE, FileAccess.WRITE)
	if file == null:
		log_error("Failed to open file for writing")
		return

	file.store_string(multi_doc_content)
	file.close()

	log_success("Multi-document YAML saved successfully")

	if LOG_VERBOSE:
		log_result("File content:\n" + multi_doc_content)

func load_multi_document_file() -> void:
	log_info("Loading multi-document YAML file: " + OUTPUT_FILE)

	# Check if file exists
	if !FileAccess.file_exists(OUTPUT_FILE):
		log_warning("File doesn't exist. Run 'Save Multi-Document File' first.")
		return

	var result := YAML.load_file(OUTPUT_FILE)

	if result.has_error():
		log_error("File loading failed: " + result.get_error())
		return

	log_success("Multi-document YAML file loaded successfully")

	if LOG_VERBOSE:
		var doc_count = result.get_document_count()
		log_info("Loaded " + str(doc_count) + " documents from file")

		for i in range(doc_count):
			var doc = result.get_document(i)
			log_info("Document " + str(i) + ": " + str(doc.keys()))
			log_result("  " + str(doc))

```

# res://addons/yaml/examples/example_resource_referencing.gd
```gd
extends ExampleBase

# This example requires a local texture reference
# For real use, export a texture in your scene
@export var local_texture: Texture2D

func _init() -> void:
	icon = "🔗"

func run_examples() -> void:
	run_example("Parsing Resources", parsing_resources)
	run_example("Stringifying Resources", stringifying_resources)
	run_example("Resource Security", resource_security)
	run_example("Resource Path Management", resource_path_management)

func parsing_resources() -> void:
	var yaml_text := """
scene: !Resource 'res://addons/yaml/examples/assets/simple_scene.tscn'
texture: !Resource 'res://icon.svg'
yaml: !Resource 'res://addons/yaml/examples/data/simple.yaml'
"""
	log_code_block(yaml_text)

	log_info("Parsing YAML with resource references...")
	var parse_result := YAML.parse(yaml_text)

	if parse_result.has_error():
		log_error("Parse failed: " + parse_result.get_error())
		return

	var data: Dictionary = parse_result.get_data()
	log_success("YAML with resources parsed successfully")

	if data.scene is PackedScene:
		log_success("PackedScene loaded successfully")
		var scene = data.scene.instantiate()
		scene.position = Vector2(640, 360)
		add_child(scene)
	else:
		log_warning("PackedScene not loaded (might be missing file or security restrictions)")

	if data.texture is Texture2D:
		log_success("Texture loaded successfully")
	else:
		log_warning("Texture not loaded (might be missing file or security restrictions)")

	if data.yaml is Dictionary:
		log_success("Nested YAML loaded successfully")
	else:
		log_warning("Nested YAML not loaded (might be missing file or security restrictions)")

	if LOG_VERBOSE:
		log_info("Resource types:")
		log_info("• scene type: " + str(typeof(data.scene)))
		log_info("• texture type: " + str(typeof(data.texture)))
		log_info("YAML resource:")
		log_info(str(data.yaml))

func stringifying_resources() -> void:
	log_info("Stringifying a resource...")

	var resource = load("res://icon.svg")  # Project icon should always exist
	if !resource:
		log_error("Could not load resource")
		return

	var str_result := YAML.stringify(resource)
	if str_result.has_error():
		log_error("Stringify failed: " + str_result.get_error())
		return

	log_success("Resource stringified successfully")

	if LOG_VERBOSE:
		log_result("Stringified Resource:\n" + str_result.get_data())

	# Test stringifying local resource (should fail)
	if local_texture:
		log_info("Attempting to stringify local (non-file) resource...")
		var invalid_result := YAML.stringify(local_texture)

		if invalid_result.has_error():
			log_success("Correctly failed to serialize local resource")
			log_info("Error: " + invalid_result.get_error())
		else:
			log_error("Incorrectly serialized local resource")
	else:
		log_warning("No local texture assigned, skipping local resource test")

func resource_security() -> void:
	log_info("Testing resource security...")

	var yaml_text := """
script: !Resource 'res://addons/yaml/examples/scripts/dangerous_script.gd'
"""
	log_code_block(yaml_text)

	log_info("Parsing with default security...")
	var parse_result := YAML.parse(yaml_text)

	if parse_result.has_error():
		log_success("Default security correctly blocked script resource")
		log_info("Error: " + parse_result.get_error())
	else:
		log_error("Default security failed to block script resource")

	log_info("Creating custom security with explicit type blocks...")
	var security := YAML.create_security()
	security.block_type("Script")
	security.block_type("GDExtension")
	security.allow_path("res://**", ["Texture2D", "PackedScene"])

	log_info("Same file with custom security...")
	parse_result = YAML.parse(yaml_text, security)

	if parse_result.has_error():
		log_success("Custom security correctly blocked script resource")
		log_info("Error: " + parse_result.get_error())
	else:
		log_error("Custom security failed to block script resource")

func resource_path_management() -> void:
	log_subheader("Resource Path Management")

	log_info("Using relative paths vs absolute paths:")

	var yaml_with_absolute_path := """
texture: !Resource 'res://icon.svg'
"""
	log_code_block(yaml_with_absolute_path)

	log_info("Absolute paths are fixed to specific locations")

	var yaml_with_relative_path := """
# When file is in res://addons/yaml/examples/
texture: !Resource '../../../icon.svg'
"""
	log_code_block(yaml_with_relative_path)

	log_warning("Note: Godot doesn't natively support relative paths in Resource paths")
	log_info("You need to implement custom path resolution for relative paths")

	log_info("\nSuggested best practices:")
	log_info("1. Use absolute paths (res://, user://) for resources")
	log_info("2. Keep resources in a structured directory hierarchy")
	log_info("3. Use security settings to limit resource access")
	log_info("4. For mod support, create custom path remapping in your game code")

	# Example of custom path handling
	log_info("\nExample of custom path handling:")
	var code := """
# Custom path resolver for mod resources
func resolve_mod_path(path: String, mod_id: String) -> String:
	if path.begins_with("mod://"):
		# Transform mod:// protocol to user://mods/{mod_id}/
		return path.replace("mod://", "user://mods/" + mod_id + "/")
	return path

# Example usage with YAML
func load_mod_config(mod_id: String) -> Dictionary:
	var yaml_text = FileAccess.open("user://mods/" + mod_id + "/config.yaml", FileAccess.READ).get_as_text()
	var data = YAML.parse(yaml_text).get_data()

	# Process all resource paths in the data
	for key in data:
		if data[key] is String and data[key].begins_with("mod://"):
			# Resolve the path
			data[key] = resolve_mod_path(data[key], mod_id)

	return data
"""
	log_code_block(code)

```

# res://addons/yaml/examples/example_security.gd
```gd
extends ExampleBase

func _init() -> void:
	icon = "🔒"

func run_examples() -> void:
	run_example("Default Security Behavior", default_security)
	run_example("Custom Security: Allow Path", custom_security_allow_path)
	run_example("Wildcard Path Patterns", wildcard_paths)
	run_example("Blocking Resource Types", block_type)
	run_example("Clearing Type Restrictions", clear_type_restrictions)
	run_example("Resetting Security", reset_security)
	run_example("Security Best Practices", security_best_practices)

func default_security() -> void:
	log_info("Testing default security settings...")

	# Default security should block Script and GDExtension
	var yaml_text := """
dangerous: !Resource 'res://addons/yaml/examples/classes/my_custom_class.gd'
"""
	log_code_block(yaml_text)

	var result := YAML.parse(yaml_text)

	if result.has_error():
		log_success("Default security correctly blocked Script resource")
		log_info("Error message: " + result.get_error())
		return

	log_error("Security failed to block unsafe resource")

func custom_security_allow_path() -> void:
	log_info("Creating custom security policy...")
	var security := YAML.create_security()

	# Allow only textures from a specific path
	security.allow_path("res://addons/yaml/examples/assets", ["Texture2D"])

	log_info("Testing allowed path and type...")
	var allowed_yaml := """
texture: !Resource 'res://addons/yaml/icon.svg'
"""
	log_code_block(allowed_yaml)

	var result := YAML.parse(allowed_yaml, security)
	if !result.has_error():
		log_success("Correctly allowed texture in permitted path")
	else:
		log_error("Incorrectly blocked permitted resource: " + result.get_error())

	log_info("Testing incorrect path...")
	var wrong_path_yaml := """
texture: !Resource 'res://addons/yaml/examples/wrong_path/test.png'
"""
	log_code_block(wrong_path_yaml)

	result = YAML.parse(wrong_path_yaml, security)
	if result.has_error():
		log_success("Correctly blocked resource outside allowed path")
		log_info("Error message: " + result.get_error())
	else:
		log_error("Security failed to block resource outside allowed path")

	log_info("Testing incorrect type...")
	var wrong_type_yaml := """
scene: !Resource 'res://addons/yaml/examples/assets/textures/test.tscn'
"""
	log_code_block(wrong_type_yaml)

	result = YAML.parse(wrong_type_yaml, security)
	if result.has_error():
		log_success("Correctly blocked non-texture resource")
		log_info("Error message: " + result.get_error())
	else:
		log_error("Security failed to block non-texture resource")

func wildcard_paths() -> void:
	log_info("Testing wildcard path patterns...")

	# Create security configuration
	var security := YAML.create_security()

	# Test single segment wildcard (*)
	log_info("Single segment wildcard (*) example:")
	security.allow_path("res://addons/yaml/*/assets", ["Texture2D"])

	var single_wildcard_yaml := """
texture: !Resource 'res://addons/yaml/icon.svg'
"""
	log_code_block(single_wildcard_yaml)

	var result := YAML.parse(single_wildcard_yaml, security)
	if !result.has_error():
		log_success("Single wildcard pattern matched correctly")
	else:
		log_error("Single wildcard failed: " + result.get_error())

	# Test recursive wildcard (**)
	log_info("\nRecursive wildcard (**) example:")
	security.clear_path_restrictions()
	security.allow_path("res://**", ["PackedScene"])

	var recursive_wildcard_yaml := """
scene: !Resource 'res://addons/yaml/examples/assets/simple_scene.tscn'
"""
	log_code_block(recursive_wildcard_yaml)

	result = YAML.parse(recursive_wildcard_yaml, security)
	if !result.has_error():
		log_success("Recursive wildcard pattern matched correctly")
	else:
		log_error("Recursive wildcard failed: " + result.get_error())

func block_type() -> void:
	log_info("Testing type blocking functionality...")

	var security := YAML.create_security()
	security.allow_path("res://**") # Allow all paths
	security.block_type("PackedScene") # But block all scenes

	var blocked_yaml := """
scene: !Resource 'res://addons/yaml/examples/assets/test.tscn'
"""
	log_code_block(blocked_yaml)

	var result := YAML.parse(blocked_yaml, security)
	if result.has_error():
		log_success("Correctly blocked resource of blocked type")
		log_info("Error message: " + result.get_error())
	else:
		log_error("Failed to block specified resource type")

func clear_type_restrictions() -> void:
	log_info("Testing clearing type restrictions...")

	var security := YAML.create_security()
	security.allow_path("res://**")
	security.clear_type_restrictions() # This removes default blocks on Script and GDExtension

	var script_yaml := """
script: !Resource 'res://addons/yaml/examples/classes/my_custom_class.gd'
"""
	log_code_block(script_yaml)
	log_warning("Note: Allowing scripts can be dangerous with untrusted content")

	var result := YAML.parse(script_yaml, security)
	if !result.has_error():
		log_success("Script resource allowed after clearing restrictions")
	else:
		log_error("Failed to allow script after clearing restrictions: " + result.get_error())

func reset_security() -> void:
	log_info("Testing security reset functionality...")

	var security := YAML.create_security()
	security.allow_path("res://**")
	security.clear_type_restrictions()

	log_info("Before reset: All paths allowed, all types allowed")

	security.reset() # Should revert to default security
	log_info("After reset: Default restrictions should apply")

	var script_yaml := """
script: !Resource 'res://addons/yaml/examples/assets/my_custom_class.gd'
"""
	log_code_block(script_yaml)

	var result := YAML.parse(script_yaml, security)
	if result.has_error():
		log_success("Script correctly blocked after security reset")
		log_info("Error message: " + result.get_error())
	else:
		log_error("Security reset failed to restore default restrictions")

func security_best_practices() -> void:
	log_subheader("Security Best Practices")

	log_info("1. Default security blocks Script and GDExtension resources")
	log_info("2. Only allow specific paths and types needed by your application")
	log_info("3. Use the most specific path patterns possible")
	log_info("4. For user content, create a dedicated directory and apply strict type limitations")

	log_info("\nExample for mod content security:")
	var code := """
# Create security for user mods
var mod_security = YAML.create_security()

# Only allow textures, audio, and text files
mod_security.allow_path("user://mods/**", [
	"Texture2D",
	"CompressedTexture2D",
	"AudioStreamOggVorbis",
	"AudioStreamMP3"
])

# Explicitly block potentially dangerous types
mod_security.block_type("Script")
mod_security.block_type("GDExtension")
mod_security.block_type("PackedScene")

# Use this security when loading mod content
var result = YAML.load_file("user://mods/my_mod/config.yaml", mod_security)
"""
	log_code_block(code)

```

# res://addons/yaml/examples/example_speed_benchmark.gd
```gd
extends ExampleBase

## Number of iterations for each benchmark
const ITERATIONS: int = 5

## Path to the YAML file to benchmark
const YAML_PATH: String = "res://addons/yaml/examples/data/supported_syntax.yaml"

func _init() -> void:
	icon = "⚡"

func run_examples() -> void:
	log_header("YAML Speed Benchmark")
	print(YAML.version())

	run_example("Load YAML File", load_yaml_file_benchmark)
	run_example("Parse (No Style) Benchmark", parse_benchmark)
	run_example("Parse (With Style) Benchmark", parse_with_style_benchmark)
	run_example("Stringify (No Style) Benchmark", stringify_benchmark)
	run_example("Stringify (With Style) Benchmark", stringify_with_style_benchmark)
	run_example("Compare Results", compare_results)

var yaml_input: String
var parse_times := []
var style_parse_times := []
var stringify_times := []
var style_stringify_times := []
var data = null
var style = null

func load_yaml_file_benchmark() -> void:
	log_info("Loading YAML file: " + YAML_PATH)

	var file := FileAccess.open(YAML_PATH, FileAccess.READ)
	if !file:
		log_error("Could not open file: " + YAML_PATH)
		return

	yaml_input = file.get_as_text()
	log_success("File loaded, size: " + str(yaml_input.length()) + " characters")

	if LOG_VERBOSE:
		log_result("First 200 characters:\n" + yaml_input.substr(0, 200) + "...")

func parse_benchmark() -> void:
	if yaml_input.is_empty():
		log_error("No YAML input loaded")
		return

	log_info("Running parse benchmark (" + str(ITERATIONS) + " iterations)...")

	for i in range(ITERATIONS):
		var start := Time.get_ticks_usec()
		var result = YAML.parse(yaml_input)
		var elapsed := Time.get_ticks_usec() - start

		if result.has_error():
			log_error("Iteration " + str(i + 1) + " failed: " + result.get_error())
			continue

		data = result.get_data()
		parse_times.append(elapsed)
		log_info("Iteration " + str(i + 1) + ": " + str(elapsed) + " µs")

	if parse_times.size() > 0:
		var avg = float(parse_times.reduce(func(a, b): return a + b)) / parse_times.size()
		log_success("Average parse time: " + str(avg) + " µs")
	else:
		log_error("No successful parse iterations")

func parse_with_style_benchmark() -> void:
	if yaml_input.is_empty():
		log_error("No YAML input loaded")
		return

	log_info("Running parse with style benchmark (" + str(ITERATIONS) + " iterations)...")

	for i in range(ITERATIONS):
		var start := Time.get_ticks_usec()
		var result = YAML.parse(yaml_input, YAML.create_security(), true)
		var elapsed := Time.get_ticks_usec() - start

		if result.has_error():
			log_error("Iteration " + str(i + 1) + " failed: " + result.get_error())
			continue

		if i == 0:
			style = result.get_style()

		style_parse_times.append(elapsed)
		log_info("Iteration " + str(i + 1) + ": " + str(elapsed) + " µs")

	if style_parse_times.size() > 0:
		var avg = float(style_parse_times.reduce(func(a, b): return a + b)) / style_parse_times.size()
		log_success("Average parse with style time: " + str(avg) + " µs")
	else:
		log_error("No successful parse with style iterations")

func stringify_benchmark() -> void:
	if data == null:
		log_error("No data available for stringify tests")
		return

	log_info("Running stringify benchmark (" + str(ITERATIONS) + " iterations)...")

	for i in range(ITERATIONS):
		var start := Time.get_ticks_usec()
		var result = YAML.stringify(data)
		var elapsed := Time.get_ticks_usec() - start

		if result.has_error():
			log_error("Iteration " + str(i + 1) + " failed: " + result.get_error())
			continue

		stringify_times.append(elapsed)
		log_info("Iteration " + str(i + 1) + ": " + str(elapsed) + " µs")

	if stringify_times.size() > 0:
		var avg = float(stringify_times.reduce(func(a, b): return a + b)) / stringify_times.size()
		log_success("Average stringify time: " + str(avg) + " µs")
	else:
		log_error("No successful stringify iterations")

func stringify_with_style_benchmark() -> void:
	if data == null or style == null:
		log_error("No data or style available for stringify tests")
		return

	log_info("Running stringify with style benchmark (" + str(ITERATIONS) + " iterations)...")

	for i in range(ITERATIONS):
		var start := Time.get_ticks_usec()
		var result = YAML.stringify(data, style)
		var elapsed := Time.get_ticks_usec() - start

		if result.has_error():
			log_error("Iteration " + str(i + 1) + " failed: " + result.get_error())
			continue

		style_stringify_times.append(elapsed)
		log_info("Iteration " + str(i + 1) + ": " + str(elapsed) + " µs")

	if style_stringify_times.size() > 0:
		var avg = float(style_stringify_times.reduce(func(a, b): return a + b)) / style_stringify_times.size()
		log_success("Average stringify with style time: " + str(avg) + " µs")
	else:
		log_error("No successful stringify with style iterations")

func compare_results() -> void:
	log_subheader("Performance Comparison")

	# Collect all test results
	var all_tests = [
		{
			"name": "Parse (no style)",
			"times": parse_times
		},
		{
			"name": "Parse (with style)",
			"times": style_parse_times
		},
		{
			"name": "Stringify (no style)",
			"times": stringify_times
		},
		{
			"name": "Stringify (with style)",
			"times": style_stringify_times
		}
	]

	# Calculate and print stats
	for test in all_tests:
		var times = test.times
		if times.is_empty():
			log_warning(test.name + ": No valid results")
			continue

		var avg: float = float(times.reduce(func(a, b): return a + b)) / times.size()
		var min_time: int = times.min()
		var max_time: int = times.max()

		log_info(test.name + ":")
		log_info("  Average: %.2f µs" % avg)
		log_info("  Min: %d µs" % min_time)
		log_info("  Max: %d µs" % max_time)

	log_info("\nPerformance Insights:")

	# Compare parse with and without style
	if !parse_times.is_empty() and !style_parse_times.is_empty():
		var avg_parse = float(parse_times.reduce(func(a, b): return a + b)) / parse_times.size()
		var avg_style_parse = float(style_parse_times.reduce(func(a, b): return a + b)) / style_parse_times.size()

		var style_overhead = ((avg_style_parse / avg_parse) - 1.0) * 100.0
		log_info("Style detection adds approximately %.1f%% overhead to parsing" % style_overhead)

	# Compare stringify with and without style
	if !stringify_times.is_empty() and !style_stringify_times.is_empty():
		var avg_stringify = float(stringify_times.reduce(func(a, b): return a + b)) / stringify_times.size()
		var avg_style_stringify = float(style_stringify_times.reduce(func(a, b): return a + b)) / style_stringify_times.size()

		var style_overhead = ((avg_style_stringify / avg_stringify) - 1.0) * 100.0
		log_info("Using style adds approximately %.1f%% overhead to stringify" % style_overhead)

```

# res://addons/yaml/examples/example_style_system.gd
```gd
extends ExampleBase

const YAML_FILE = "res://addons/yaml/examples/data/supported_syntax.yaml"
const STYLE_FILE = "user://supported_syntax.style.yaml"

var data
var style: YAMLStyle

func _init() -> void:
	icon = "🎨"

func run_examples() -> void:
	run_example("Style Extraction", style_extraction)
	run_example("Stringify with Style", stringify_with_style)
	run_example("Style Cloning", style_cloning)
	run_example("Style Merging", style_merging)
	run_example("Child Styles", child_styles)
	run_example("Path-based Styles", get_at_path)
	run_example("Style Propagation", propagate_scalar_styles)
	run_example("Various Style Combinations", various_style_combinations)
	run_example("Style Serialization", to_from_dictionary)

func style_extraction() -> void:
	log_info("Loading YAML file with style detection...")

	var result = YAML.load_file(YAML_FILE, null, true)
	if result.has_error():
		log_error("Failed to load file: " + result.get_error())
		return

	data = result.get_data()
	style = result.get_style()

	if !style:
		log_error("Could not extract style")
		return

	log_success("Style extracted successfully")

	if LOG_VERBOSE:
		log_result("Extracted Styles:\n" + style.get_debug_string())

	log_info("Saving style to file: " + STYLE_FILE)
	var save_result = style.save_file(STYLE_FILE)

	if save_result.has_error():
		log_error("Failed to save style: " + save_result.get_error())
		return

	log_success("Style saved to file")

func stringify_with_style() -> void:
	log_info("Loading style from file...")

	var load_result = YAMLStyle.load_file(STYLE_FILE)
	if load_result.has_error():
		log_error("Failed to load style: " + load_result.get_error())
		return

	var load_style = load_result.get_style()

	if style && load_style.hash() == style.hash():
		log_success("Loaded style matches the original style")
	else:
		log_warning("Loaded style does not match the original style")

	if data == null:
		data = {"test": "value"}

	log_info("Stringifying data with loaded style...")
	var stringify_result = YAML.stringify(data, load_style)

	if stringify_result.has_error():
		log_error("Stringify failed: " + stringify_result.get_error())
		return

	log_success("Data stringified with style")

	if LOG_VERBOSE:
		log_result("Styled YAML output:\n" + stringify_result.get_data())

func style_cloning() -> void:
	log_info("Creating and configuring base style...")

	var style := YAML.create_style()
	style.set_string_style(YAMLStyle.STRING_QUOTE_DOUBLE)
	style.set_flow_style(YAMLStyle.FLOW_NONE)

	log_info("Cloning style...")
	var cloned_style := style.clone()

	if style.get_string_style() == cloned_style.get_string_style() && \
	   style.get_flow_style() == cloned_style.get_flow_style():
		log_success("Cloned style has same properties as original")
	else:
		log_error("Cloned style properties don't match original")

	log_info("Modifying the cloned style...")
	cloned_style.set_string_style(YAMLStyle.STRING_QUOTE_SINGLE)

	if style.get_string_style() != cloned_style.get_string_style():
		log_success("Modifying clone doesn't affect original")
	else:
		log_error("Modifying clone affected original")

	if LOG_VERBOSE:
		var test_data = {"message": "Hello, World!"}

		var orig_result = YAML.stringify(test_data, style)
		var clone_result = YAML.stringify(test_data, cloned_style)

		log_result("Original style output:\n" + orig_result.get_data())
		log_result("Cloned style output:\n" + clone_result.get_data())

func style_merging() -> void:
	log_info("Creating two different styles...")

	var style1 := YAML.create_style()
	style1.set_string_style(YAMLStyle.STRING_QUOTE_DOUBLE)

	var style2 := YAML.create_style()
	style2.set_flow_style(YAMLStyle.FLOW_SINGLE)

	log_info("Merging style2 into style1...")
	style1.merge_with(style2)

	if style1.get_string_style() == YAMLStyle.STRING_QUOTE_DOUBLE:
		log_success("Original style properties preserved")
	else:
		log_error("Original style properties were lost")

	if style1.get_flow_style() == YAMLStyle.FLOW_SINGLE:
		log_success("Properties from merged style were added")
	else:
		log_error("Properties from merged style were not added")

	if LOG_VERBOSE:
		var test_data = {
			"message": "Hello, World!",
			"items": ["one", "two", "three"]
		}

		var result = YAML.stringify(test_data, style1)
		log_result("Merged style output:\n" + result.get_data())

func child_styles() -> void:
	log_info("Creating parent style with child styles...")

	var style := YAML.create_style()
	style.set_string_style(YAMLStyle.STRING_QUOTE_DOUBLE)

	log_info("Creating child style for 'list' key...")
	var list_style := style.create_child("list")
	list_style.set_flow_style(YAMLStyle.FLOW_SINGLE)

	if style.get_child("list") == list_style:
		log_success("get_child() retrieves the correct child style")
	else:
		log_error("get_child() failed to retrieve the correct child style")

	if style.has_child("list"):
		log_success("has_child() correctly identifies existing child")
	else:
		log_error("has_child() failed to identify existing child")

	var child_keys := style.list_children()
	if child_keys.has("list"):
		log_success("list_children() includes the child key")
	else:
		log_error("list_children() failed to include the child key")

	if LOG_VERBOSE:
		var test_data = {
			"name": "Example",
			"list": ["one", "two", "three"]
		}

		var result = YAML.stringify(test_data, style)
		log_result("Output with child styles:\n" + result.get_data())

func get_at_path() -> void:
	log_info("Creating nested style structure...")

	var style := YAML.create_style()

	# Create a nested style structure
	var maps_style := style.create_child("maps")
	var items_style := maps_style.create_child("items")
	var first_item_style := items_style.create_child("0")
	first_item_style.set_string_style(YAMLStyle.STRING_LITERAL)

	log_info("Getting style at path 'maps/items/0'...")
	var path_style := style.get_at_path("maps/items/0")

	if path_style && path_style.get_string_style() == YAMLStyle.STRING_LITERAL:
		log_success("get_at_path() correctly retrieved the style")
	else:
		log_error("get_at_path() failed to retrieve the correct style")

	log_info("Creating missing path 'maps/items/1/properties'...")
	var new_path_style := style.get_at_path("maps/items/1/properties", true)

	if new_path_style != null:
		log_success("Successfully created missing path nodes")
	else:
		log_error("Failed to create missing path nodes")

	log_info("Getting non-existent path without creating...")
	var missing_style := style.get_at_path("non/existent/path", false)

	if missing_style == null:
		log_success("Correctly returned null for non-existent path")
	else:
		log_error("Incorrectly returned non-null for non-existent path")

	if LOG_VERBOSE:
		var test_data = {
			"maps": {
				"items": [
					{"name": "Item 1", "description": "Line 1\nLine 2\nLine 3"},
					{"name": "Item 2", "properties": {"a": 1, "b": 2}}
				]
			}
		}

		var result = YAML.stringify(test_data, style)
		log_result("Output with path-based styles:\n" + result.get_data())

func propagate_scalar_styles() -> void:
	log_info("Creating parent style with scalar formats...")

	var parent_style := YAML.create_style()
	parent_style.set_string_style(YAMLStyle.STRING_QUOTE_DOUBLE)
	parent_style.set_integer_format(YAMLStyle.INT_HEX)
	parent_style.set_float_format(YAMLStyle.FLOAT_SCIENTIFIC)

	log_info("Creating child style and propagating scalar styles...")
	var child_style := YAML.create_style()
	parent_style.propagate_scalar_styles(child_style)

	if child_style.get_string_style() == YAMLStyle.STRING_QUOTE_DOUBLE:
		log_success("String style was propagated")
	else:
		log_error("String style was not propagated")

	if child_style.get_integer_format() == YAMLStyle.INT_HEX:
		log_success("Integer format was propagated")
	else:
		log_error("Integer format was not propagated")

	if child_style.get_float_format() == YAMLStyle.FLOAT_SCIENTIFIC:
		log_success("Float format was propagated")
	else:
		log_error("Float format was not propagated")

	if LOG_VERBOSE:
		var test_data = {
			"text": "Hello, World!",
			"number": 255,
			"decimal": 3.14159
		}

		var result = YAML.stringify(test_data, child_style)
		log_result("Output with propagated styles:\n" + result.get_data())

func various_style_combinations() -> void:
	log_info("Creating data with various types...")

	var data := {
		"string_value": "Test string with \"quotes\" and newlines\nto test",
		"int_value": 255,
		"float_value": 3.14159,
		"list": ["item1", "item2", "item3"],
		"dict": {"key1": "val1", "key2": "val2"}
	}

	log_info("Creating style with various formatting options...")
	var style := YAML.create_style()
	style.set_string_style(YAMLStyle.STRING_LITERAL)
	style.set_integer_format(YAMLStyle.INT_HEX)
	style.set_float_format(YAMLStyle.FLOAT_SCIENTIFIC)

	# List should be compact
	var list_style := style.create_child("list")
	list_style.set_flow_style(YAMLStyle.FLOW_SINGLE)

	# Dict should be expanded
	var dict_style := style.create_child("dict")
	dict_style.set_flow_style(YAMLStyle.FLOW_NONE)

	log_info("Stringifying with custom styles...")
	var result := YAML.stringify(data, style)

	if result.has_error():
		log_error("Stringify failed: " + result.get_error())
		return

	log_success("Data stringified with custom styles")

	if LOG_VERBOSE:
		log_result("Styled YAML output:\n" + result.get_data())

	log_info("Parsing styled output with style detection...")
	var parse_result := YAML.parse(result.get_data(), null, true)

	if parse_result.has_error():
		log_error("Parse failed: " + parse_result.get_error())
		return

	var detected_style := parse_result.get_style()

	if detected_style != null:
		log_success("Style was detected during parsing")

		if LOG_VERBOSE:
			log_result("Detected Style Tree:\n" + detected_style.get_debug_string())
	else:
		log_error("Style was not detected during parsing")

func to_from_dictionary() -> void:
	log_info("Creating style for serialization...")

	var style := YAML.create_style()
	style.set_string_style(YAMLStyle.STRING_QUOTE_DOUBLE)

	var child := style.create_child("child")
	child.set_flow_style(YAMLStyle.FLOW_SINGLE)

	log_info("Converting style to dictionary...")
	var dict := style.to_dictionary()

	if dict.has("string") && dict.has("children"):
		log_success("Dictionary contains style properties and children")
	else:
		log_error("Dictionary missing expected keys")

	log_info("Rebuilding style from dictionary...")
	var rebuilt_style := YAMLStyle.from_dictionary(dict)

	if rebuilt_style.get_string_style() == YAMLStyle.STRING_QUOTE_DOUBLE:
		log_success("Rebuilt style maintained properties")
	else:
		log_error("Rebuilt style lost properties")

	if rebuilt_style.has_child("child"):
		log_success("Rebuilt style maintains children")
	else:
		log_error("Rebuilt style lost children")

	var rebuilt_hash := rebuilt_style.hash()
	var original_hash := style.hash()

	if rebuilt_hash == original_hash:
		log_success("Style hashes match")
	else:
		log_error("Style hashes don't match")

	if LOG_VERBOSE:
		log_result("Style dictionary:\n" + str(dict))

```

# res://addons/yaml/examples/example_validation.gd
```gd
extends ExampleBase

var schema: Schema

func _init() -> void:
	icon = "🛡️"

func run_examples() -> void:
	run_example("Load YAML Schema", load_yaml_schema)
	run_example("Validate Using Schema", validate_using_schema)
	run_example("Validate While Parsing", validate_while_parsing)
	run_example("Validate With Defaults", validate_with_defaults)

func load_yaml_schema() -> void:
	var yaml_schema_text = """
# The $id string is used as an identifier
$id: "http://example.com/user.yaml"

# Definitions
$defs:
  settings:
	type: object
	properties:
	  theme:
		type: string
		default: dark

type: object
properties:
  username:
	type: string
	minLength: 3
	maxLength: 20
  email:
	type: string
	format: email
  role:
	type: string
	default: user
	x-yaml-tag: UserRole
  settings:
	$ref: "#/$defs/settings"
required:
- username
- email
""".replace("\t", "    ")

	schema = YAML.load_schema_from_string(yaml_schema_text)
	if !schema:
		log_error("Schema failed to load!")
	else:
		log_success("Schema '%s' loaded" % schema.get_schema_definition().get("$id"))

func validate_using_schema() -> void:
	# Validate using the Schema object
	log_subheader("Successful validation")
	var result := schema.validate({
		"username": "alice",
		"email": "alice@example.com"
	})
	if result.is_valid():
		log_success(result.get_summary())
	else:
		log_error(result.get_summary())

	log_subheader("Failed validation")
	result = schema.validate({
		"username": "alice",
		"email": "invalid email"
	})
	if !result.is_valid():
		log_success(result.get_summary())
	else:
		log_error(result.get_summary())

func validate_while_parsing() -> void:
	# YAML tag validation
	var tagged_yaml = """
username: bob
email: bob@example.com
role: !UserRole admin
settings:
  theme: white
"""
	# Parse and validate using Schema $id property
	var result := YAML.parse_and_validate(tagged_yaml, "http://example.com/user.yaml")
	if result.has_validation_errors():
		log_error(result.get_validation_summary())
		return

	log_success(result.get_data())

func validate_with_defaults() -> void:
	# Default values
	var yaml_str = """
$schema: "http://example.com/user.yaml" # This refers to the $id
username: alice
email: alice@example.com
settings: {} # Empty dictionary is required to set default values
"""
	# Parse and validate using YAML $schema property
	var result := YAML.parse_and_validate(yaml_str)
	if result.has_validation_errors():
		log_error(result.get_validation_summary())
		return

	log_success(result.get_data())

```

# res://addons/yaml/examples/example_variants.gd
```gd
extends ExampleBase

const EPSILON := 0.000001  # Tolerance for floating point comparisons

func _init() -> void:
	icon = "🧩"

func run_examples():
	var variants := get_variant_dict()

	# Test each type individually
	for key in variants:
		run_example(key, func(): run_variant_conversion(key, variants[key]))

	# Test full dictionary conversion
	print_rich("\n[b]Testing Full Dictionary Conversion:[/b]")
	var yaml_result := YAML.stringify(variants)
	if yaml_result.has_error():
		print_rich("[color=red]Dictionary stringify failed: %s[/color]" % yaml_result.get_error())
		return

	var yaml_text = yaml_result.get_data()
	var parse_result := YAML.parse(yaml_text)
	if parse_result.has_error():
		print_rich("[color=red]Dictionary parse failed: %s[/color]" % parse_result.get_error())
		return

	var decoded = parse_result.get_data()
	var all_passed := true
	for key in variants:
		if !is_approximately_equal(variants[key], decoded[key]):
			print_rich("[color=red]Dictionary value mismatch for %s:[/color]" % key)
			print_rich("  Expected: %s" % variants[key])
			print_rich("  Got: %s" % decoded[key])
			all_passed = false

	if all_passed:
		print_rich("[color=green]✓ All variant type conversions passed![/color]")

func run_variant_conversion(type_name: String, value: Variant) -> void:
	print_rich("\n[b]Testing %s:[/b]" % type_name)
	print_rich("[i]Original:[/i] %s" % str(value))

	# Test stringification
	var yaml_result := YAML.stringify(value)
	if yaml_result.has_error():
		print_rich("[color=red]Stringify failed: %s[/color]" % yaml_result.get_error())
		return

	var yaml = yaml_result.get_data()
	print_rich("[i]As YAML:[/i]\n%s" % yaml)

	# Test parsing
	var parse_result := YAML.parse(yaml)
	if parse_result.has_error():
		print_rich("[color=red]Parse failed: %s[/color]" % parse_result.get_error())
		return

	var decoded = parse_result.get_data()
	print_rich("[i]Decoded:[/i] %s" % str(decoded))

	# Verify value equality
	if !is_approximately_equal(value, decoded):
		print_rich("[color=red]Value mismatch:[/color]")
		print_rich("  Expected: %s" % str(value))
		print_rich("  Got: %s" % decoded)
	else:
		print_rich("[color=green]✓ Values match[/color]")

func is_approximately_equal(a: Variant, b: Variant) -> bool:
	if typeof(b) == TYPE_STRING:
		return str(a) == b
	match typeof(a):
		TYPE_STRING, TYPE_STRING_NAME:
			return a == b
		TYPE_FLOAT:
			return abs(a - b) < EPSILON
		TYPE_VECTOR2, TYPE_VECTOR3, TYPE_VECTOR4:
			return a.is_equal_approx(b)
		TYPE_ARRAY, TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_FLOAT64_ARRAY:
			if a.size() != b.size():
				return false
			for i in a.size():
				if not is_approximately_equal(a[i], b[i]):
					return false
			return true
		TYPE_QUATERNION, TYPE_BASIS, TYPE_TRANSFORM2D, TYPE_TRANSFORM3D:
			return a.is_equal_approx(b)
		TYPE_COLOR:
			var va = Vector4(a.r, a.g, a.b, a.a)
			var vb = Vector4(b.r, b.g, b.b, b.a)
			var dist = (va - vb).length()
			return dist < 0.01
		TYPE_DICTIONARY:
			if a.size() != b.size():
				return false
			for key in a:
				if not b.has(key) or not is_approximately_equal(a[key], b[key]):
					return false
			return true
		_:
			return a == b

func get_variant_dict() -> Dictionary:
	return {
		# Vector types
		"Vector2": Vector2(1, 2),
		"Vector2i": Vector2i(2, 4),
		"Vector3": Vector3(1, 2, 4),
		"Vector3i": Vector3i(2, 4, 8),
		"Vector4": Vector4(1, 2, 4, 8),
		"Vector4i": Vector4i(2, 4, 8, 16),

		# Geometric types
		"AABB": AABB(Vector3(1, 2, 4), Vector3(8, 16, 32)),
		"Basis": Basis(Vector3(1, 2, 4), Vector3(8, 16, 32), Vector3(64, 128, 256)),
		"Plane": Plane(Vector3(1, 2, 4), PI),
		"Quaternion": Quaternion(PI, 2*PI, 4*PI, 8*PI),
		"Rect2": Rect2(1, 2, 4, 8),
		"Rect2i": Rect2i(2, 4, 8, 16),
		"Transform2D": Transform2D(PI, Vector2(2*PI, 4*PI)),
		"Transform3D": Transform3D(Basis(), Vector3(1, 2, 4)),

		# Color types
		"Color": Color(1.0, 0.5, 0.25, 1.0),

		# Array types
		"PackedByteArray": PackedByteArray([1, 2, 4, 8]),
		"PackedColorArray": PackedColorArray([
			Color(1, 0, 0),
			Color(0, 1, 0),
			Color(0, 0, 1)
		]),
		"PackedFloat32Array": PackedFloat32Array([PI, 2*PI, 4*PI]),
		"PackedFloat64Array": PackedFloat64Array([PI, 2*PI, 4*PI]),
		"PackedInt32Array": PackedInt32Array([1, 2, 4, 8]),
		"PackedInt64Array": PackedInt64Array([1, 2, 4, 8]),
		"PackedStringArray": PackedStringArray([
			"one",
			"one\ntwo",
			"one\ntwo\nthree"
		]),
		"PackedVector2Array": PackedVector2Array([
			Vector2(1, 2),
			Vector2(4, 8)
		]),
		"PackedVector3Array": PackedVector3Array([
			Vector3(1, 2, 4),
			Vector3(8, 16, 32)
		]),

		# Matrix type
		"Projection": Projection(
			Vector4(1, 2, 4, 8),
			Vector4(16, 32, 64, 128),
			Vector4(256, 512, 1024, 2048),
			Vector4(4096, 8192, 16384, 32768)
		),

		# Reference types
		"NodePath": NodePath("root/level/player"),
		"StringName": &"test_string_name",
	}

```

# res://addons/yaml/plugin.gd
```gd
@tool
extends EditorPlugin

const YAMLEditorPanel = preload("res://addons/yaml/editor/yaml_editor.tscn")
const ShortcutsClass = preload("res://addons/yaml/editor/editor_shortcuts.gd")

var yaml_editor_instance
var resource_loader: YAMLResourceFormat.Loader
var resource_saver: YAMLResourceFormat.Saver

# Store original editor settings to restore on exit
var previous_textfile_extensions: String

var engine_version_info := Engine.get_version_info()

func _enter_tree() -> void:
	# Modify editor settings to remove YAML from text files
	_modify_file_extensions()

	# Create and register resource format handlers
	resource_loader = YAMLResourceFormat.Loader.new()
	resource_saver = YAMLResourceFormat.Saver.new()

	ResourceLoader.add_resource_format_loader(resource_loader, true)
	ResourceSaver.add_resource_format_saver(resource_saver, true)

	# YAMLResource for Godot 4.4 and above
	if engine_version_info.major == 4 and engine_version_info.minor >= 4:
		add_custom_type(
			"YAMLResource", "Resource",
			load("res://addons/yaml/yaml_resource.gd"),
			_get_plugin_icon()
		)

	# Initialize YAMLFileSystem singleton and pass editor interface
	var file_system = YAMLFileSystem.get_singleton()
	file_system.set_editor_interface(get_editor_interface())

	# Create the instance
	yaml_editor_instance = YAMLEditorPanel.instantiate()

	# Pass the editor interface reference to the editor
	yaml_editor_instance.editor = get_editor_interface()

	# Add to the main screen
	get_editor_interface().get_editor_main_screen().add_child(yaml_editor_instance)

	# Register keyboard shortcuts
	ShortcutsClass.register_shortcuts(self, yaml_editor_instance)

	# Hide initially - this is very important
	_make_visible(false)

	# Connect file system signals to detect file moves/renames
	get_editor_interface().get_resource_filesystem().resources_reimported.connect(_on_resources_reimported)
	get_editor_interface().get_resource_filesystem().filesystem_changed.connect(_on_filesystem_changed)

func _exit_tree() -> void:
	# Restore original editor settings
	_restore_file_extensions()

	ResourceLoader.remove_resource_format_loader(resource_loader)
	ResourceSaver.remove_resource_format_saver(resource_saver)

	# YAMLResource for Godot 4.4 and above
	if engine_version_info.major == 4 and engine_version_info.minor >= 4:
		remove_custom_type("YAMLResource")

	# Unregister shortcuts
	ShortcutsClass.unregister_shortcuts()

	# Clean up
	if yaml_editor_instance:
		# Save the current session before closing
		if yaml_editor_instance.session_manager:
			yaml_editor_instance.session_manager.save_session()
		yaml_editor_instance.queue_free()

	# Clean up other resources
	get_editor_interface().get_resource_filesystem().resources_reimported.disconnect(_on_resources_reimported)
	get_editor_interface().get_resource_filesystem().filesystem_changed.disconnect(_on_filesystem_changed)

func _modify_file_extensions() -> void:
	var editor_settings: EditorSettings = get_editor_interface().get_editor_settings()

	# Store original settings
	previous_textfile_extensions = editor_settings.get_setting("docks/filesystem/textfile_extensions")

	# Remove yaml/yml from text files (so Script Editor ignores them)
	var new_textfiles = previous_textfile_extensions.replace(",yaml", "").replace(",yml", "").replace("yaml,", "").replace("yml,", "")
	editor_settings.set_setting("docks/filesystem/textfile_extensions", new_textfiles)

func _restore_file_extensions() -> void:
	if previous_textfile_extensions.is_empty():
		return

	var editor_settings: EditorSettings = get_editor_interface().get_editor_settings()
	editor_settings.set_setting("docks/filesystem/textfile_extensions", previous_textfile_extensions)

func _on_filesystem_changed() -> void:
	# Notify the YAML editor that the filesystem has changed
	if yaml_editor_instance and is_instance_valid(yaml_editor_instance):
		yaml_editor_instance.handle_filesystem_change()

func _on_resources_reimported(resources: PackedStringArray) -> void:
	# Check if any of our open YAML files were reimported
	if yaml_editor_instance and is_instance_valid(yaml_editor_instance):
		var file_system = YAMLFileSystem.get_singleton()
		for path in resources:
			if file_system.is_yaml_file(path):
				# Notify the file system singleton about the update
				file_system.notify_file_updated(path)

func _has_main_screen() -> bool:
	return true

func _make_visible(visible: bool) -> void:
	if yaml_editor_instance:
		yaml_editor_instance.visible = visible

		# Focus the code editor when becoming visible
		if visible and is_instance_valid(yaml_editor_instance.code_edit):
			yaml_editor_instance.code_edit.grab_focus()

func _handles(object) -> bool:
	# Handle YAMLResource (from our resource loader)
	if object is YAMLResource:
		return true

	# Handle Resource objects that are YAML files
	if object is Resource and YAMLFileSystem.get_singleton().is_yaml_file(object.resource_path):
		return true

	# Also check for file paths directly
	if object is String and YAMLFileSystem.get_singleton().is_yaml_file(object):
		return true

	return false

func _edit(object) -> void:
	if object and yaml_editor_instance:
		var file_path: String

		# Handle different object types
		if object is YAMLResource:
			file_path = object.resource_path
		elif object is Resource:
			file_path = object.resource_path
		elif object is String:
			file_path = object
		else:
			return

		# Check if file is already open before trying to open it
		if yaml_editor_instance.file_manager.has_document(file_path):
			# File is already open, just switch to it
			var document = yaml_editor_instance.file_manager.get_document(file_path)
			yaml_editor_instance.file_manager.set_current_document(document)
		else:
			# File is not open, open it normally
			yaml_editor_instance.file_manager.open_file(file_path)

		_make_visible(true)

func _get_plugin_name() -> String:
	return "YAML"

func get_plugin_path() -> String:
	return get_script().resource_path.get_base_dir()

func _get_plugin_icon() -> Texture2D:
	return load(get_plugin_path() + "/icon.svg")

```

# res://addons/yaml/yaml_resource.gd
```gd
@tool
@icon("res://addons/yaml/icon.svg")

class_name YAMLResource extends Resource
# This is a lightweight wrapper around YAML text files
# It doesn't process the YAML content, just holds the raw text

var text_content: String = ""
var file_path: String = ""

func _init(path: String = "", content: String = "") -> void:
	file_path = path
	text_content = content
	if not path.is_empty():
		resource_path = path

func get_text() -> String:
	return text_content

func set_text(new_text: String) -> void:
	text_content = new_text
	emit_changed()

func get_file_path() -> String:
	return file_path

func load_from_file() -> Error:
	if file_path.is_empty():
		return ERR_FILE_NOT_FOUND

	var file := FileAccess.open(file_path, FileAccess.READ)
	if not file:
		return FileAccess.get_open_error()

	text_content = file.get_as_text()
	file.close()
	return OK

func save_to_file() -> Error:
	if file_path.is_empty():
		return ERR_FILE_NOT_FOUND

	var file := FileAccess.open(file_path, FileAccess.WRITE)
	if not file:
		return FileAccess.get_open_error()

	file.store_string(text_content)
	file.close()
	return OK

func serialize() -> Variant:
	push_error("Child of YAMLResource needs to override serialize")
	return null

static func deserialize(data: Variant) -> Variant:
	push_error("Child of YAMLResource needs to override deserialize")
	return null

```

# res://addons/yaml/yaml_resource_format.gd
```gd
@tool
class_name YAMLResourceFormat extends RefCounted

# ResourceFormatLoader for YAML files
class Loader extends ResourceFormatLoader:
	func _get_recognized_extensions() -> PackedStringArray:
		return PackedStringArray(["yaml", "yml"])

	func _get_resource_type(path: String) -> String:
		var ext := path.get_extension().to_lower()
		if YAMLFileSystem.get_singleton().is_yaml_file(path):
			return "YAMLResource"
		return ""

	func _handles_type(type: StringName) -> bool:
		return type == &"YAMLResource"

	func _load(path: String, original_path: String, use_sub_threads: bool, cache_mode: int) -> Variant:
		# Create a lightweight wrapper resource
		var yaml_resource := YAMLResource.new(path)

		# Load the text content
		var error := yaml_resource.load_from_file()
		if error != OK:
			return error

		# Set the resource path so Godot knows where it came from
		yaml_resource.resource_path = path

		return yaml_resource

# ResourceFormatSaver for YAML files
class Saver extends ResourceFormatSaver:
	func _get_recognized_extensions(resource: Resource) -> PackedStringArray:
		if resource is YAMLResource:
			return PackedStringArray(["yaml", "yml"])
		return PackedStringArray()

	func _recognize(resource: Resource) -> bool:
		return resource is YAMLResource

	func _save(resource: Resource, path: String, flags: int) -> Error:
		if not resource is YAMLResource:
			return ERR_INVALID_PARAMETER

		var yaml_resource := resource as YAMLResource

		# Update the file path if it's different
		if yaml_resource.file_path != path:
			yaml_resource.file_path = path
			yaml_resource.resource_path = path

		# Save the text content to file
		return yaml_resource.save_to_file()

```

# res://assets/ai/tasks/choose_random_position.gd
```gd
extends BTAction

func _tick(_delta: float) -> Status:
	var pos: Vector3 = agent.global_position
	pos.x += randf_range(-1.0, 1.0)
	pos.z += randf_range(-1.0, 1.0)
	blackboard.set_var(&"position", pos)
	return SUCCESS

```

# res://assets/ai/tasks/flee.gd
```gd
extends BTAction

func _tick(delta: float) -> Status:
	agent.flee(delta)
	return SUCCESS

```

# res://assets/ai/tasks/move_to_position.gd
```gd
extends BTAction

func _tick(delta: float) -> Status:
	var target: Vector3 = blackboard.get_var(&"position", Vector3.ZERO)
	if agent.move(target, delta):
		return RUNNING
	return SUCCESS

```

# res://scenes/widgits/awards.gd
```gd
extends Node

```

# res://scenes/widgits/caption.gd
```gd
@tool
extends Widget

@export var text: String: set=set_text

func set_text(t: String):
	%label.text = t

func _cinematic_step(gen: FlowPlayerGenerator, step: Dictionary):
	var speaker := ""
	var caption := ""
	match step.type:
		FlowToken.KEYV:
			speaker = step.key
			caption = step.val
		FlowToken.TEXT:
			caption = step.text
		
	if speaker:
		caption = "%s: %s" % [speaker, caption]
	else:
		caption = caption
	
	var caption_count: int = gen.get_state(&"caption_count", 0)
	gen.set_state(&"caption_count", caption_count + 1)
	var t_visible := gen.add_track(self, "visible")
	var t_text := gen.add_track(self, "text")
	if caption_count == 0:
		gen.add_key(t_text, 0, "")
	gen.add_key(t_visible, gen.get_time(), true)
	gen.add_key(t_text, gen.get_time(), caption)
	gen.add_checkpoint()
	gen.add_time(0.05)
	gen.add_key(t_visible, gen.get_time(), false)

```

# res://scenes/widgits/context_menu.gd
```gd
extends Widget

@onready var button_parent: VBoxContainer = %button_parent
@onready var button_prefab: Button = %button_prefab
@onready var blur: ColorRect = %blur
@onready var panel: PanelContainer = %panel

var options: Array[Dictionary]
var hovered: Node
var buttons: Array[Button]

var _tween: Tween

func _ready() -> void:
	button_parent.remove_child(button_prefab)
	
	blur.modulate.a = 0.0
	_tween = create_tween()
	_tween.tween_property(blur, "modulate:a", 1.0, 0.2)
	
	if hovered:
		var vpsize := Global.view_size
		if hovered is Control:
			var rect := (hovered as Control).get_global_rect()
			ShadMat.new(blur, {
				start=rect.position / vpsize,
				end=rect.end / vpsize
			})
		else:
			ShadMat.new(blur, { start=Vector2.ONE, end=Vector2.ONE })
	
	var index := 0
	for op in options:
		var btn := button_prefab.duplicate()
		button_parent.add_child(btn)
		btn.text = op.get("text", "NO_TEXT")
		btn.pressed.connect(_pressed_option.bind(index))
		index += 1
	
	panel.position = get_viewport().get_mouse_position()

func is_pauser() -> bool:
	return true

func _pressed():
	for button in buttons:
		button.disabled = true
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.tween_property(blur, "modulate:a", 0.0, 0.1)
	#_tween.tween_callback(close)

func _pressed_option(index: int):
	_pressed()
	var op := options[index]
	op.call.call()

```

# res://scenes/widgits/interaction_label.gd
```gd
extends Widget

@onready var label: RichTextLabel = %label
var agent: Agent
var interactive: Interactive

func _ready() -> void:
	set_visible(false)
	set_process(false)

func set_agent(ag: Agent):
	agent = ag
	agent.interactive_changed.connect(_interactive_changed)

func _interactive_changed():
	var inter := agent._interactive
	if inter:
		set_process(true)
		label.text = inter.label
		modulate.a = 0.0
		visible = true
		interactive = inter
		UTween.parallel(self, { "modulate:a": 1.0 }, 0.2)
	else:
		UTween.parallel(self, { "modulate:a": 0.0 }, 0.2)\
			.finished.connect(func():
				visible = false
				interactive = null
				set_process(false))

func _process(_delta: float) -> void:
	if not interactive: return
	var vp := Controllers.player.viewport
	var cam := vp.get_camera_3d()
	var pos_3d := interactive.global_position + interactive.label_world_space_offset
	var pos := cam.unproject_position(pos_3d)
	pos -= size * .5
	pos.x = clampf(pos.x, 0.0, vp.size.x)
	pos.y = clampf(pos.y, 0.0, vp.size.y)
	position = pos
	

```

# res://scenes/widgits/inventory.gd
```gd
extends Widget

@onready var slot_parent: Control = %slots
@onready var slot_prefab: Control = %slot_prefab

func _ready() -> void:
	slot_parent.remove_child(slot_prefab)
	
	await get_tree().process_frame
	
	var inv := Inventory.new()
	inv.gain_everything()
	
	for item: InventoryItem in inv:
		var btn: Control = slot_prefab.duplicate()
		btn.name = item.item
		btn.get_node("%label").text = item.item
		slot_parent.add_child(btn)
		
	slot_parent.selected.connect(_selected)
	
	if slot_parent.get_child_count() > 0:
		(slot_parent.get_child(0) as Control).grab_focus.call_deferred()

func _selected(node: Node):
	print(node)
	Global.wait(1.5, get_tree().quit)

```

# res://scenes/widgits/main_menu.gd
```gd
extends Node

func _ready() -> void:
	for button in Overrides.main_menu_options:
		var btn := Button.new()
		btn.name = button.id
		btn.text = button.text
		if &"pressed" in button:
			btn.pressed.connect(button.pressed)
		%buttons.add_child(btn)

```

# res://scenes/widgits/menu_choice.gd
```gd
@tool
class_name MenuChoiceButton extends TweeButton

@export var choice: Dictionary: set=set_choice

func set_choice(c):
	choice = c
	%label.text = choice.get(&"text", "NO_TEXT")
	if &"icon" in choice:
		pass
	
	var btn := as_button()
	btn.size = %margin.size
	btn.pivot_offset = btn.size * .5

```

# res://scenes/widgits/menu_widget.gd
```gd
@tool
class_name MenuWidget extends Widget

signal selected(choice: Dictionary)
signal selected_index(index: int)

@export var choices: Array: set=set_choices

func get_choice_prefab() -> PackedScene:
	return preload("uid://bl1wu7da5ih3s")

func set_choices(c: Array) -> void:
	var buttons: TweeButtonList = %choice_parent
	buttons.clear()
	
	choices = c
	
	var index := 0
	var choice_prefab := get_choice_prefab()
	for choice in choices:
		var node := choice_prefab.instantiate()
		buttons.add_child(node)
		node.name = "choice_%s" % index
		node.choice = choice
		index += 1

func select() -> void:
	var buttons: TweeButtonList = %choice_parent
	if buttons.select():
		print("closing")
		selected.emit(choices[buttons.hovered])
		selected_index.emit(buttons.hovered)
		Global.wait(0.5, close)

func _cinematic_step(gen: FlowPlayerGenerator, step: Dictionary) -> void:
	var menu_choices: Array[Dictionary]
	for substep in step.tabbed:
		if "tabbed" in substep:
			menu_choices.append({
				"text": substep.text,
				"anim": gen.add_branch_queued(substep.tabbed) })
	
	var count: int = gen.get_state(&"menu_count", 0)
	gen.set_state(&"menu_count", count + 1)
	
	var t_choices := gen.add_track(self, "choices")
	var t_visible := gen.add_track(self, "visible")
	# Start hidden.
	if count == 0:
		gen.add_key(t_visible, 0.0, false)
	gen.add_key(t_visible, gen.get_time(), true)
	gen.add_key(t_choices, gen.get_time(), menu_choices)
	gen.add_checkpoint()
	gen.add_time()
	gen.add_key(t_visible, gen.get_time(), false)

```

# res://scenes/widgits/quest_log.gd
```gd
extends Widget

@onready var quest_list_parent: Container = %quest_list_parent
@onready var quest_list_prefab: VBoxContainer = %quest_list_prefab
@onready var quest_button_prefab: Container = %quest_button_prefab
@onready var quest_info: RichTextLabel = %quest_info
@onready var tick_prefab: Control = %tick_prefab
@onready var tick_parent: Control = %tick_parent
var quest: QuestInfo

func _ready() -> void:
	quest_button_prefab.get_parent().remove_child(quest_button_prefab)
	quest_list_parent.remove_child(quest_list_prefab)
	tick_parent.remove_child(tick_prefab)
	
	await get_tree().process_frame
	
	for q: QuestInfo in State.quests:
		q.changed.connect(_refresh)
		for tick_id in q.ticks:
			q.ticks[tick_id].changed.connect(_refresh)
	
	_refresh()
	_select_quest(State.quests._objects.values()[0])

func is_pauser() -> bool: return true

func _refresh():
	_refresh_quest_list()
	_refresh_quest_info()

func _refresh_quest_list():
	var quest_lists := {}
	
	for child in quest_list_parent.get_children():
		quest_list_parent.remove_child(child)
		child.queue_free()
	
	for q: QuestInfo in State.quests:
		var state: StringName = QuestInfo.QuestState.keys()[q.state]
		if not state in quest_lists:
			var list := quest_list_prefab.duplicate()
			quest_list_parent.add_child(list)
			list.get_node("label").text = state
			quest_lists[state] = list
		
		var quest_button: Node = quest_button_prefab.duplicate()
		quest_lists[state].get_node("list").add_child(quest_button)
		var btn := quest_button.get_node("button")
		btn.name = q.id
		btn.text = q.name
		btn.modulate = QuestInfo.get_state_color(q.state)
		btn.pressed.connect(_select_quest.bind(q))

func _refresh_quest_info():
	UNode.remove_children(tick_parent)
	
	if quest:
		quest_info.text = "%s\n[i]%s" % [quest.name, quest.desc]
		
		for tick_id: StringName in quest.ticks:
			var tick := quest.ticks[tick_id]
			var tk := tick_prefab.duplicate()
			tick_parent.add_child(tk)
			tk.text = "%s/%s %s" % [tick.tick, tick.max_ticks, tick.name]
			tk.modulate = QuestInfo.get_state_color(tick.state)
	else:
		quest_info.text = ""

func _select_quest(q: QuestInfo):
	print("Selected quest ", q)
	quest = q
	_refresh_quest_info()

#func _descend(quest: Quest):
	#for goal in quest:
		#quest_info.text += "\t[i]%s[/i]: [i]%s[/i]\n" % [goal.name, goal.desc]
		#_descend(goal)

```

# res://scenes/widgits/radial_menu.gd
```gd
@tool
class_name RadialMenu extends MenuWidget

enum InputMode { KEYBOARD, MOUSE, GAME_PAD }

@export var radius := 120.0 ## How far to keep buttons from each other.
@export var input_mode := InputMode.MOUSE
@export var mouse_deadzone: float = 5.0 # Pixels; ignore small movements
@export var mouse_sensitivity: float = 1.0 # Scale delta for snappier feel
@export_range(-PI, PI, 0.01, "radians_as_degrees") var rotation_offset := 0.0

var spacing: float:
	get: return TAU / float(choices.size())

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	var cont := get_controller()
	var buttons: TweeButtonList = %choice_parent
	
	if cont.is_action_pressed(&"interact"):
		select()
	
	match input_mode:
		InputMode.KEYBOARD:
			if cont.is_action_pressed(&"move_left"):
				buttons.hovered -= 1
			elif cont.is_action_pressed(&"move_right"):
				buttons.hovered += 1
		
		InputMode.MOUSE:
			if event is InputEventMouseMotion:
				var delta: Vector2 = event.relative * mouse_sensitivity 
				if delta.length() < mouse_deadzone:
					return
				var mouse_dir := delta.normalized()
				var mouse_angle := mouse_dir.angle()
				var closest_index := 0
				var min_diff := INF
				for i in choices.size():
					var angle := i * spacing + rotation_offset
					var diff := absf(angle_difference(mouse_angle, angle))
					if diff < min_diff:
						min_diff = diff
						closest_index = i
				buttons.hovered = closest_index
		
		InputMode.GAME_PAD:
			Global.warn("RadialMenu", "Gamepad not implemented.")

func set_choices(c: Array) -> void:
	super(c)
	
	var buttons: TweeButtonList = %choice_parent
	for i in choices.size():
		var angle := i * spacing + rotation_offset
		var distance := radius
		var node := buttons.buttons[i]
		node.position = Vector2(cos(angle), sin(angle)) * distance\
			- node.size * .5

```

# res://scenes/widgits/simple_toast.gd
```gd
extends PanelContainer

signal finished()

@export var mono := false ## Only one can show at a time.
@export var v_align := VERTICAL_ALIGNMENT_TOP
@export var h_align := HORIZONTAL_ALIGNMENT_RIGHT
@export var data: Dictionary: set=set_data
var _tween: Tween

func _enter_tree() -> void:
	modulate.a = 0.0
	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.tween_property(self, "modulate:a", 1.0, 0.5)
	_tween.tween_interval(2.0)
	_tween.tween_property(self, "modulate:a", 0.0, 0.2)
	_tween.tween_callback(finished.emit)

func set_data(d: Dictionary):
	data = d
	%label.text = data.get(&"text", "NO TEXT")
	%icon.texture = load(data.get(&"icon", "res://icon.svg"))

```

# res://scenes/widgits/toast_manager.gd
```gd
extends Widget

var _active: Dictionary[StringName, Array]
var _queued: Dictionary[StringName, Array]

func _ready() -> void:
	State.TOAST.connect_to(_event)

func _event(ev: Event) -> void:
	if not ev == State.TOAST: return
	var type: StringName = ev.get_str_name(&"type")
	#var player: int = ev.get_int(&"player")
	var data: Dictionary = ev.get_dict(&"data")
	
	var toast := Assets.create_scene(type, null, { data=data })
	var mono: bool = toast.mono
	if mono:
		if type in _active and _active[type].size() > 0:
			_queued[type].append(toast)
		else:
			_show_toast(toast, type)
	else:
		_show_toast(toast, type)

func _show_toast(toast: Control, type: StringName):
	add_child(toast)
	if not type in _active:
		_active[type] = []
	_active[type].append(toast)
	var h_align: HorizontalAlignment = toast.h_align
	toast.position = Global.view_size - toast.size - Vector2(8, 8)
	match h_align:
		HORIZONTAL_ALIGNMENT_RIGHT:
			toast.position.y = 0.0
			for other in _active[type]:
				if other == toast: continue
				other.position.y += toast.size.y + 8
	var v_align: VerticalAlignment = toast.v_align
	match v_align:
		VERTICAL_ALIGNMENT_BOTTOM:
			toast.position.x = 0.0
	
	toast.finished.connect(_hide_toast.bind(toast, type))

func _hide_toast(toast: Control, type: StringName):
	remove_child(toast)
	toast.queue_free()
	_active[type].erase(toast)
	
	if type in _queued and _queued[type].size() > 0:
		var next_toast: Control = _queued[type].pop_front()
		_show_toast(next_toast, type)

```

# res://scenes/widgits/transition.gd
```gd
@tool
class_name Transition extends ColorRect

@export var fade_duration := 0.5
@export_range(0.0, 1.0, 0.01) var amount := 0.0: set=set_amount
var _tween: Tween

func set_amount(a: float):
	amount = a
	modulate.a = amount

func fade_out(duration := fade_duration) -> Signal:
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, ^"amount", 1.0, duration)\
		.set_trans(Tween.TRANS_SINE)
	return _tween.finished

func fade_in(duration := fade_duration) -> Signal:
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, ^"amount", 0.0, duration)\
		.set_trans(Tween.TRANS_SINE)
	return _tween.finished

```

# res://scripts/autoloads/assets.gd
```gd
@tool
extends Node

var assets: AssetsDB:
	get:
		if not assets:
			assets = load("res://assets/assets.tres")
		return assets

func _init() -> void:
	assets = load("res://assets/assets.tres")

func get_material(id: StringName) -> Material:
	if not id in assets.materials:
		push_error("No %s in materials. %s" % [id, assets.materials.keys()])
		return null
	var full_path := "res://assets/materials".path_join(assets.materials[id])
	return load(full_path)
	
func create_audio_player(id: StringName) -> Node:
	if not id in assets.audio:
		push_error("No %s in audio." % [id])
		return null
	var full_path := "res://assets/audio".path_join(assets.audio[id])
	var stream := load(full_path)
	var player := AudioStreamPlayer3D.new()
	player.stream = stream
	return player

func create_scene(id: StringName, parent: Variant = null, props := {}) -> Node:
	if not id in assets.scenes:
		push_error("No %s in scenes. %s." % [id, assets.scenes.values()])
		return null
	var full_path := "res://scenes".path_join(assets.scenes[id])
	var node: Node = load(full_path).instantiate()
	node.name = id
	
	if parent is Node:
		parent.add_child(node)
	elif parent == true:
		get_tree().current_scene.add_child(node)
	
	for prop in props:
		if prop in node:
			node[prop] = props[prop]
	return node

```

# res://scripts/autoloads/audio.gd
```gd
extends Node

func play(_id: StringName):
	pass

```

# res://scripts/autoloads/cheats.gd
```gd
extends Node

var infinite_jumping := false ## Enable infinite jumping.

func _ready() -> void:
	var dir := "res://scripts/cheats"
	for path in DirAccess.get_files_at(dir):
		if path.get_extension() in ["gd", "gdc"]:
			var full_path := dir.path_join(path)
			var _script: GDScript = load(full_path)
			

```

# res://scripts/autoloads/cinema.gd
```gd
extends Node

signal event(id: StringName, data: Variant)
signal started()
signal ended()

var _queue: Array[Array]
var _current: FlowPlayer
var _state: Dictionary[StringName, Variant]

func _event(id: StringName, data: Variant):
	event.emit(id, data)

func queue(scene: Variant, state: Dictionary[StringName, Variant] = {}):
	if is_playing():
		_queue.append([scene, state])
	else:
		started.emit()
		State.add_pauser(self)
		_play(scene, state)

func _play(scene: Variant, state: Dictionary[StringName, Variant]):
	_state = state
	var id: String
	if scene is PackedScene:
		_current = scene.instantiate()
		id = scene.resource_path.get_basename().get_file()
	elif scene is FlowPlayer:
		_current = scene
		id = scene.name
	elif scene is FlowScript:
		_current = FlowPlayerGenerator.generate([scene])
		id = scene.get_id()
	add_child(_current)
	_current.ended.connect(_cinematic_ended)
	_current.play(id + "/ROOT")

func _cinematic_ended():
	print("CINEMA ENDED ", _current, " QUEUE ", _queue)
	remove_child(_current)
	_current.queue_free()
	_current = null
	if _queue:
		var next: Array = _queue.pop_front()
		_play(next[0], next[1])
	else:
		State.remove_pauser(self)
		ended.emit()

func is_playing() -> bool:
	return _current != null

func exists(_id: StringName) -> bool:
	return true

```

# res://scripts/autoloads/controllers.gd
```gd
extends Control
## Handles players and npcs.

#signal event(ev: Event, data: Variant)

var player: ControllerPlayer = load("res://scenes/prefabs/controller_player.tscn").instantiate()
var player2: ControllerPlayer = load("res://scenes/prefabs/controller_player.tscn").instantiate()
var players: Dictionary[StringName, ControllerPlayer] = {
	"player": player,
	"player2": player2
}

var npcs: Dictionary[StringName, ControllerNPC]

#var EV_SHOW_MARKER := Event.new(event)
#var EV_HIDE_MARKER := Event.new(event)

func get_or_create_npc(id: StringName) -> ControllerNPC:
	if not id in npcs:
		var cont := ControllerNPC.new()
		add_child(cont)
		cont.name = id
		npcs[id] = cont
	return npcs[id]

func _ready() -> void:
	mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED
	
	add_child(player)
	#for c in controllers:
		#add_child(c)
	size = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height"))
	
	player.index = 0
	player.name = "player_1"
	player.set_size.call_deferred(size)

	player2.index = 1
	player2.name = "player_2"
	player2.set_size.call_deferred(size)
	
	_toggle_1_player()
	
	get_tree().current_scene.get_viewport().disable_3d = true

func get_player(index: int) -> ControllerPlayer:
	match index:
		0: return player
		1: return player2
	return null

func _toggle_1_player():
	player.visible = true
	player.set_size.call_deferred(size)
	player.viewport_container.size = player.size
	
	player2.visible = false
	
func _toggle_2_player():
	if not player2.get_parent():
		add_child(player2)
	
	player.visible = true
	player.size = Vector2(size.x * .5, size.y)
	player.viewport_container.size = player.size
	#RenderingServer.viewport_attach_camera(player.viewport.get_viewport_rid(), player.camera_master.get_camera_rid())
	
	player2.visible = true
	player2.size = Vector2(size.x * .5, size.y)
	player2.position.x = size.x * .5
	player2.viewport_container.size = player2.size
	#RenderingServer.viewport_attach_camera(player.viewport.get_viewport_rid(), player.camera_master.get_camera_rid())

func _unhandled_input(ev: InputEvent) -> void:
	if ev.is_action_pressed(&"toggle_1_player", false, true):
		_toggle_1_player()
		get_viewport().set_input_as_handled()
	elif ev.is_action_pressed(&"toggle_2_player", false, true):
		_toggle_2_player()
		get_viewport().set_input_as_handled()

```

# res://scripts/autoloads/devmode.gd
```gd
class_name DevMode extends Node

## Cheatmode.
## Makes it easier to build/test.
static var on := true: set=set_on
static var click_position_3d: Vector3
static var click_position_2d: Vector2

static func set_on(o: bool):
	on = o
	
	var node := Global.get_tree().root.get_node_or_null("devmode")
	if on:
		if not node:
			node = DevMode.new()
			node.name = "devmode"
			Global.get_tree().root.add_child.call_deferred(node)
			Global.msg("DevMode", "Enabled", ["Mua", "hah", "hah", "hah"])
	else:
		if node:
			Global.get_tree().root.remove_child(node)
			node.queue_free()
			Global.msg("DevMode", "Disabled", ["Aww", "www"])

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton\
	and event.button_index == MOUSE_BUTTON_RIGHT\
	and event.pressed:
		var hovered_node: Node = get_viewport().gui_get_hovered_control()
		var options: Array[Dictionary]
		click_position_2d = event.position
		
		if not hovered_node:
			var vp: Viewport = Global.get_tree().get_first_node_in_group("game_viewport")
			var cam := vp.get_camera_3d()
			var mouse_pos = vp.get_mouse_position()
			var from = cam.project_ray_origin(mouse_pos)
			var to = from + cam.project_ray_normal(mouse_pos) * 1000.0
			prints(vp, cam, cam.get_world_3d())
			var space_state = cam.get_world_3d().direct_space_state
			var query := PhysicsRayQueryParameters3D.create(from, to)
			query.collide_with_areas = true
			var hit := space_state.intersect_ray(query)
			if hit:
				hovered_node = hit.collider
				click_position_3d = hit.position
				
				# Go for scene instead.
				if not hovered_node.has_meta(&"devmode_options") and not hovered_node.has_method(&"_get_devmode"):
					hovered_node = hovered_node.owner
			
		if not hovered_node:
			return
		
		if hovered_node.has_method(&"_get_devmode"):
			for op in hovered_node._get_devmode():
				if op is Dictionary:
					options.append(op)
				elif op is Callable:
					options.append({ text=op.get_method().capitalize(), call=op.call })
		if hovered_node.has_meta(&"devmode_options"):
			for op in hovered_node.get_meta(&"devmode_options"):
				if op is Dictionary:
					options.append(op)
				elif op is Callable:
					options.append({ text=op.get_method().capitalize(), call=op.call })
		
		if not options:
			return
		
		#Screen.display_as_flow(&"context_menu", { options=options, hovered=hovered_node })

```

# res://scripts/autoloads/global.gd
```gd
@tool
extends Node

var view_size: Vector2:
	get: return Vector2(ProjectSettings.get("display/window/size/viewport_width"), ProjectSettings.get("display/window/size/viewport_height"))

func wait(time: float, method: Callable) -> Signal:
	var sig := get_tree().create_timer(time).timeout
	sig.connect(method)
	return sig

func change_scene(next_scene: Variant):
	var trans := Assets.create_scene(&"transition", self)
	await trans.fade_out()
	if next_scene is PackedScene:
		get_tree().change_scene_to_packed(next_scene)
	elif next_scene is String:
		get_tree().change_scene_to_file(next_scene)
	await trans.fade_in()
	remove_child(trans)
	trans.queue_free()

func msg(head: String, txt: Variant = "", args := [], kwargs := {}):
	_msg("[color=cyan][%s][/color]" % head, txt, args, kwargs)

func warn(head: String, txt: Variant = "", args := [], kwargs := {}):
	_msg("[color=yellow][b][%s][/b][/color]" % head, txt, args, kwargs)

func err(head: String, txt: Variant = "", args := [], kwargs := {}):
	_msg("[color=red][b][%s][/b][/color]" % head, txt, args, kwargs)

func _msg(head: String, txt: Variant, args: Array, kwargs := {}):
	var lines := [head]
	if txt:
		lines.append("[color=%s]%s[/color]" % [Color.POWDER_BLUE.to_html(), txt])
	if args:
		var arg_lines := []
		var clrs := [Color.YELLOW.to_html(), Color.GOLD.to_html()]
		for i in args.size():
			arg_lines.append("[color=#%s]%s[/color]" % [clrs[0 if i % 2 == 0 else 1], args[i]])
		lines.append(", ".join(arg_lines))
	if kwargs:
		var keys := []
		for key in kwargs:
			keys.append("%s:[color=yellow][i]%s[/i][/color]" % [key, kwargs[key]])
		lines.append(" ".join(keys))
	print_rich(" ".join(lines))

```

# res://scripts/autoloads/mods.gd
```gd
extends Node

var enabled: Array[StringName]

func enable(id: StringName):
	if not id in enabled: enabled.append(id)

func disable(id: StringName):
	if id in enabled: enabled.erase(id)

func get_enabled() -> Array[ModInfo]:
	return [load("res://assets/mods/main.tres")]

```

# res://scripts/autoloads/music.gd
```gd
extends Node

#var _queue: Array[Dictionary]

func play(_id: StringName):
	pass

func play_queued(_id: StringName):
	pass

```

# res://scripts/autoloads/persistent.gd
```gd
extends Node

@export var awards: AwardDB
@export var unlocks: StatDB
@export var donor := false ## Donated to development?

func _ready() -> void:
	awards = AwardDB.new()
	unlocks = StatDB.new()
	
	unlocks.add_flag(&"start_mall") # Alloow starting in the mall.
	unlocks.add_flag(&"start_costco") # Allow spawning in costco.
	unlocks.add_flag(&"start_trailer") # Allow spawning in the trailer park.

```

# res://scripts/autoloads/quadruped.gd
```gd
class_name Quadruped extends Agent

func set_direction(dir: float):
	super(dir)
	%collider.rotation.y = dir

```

# res://scripts/autoloads/save_load.gd
```gd
extends Node

const DIR := "user://saves"

var _current_slot := "quick_save"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"quick_save"):
		save_slot()
		get_viewport().set_input_as_handled()

func get_slots_dirs() -> Array[String]:
	return DirAccess.get_directories_at(DIR)

func save_slot(slot: StringName = _current_slot):
	var dir := _get_dir(slot)
	if not DirAccess.dir_exists_absolute(dir):
		DirAccess.make_dir_recursive_absolute(dir)
	
	var preview := get_viewport().get_texture().get_image()
	preview.shrink_x2()
	preview.save_webp(dir.path_join("preview.webp"))
	
	_save_node(dir, State, "State")
	_save_node("user://", Persistent, "Persistent")
	
	print("Saved to: ", ProjectSettings.globalize_path(dir))

func _save_node(dir: String, node: Node, file: String) -> bool:
	var packed := PackedScene.new()
	var err := packed.pack(node)
	if not err == OK:
		print("PACKING: ", error_string(err))
		return false
	err = ResourceSaver.save(packed, dir.path_join(file + ".tscn"))
	if not err == OK:
		print("SAVING: ", error_string(err))
		return false
	return true

func load_slot(slot: StringName = _current_slot):
	var _dir := _get_dir(slot)
	

func _get_dir(slot: StringName = _current_slot) -> String:
	return DIR.path_join(slot)

```

# res://scripts/autoloads/screens.gd
```gd
extends Node

func display(id: StringName) -> Screen:
	return null

func close(id: StringName):
	return null

```

# res://scripts/autoloads/state.gd
```gd
extends StateBase

```

# res://scripts/autoloads/state_base.gd
```gd
@abstract class_name StateBase extends Node
## Handles state of world in a way where non-loaded content can be set/get.

signal paused()
signal unpaused()
@warning_ignore("unused_signal") signal event(event: Event)

class PawnEvent extends Event:
	var pawn: Pawn
	var posessed: Pawn
	var controller: Controller

class QuestEvent extends Event:
	var quest: QuestInfo

class CharEvent extends Event:
	var who: CharInfo

class ZoneEvent extends Event:
	var zone: ZoneInfo
	var who: CharInfo

class QuestTickEvent extends QuestEvent:
	var tick: QuestTick

class ToastEvent extends Event:
	var type: StringName
	var player: int
	var icon: String
	var title: String
	var subtitle: String
	var data: Dictionary[StringName, Variant]

class StatEvent extends Event:
	var stat: StatInfo
	var old: Variant
	var new: Variant
	func is_decreased() -> bool: return new < old
	func is_increased() -> bool: return new > old
	func is_reset() -> bool: return new == stat.default

class AwardEvent extends Event:
	var award: AwardInfo

#region Events.
var PAWN_ENTERED := PawnEvent.new()
var PAWN_EXITED := PawnEvent.new()

var ZONE_ENTERED := ZoneEvent.new()
var ZONE_EXITED := ZoneEvent.new()

var STAT_CHANGED := StatEvent.new()

var QUEST_STARTED := QuestEvent.new()
var QUEST_TICKED := QuestTickEvent.new()
var QUEST_TICK_COMPLETED := QuestTickEvent.new()
var QUEST_TICK_PASSED := QuestTickEvent.new()
var QUEST_TICK_FAILED := QuestTickEvent.new()
var QUEST_PASSED := QuestEvent.new()
var QUEST_FAILED := QuestEvent.new()

var AWARD_UNLOCKED := AwardEvent.new()
var AWARD_PROGRESSED := AwardEvent.new()

var TOAST := ToastEvent.new()
#endregion

@export var objects: StateObjects
var dbs: Array[Database]
var _pausers: Array[Object]

var chars: CharDB:
	get: return objects.chars
var items: ItemDB:
	get: return objects.items
var zones: ZoneDB:
	get: return objects.zones
var stats: StatDB:
	get: return objects.stats
var quests: QuestDB:
	get: return objects.quests

func _init() -> void:
	# reload() calls set_script() which triggers this _init().
	# We know we are in business once we are the generated script.
	if get_script().resource_path == "res://_state_.gd":
		_true_reload()

#╒─══════──═─══☰☰☰☰☰☰☰═☰[░░░░]☰☰☰☰☰☰☰☰☰══─═──════─══╕
const LOGO := r"""
⌡╭─╮┌─╮╮ ╷╭─╮╭─╮╭─╴╮ ╷  ┌─╴┌─╮╭─╮╭┬╮╭─╴╮╷╷╭─╮┌─╮╷ ╷⌡
 │ │≈ │╰┼╯╰─╮╰─╮├─ ╰┼╯  ├─ ├┬╯├─┤│││├─ ││││ │├┬╯├┬╯
⌠╰─╯└─╯ ╵ ╰─╯╰─╯╰─╴ ╵   ╵  ╵╰╴╯ ╵╵╵╵╰─╴╰┴╯╰─╯╵╰╴╯╰ ⌠
╘══════──═─═══════☰═☰(◟ v{version} ◝)☰═☰═════─═─═════════╛
"""

func print_logo() -> void:
	var c1 := Color.DEEP_SKY_BLUE
	var c2 := Color.GOLDENROD
	var logo := ""
	for row in LOGO.format({version="0.1"}).trim_prefix("\n").trim_suffix("\n").split("\n"):
		var i := 0
		for col in row:
			logo += "[color=#%s]%s[/color]" % [c1.lerp(c2, i / 54.0).to_html(), col]
			i += 1
		logo += "\n"
	print_rich(logo)

func _ready() -> void:
	print_logo()
	reload()

func add_pauser(obj: Object):
	if obj in _pausers: return
	_pausers.append(obj)
	if _pausers.size() == 1:
		_pause.call_deferred()

func remove_pauser(obj: Object):
	if not obj in _pausers: return
	_pausers.erase(obj)
	if _pausers.size() == 0:
		_unpause.call_deferred()

func _pause():
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_DISABLED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused.emit()
	
func _unpause():
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	unpaused.emit()

func reload():
	objects = StateObjects.new()
	
	var mods := Mods.get_enabled()
	var code := []
	
	var score := StatInfo.new()
	score.default = 0
	score.value = 0
	mods[0].stats._add("score", score)
	
	for mod: ModInfo in mods:
		# Compile conditions script.
		for meth_name in mod._script_exprs:
			code.append("func %s() -> void: %s" % [meth_name, mod._script_exprs[meth_name]])
		for meth_name in mod._script_conds:
			var cond := mod._script_conds[meth_name]
			if not cond: cond = "true" # TODO: Fix.
			code.append("func %s() -> bool: return %s" % [meth_name, cond])
		
		#prints(mod.mod_name, mod.mod_version, len(mod._script_exprs), len(mod._script_conds))
		
		for db in mod.get_dbs():
			var db_id := UObj.get_class_name(db).trim_suffix("DB").to_snake_case().to_lower() + "s"
			code.append("\n####\n## %s x%s\n####" % [db_id.to_upper(), db.size()])
			for obj in db:
				var prop_id: String = obj.id.replace("#", "__")
				if "#" in obj.id: continue
				if obj is StatInfo:
					var prop_type: String = type_string(typeof(obj.default))
					code.append("var %s: %s:\n\tget: return %s[&\"%s\"].value\n\tset(v): %s[&\"%s\"].value = v" % [prop_id, prop_type, db_id, obj.id, db_id, obj.id])
				else:
					var prop_class: String = UObj.get_class_name(obj)
					code.append("var %s: %s:\n\tget: return %s[&\"%s\"]" % [prop_id, prop_class, db_id, obj.id])
	
	var scr := GDScript.new()
	code = [
		"# WARNING: Autogenerated in StateBase",
		"# Allows making sure all flow_script variables and functions will work.",
		"# TODO: Show stats here, like 'lines spoken' for each character.",
		"extends StateBase"
	] + code
	scr.source_code = "\n".join(code)
	ResourceSaver.save(scr, "res://_state_.gd")
	set_script.call_deferred(load("res://_state_.gd"))
	
	Global.msg("State", "Reloading script...")

func _true_reload():
	objects = StateObjects.new()
	dbs = objects.get_dbs()
	
	var mods := Mods.get_enabled()
	for mod in mods:
		var mod_dbs := mod.get_dbs()
		for i in dbs.size():
			dbs[i].merge(mod_dbs[i])
	
	for db in dbs:
		db.connect_signals()
	
	# Pass Events their variable name.
	for prop in get_property_list():
		if UBit.is_enabled(prop.usage, PROPERTY_USAGE_SCRIPT_VARIABLE):
			if prop.type == TYPE_OBJECT and self[prop.name] is Event:
				self[prop.name].id = prop.name
	
	Global.msg("State", "Reloaded", [objects.get_counts_string()])
	
func find_char(id: StringName) -> CharInfo: return objects.chars.find(id)
func find_item(id: StringName) -> ItemInfo: return objects.items.find(id)
func find_zone(id: StringName) -> ItemInfo: return objects.zones.find(id)
func find_equipment_slot(id: StringName) -> EquipmentSlotInfo: return objects.equipment_slots.find(id)
func find_attribute(id: StringName) -> AttributeInfo: return objects.attributes.find(id)
func find_quest(id: StringName) -> QuestInfo: return objects.quests.find(id)
	
func _get(property: StringName) -> Variant:
	for db in dbs:
		if db.has(property):
			return db.get(property)
	return null

func _set(property: StringName, value: Variant) -> bool:
	for db in dbs:
		if db.has(property):
			db.set(property, value)
			return true
	return false

```

# res://scripts/cheats/change_mode.gd
```gd
extends Node

enum Mode { FIRST_PERSON, THIRD_PERSON }

static func set_mode(mode: Mode):
	print(mode)

```

# res://scripts/editor/REBUILD_ASSET_DB.gd
```gd
@tool
class_name EditorRebuildAssetDB extends EditorScript

func _run() -> void:
	var ass := AssetsDB.new()
	ass.reload()
	ResourceSaver.save(ass, "res://assets/assets.tres")
	EditorInterface.get_resource_filesystem().scan()
	EditorInterface.get_resource_filesystem().update_file("res://assets/assets.tres")
	EditorInterface.get_resource_filesystem().reimport_files(["res://assets/assets.tres"])

```

# res://scripts/editor/REBUILD_MODS.gd
```gd
@tool
class_name EditorRebuildMods extends EditorScript

const MOD_DIR := "res://assets/mods"

func _run() -> void:
	for dir in DirAccess.get_directories_at(MOD_DIR):
		var mod := ModInfo.new()
		mod.load_dir(MOD_DIR.path_join(dir))
		var res_path := MOD_DIR.path_join(dir + ".tres")
		ResourceSaver.save(mod, res_path)
		var fs := EditorInterface.get_resource_filesystem()
		fs.scan.call_deferred()
		fs.update_file.call_deferred(res_path)
		fs.reimport_files.call_deferred([res_path])

```

# res://scripts/enums/view_mode.gd
```gd
class_name ViewMode extends RefCounted

enum { FIRST_PERSON, THIRD_PERSON, TOP_DOWN }

```

# res://scripts/nodes/agent.gd
```gd
class_name Agent extends CharacterBody3D

signal damage_dealt(info: DamageInfo)
signal damage_taken(info: DamageInfo)
signal jumped() ## Called after jumping.
signal landed(meters: float) ## Called when hitting the floor.
signal prone_state_changed()
signal looked_at(pos: Vector3)
signal head_looked_at(pos: Vector3)
signal head_looking_amount_changed(amount: float)
signal focus_started()
signal focus_stopped()
signal interactive_changed()
@warning_ignore("unused_signal")
signal trigger_animation(anim: StringName)

enum ProneState { Stand, Crouch, Kneel, Crawl }

@onready var damageable: Damageable = %damageable
@onready var ray_coyote: RayCast3D = $ray_coyote
@onready var interactive_node: Interactive = %interactive
@onready var node_direction: Node3D = %direction
@onready var interactive_detector: Detector = %interact
@onready var node_seeing: Detector = %seeing
@onready var node_hearing: Detector = %hearing
@onready var nav_agent: NavigationAgent3D = %nav_agent
@export var flow_script: FlowScript
@export_range(-180, 180, 0.01, "radians_as_degrees") var direction: float: get=get_direction, set=set_direction
@export var char_id: StringName
var char_info: CharInfo:
	get: return null if not char_id else State.find_char(char_id)
var movement := Vector2.ZERO
var body: CharacterBody3D = convert(self, TYPE_OBJECT)
var _equipped: Dictionary[StringName, ItemNode]
var prone_state := ProneState.Stand:
	set(ps):
		if prone_state == ps: return
		prone_state = ps
		prone_state_changed.emit()
var _next_prone_state := ProneState.Stand
var _focusing := false
var _interactive: Interactive: ## Interactive we are looking at.
	set(inter):
		_interactive = inter
		interactive_changed.emit()
var _interacting: Interactive ## Interactive we are interacting with.
var _jumping := false
var _jump_cancel := false
var _sprinting := false
var _was_in_air := false
var _last_position: Vector3
var _held_item: ItemNode
var _held_item_remote: RemoteTransform3D
var looking_at: Vector3:
	set(at):
		looking_at = at
		looked_at.emit(at)
		%cursor.global_position = at
var head_looking_at: Vector3:
	set(at):
		head_looking_at = at
		head_looked_at.emit(at)
var head_looking_amount: float:
	set(amt):
		head_looking_amount = amt
		head_looking_amount_changed.emit(amt)

var speed_stand := 3.0
var speed_crouch := 1.0
var speed_crawl := 0.25

var visual: PackedScene ## TODO:
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_force := 6.0

var _footstep_time := 0.0

func _ready() -> void:
	fix_direction()
	if %nav_agent:
		(%nav_agent as NavigationAgent3D).navigation_finished.connect(func(): movement = Vector2.ZERO)
	if %damageable:
		(%damageable as Damageable).damaged.connect(damage_taken.emit)
	if %interactive:
		interactive_detector.ignore.append(%interactive)
		%interactive.interacted.connect(_interacted)

func _physics_process(delta: float) -> void:
	#if frozen: return
	
	var move_speed := 1.0
	match prone_state:
		ProneState.Stand: move_speed = speed_stand
		ProneState.Crouch: move_speed = speed_crouch
		ProneState.Crawl: move_speed = speed_crawl
	if _sprinting:
		move_speed *= 2.0
	
	#if not nav_agent.is_navigation_finished():
		#var curr_pos := global_position
		#var next_pos := nav_agent.get_next_path_position()
		#var dir := next_pos - curr_pos
		#dir.y = 0.0
		#dir = dir.normalized()
		#movement.x = dir.x
		#movement.y = dir.z
		#var ang := Vector2(curr_pos.x, curr_pos.z).direction_to(Vector2(next_pos.x, next_pos.z))
		#direction = lerp_angle(direction, atan2(-ang.y, ang.x), delta * 10.0)
	
	#if name == "player":
		#prints(_jumping, _jump_cancel)
	
	var vel := Vector3(movement.x * move_speed, body.velocity.y, movement.y * move_speed)
	if _jump_cancel:
		_jumping = false
		_jump_cancel = false
		vel.y /= 2.0
	elif _jumping and (body.is_on_floor() or Cheats.infinite_jumping):
		_jumping = false
		vel.y = jump_force
		jumped.emit()
	elif body.is_on_floor():
		vel.y = -0.01
	else:
		vel.y -= gravity * delta
		
	if body.is_on_floor():
		_footstep_time += Vector2(vel.x, vel.z).length() * delta
		if _footstep_time > 1.0:
			_footstep_time -= 1.0
			
			var col: Node = %ray_coyote.get_collider()
			if col and "physics_material_override" in col and col.physics_material_override is SurfaceMaterial:
				var mat: SurfaceMaterial = col.physics_material_override
				var id: String
				match mat.resource_path:
					"res://assets/surfaces/grass.tres":
						id = "grass_%s" % randi_range(1, 15)
					"res://assets/surfaces/concrete.tres":
						id = "concrete_%s" % randi_range(1, 15)
					"res://assets/surfaces/wood.tres":
						id = "wood_%s" % randi_range(1, 15)
					"res://assets/surfaces/carpet.tres":
						id = "carpet_%s" % randi_range(1, 15)
				var audio: AudioStreamPlayer3D = Assets.create_audio_player(id)
				add_child(audio)
				audio.play(0.1)
				audio.finished.connect(func():
					audio.queue_free()
					print("removed"))
		
		if _was_in_air:
			_was_in_air = false
			landed.emit(1.0) # TODO: Meters fallen.
	
	_was_in_air = not body.is_on_floor()
	
	body.velocity = vel
	body.move_and_slide()
	_last_position = body.global_position

func _interacted(pawn: Pawn, form: Interactive.Form) -> void:
	if flow_script:
		Cinema.queue(flow_script)
	else:
		prints(pawn.name, "interacted with", name, "FORM:", form)

func fix_direction() -> void:
	# Transfer rotation to proper node.
	%direction.rotation.y = rotation.y
	rotation.y = 0

func equip(item: ItemNode, slot: StringName = &""):
	_equipped[slot] = item
	var parent := get_node_or_null("%" + str(slot))
	if parent != null:
		if item.get_parent() == null:
			parent.add_child(item)
		else:
			item.reparent(parent)
	item.damage_dealt.connect(damage_dealt.emit)

func unequip_slot(slot: StringName = &""):
	if not slot in _equipped: return
	var item: ItemNode = _equipped[slot]
	item.damage_dealt.disconnect(damage_dealt.emit)
	_equipped.erase(slot)

func get_direction() -> float: return %direction.rotation.y
func set_direction(dir: float): %direction.rotation.y = dir

func focus_start():
	_focusing = true
	focus_started.emit()

func focus_stop():
	_focusing = false
	focus_stopped.emit()

func interact_start(pawn: Pawn) -> bool:
	if _interactive:#interactive_detector.is_detecting():
		_interacting = _interactive#interactive_detector.get_nearest() as Interactive
		_interacting.interact(pawn)
		return true
	return false

func interact_stop(pawn: Pawn) -> bool:
	if _interacting:
		_interacting.cancel(pawn)
		_interacting = null
		return true
	return false

func sprint_start():
	_sprinting = true

func sprint_stop():
	_sprinting = false

func jump_start():
	_jumping = true

func jump_stop():
	_jump_cancel = true

func fire_start() -> bool:
	if not _held_item: return false
	return _held_item.item._node_use(_held_item)

func fire_stop() -> bool: return true

func reload_start() -> bool:
	if not _held_item: return false
	return _held_item.item._node_reload(_held_item)

func reload_stop() -> bool: return true

func stand(): prone_state = ProneState.Stand
func crouch(): prone_state = ProneState.Crouch
func crawl(): prone_state = ProneState.Crawl

func is_focusing() -> bool: return _focusing
func is_crouching() -> bool: return prone_state == ProneState.Crouch or _next_prone_state == ProneState.Crouch
func is_crawling() -> bool: return prone_state == ProneState.Crawl or _next_prone_state == ProneState.Crawl
func is_standing() -> bool: return prone_state == ProneState.Stand or _next_prone_state == ProneState.Stand

func freeze() -> void:
	collision_mask = 0
	set_process(false)
	set_physics_process(false)

func unfreeze() -> void:
	collision_mask = 1
	set_process(true)
	set_physics_process(true)

func drop() -> bool:
	if not _held_item: return false
	if _held_item.item._node_unequipped(_held_item):
		var trans := _held_item.global_transform
		var fwd: Vector3 = -%head.global_basis.z
		trans.origin += fwd * .2
		%head.remove_child(_held_item_remote)
		_held_item_remote.queue_free()
		_held_item_remote = null
		#_held_item.reparent(_held_item_last_parent)
		_held_item.mount = null
		_held_item.process_mode = Node.PROCESS_MODE_INHERIT
		_held_item.reset_state(trans)
		_held_item.apply_central_impulse(fwd * 3.0)
		_held_item = null
		#_held_item_last_parent = null
		return true
	return false

```

# res://scripts/nodes/bird.gd
```gd
extends Agent

@export var speed := 1.5
@export var flee := false

func _ready() -> void:
	super()
	node_seeing.started.connect(_noticed)
	node_seeing.ended.connect(_unnoticed)

func _noticed():
	if not flee:
		flee = true
		#print("fly away")
	
func _unnoticed():
	if not node_seeing.is_detecting() and not node_hearing.is_detecting():
		flee = false
		#print("stop flying")

func move(to: Vector3, _delta: float) -> bool:
	var dir := Vector3(
		to.x - global_position.x,
		0.0,
		to.z - global_position.z
	)
	if dir.length() > 0.1:
		body.velocity += dir.normalized() * minf(dir.length(), speed)
		return true
	else:
		body.velocity.x = 0.0
		body.velocity.z = 0.0
		return false

func _physics_process(delta: float) -> void:
	if flee:
		if global_position.y < 3.0:
			body.velocity.y += speed * delta
		else:
			flee = false
	elif body.is_on_floor():
		body.velocity.y = 0.0
	else:
		body.velocity += body.get_gravity() * delta
	body.move_and_slide()

```

# res://scripts/nodes/camera_follow.gd
```gd
class_name CameraFollow extends CameraTarget

@onready var pivot: Node3D = %pivot
@onready var spring_arm: SpringArm3D = %spring_arm
@onready var offset: Node3D = %offset

@export var target: Node3D: set=set_target
@export var mouse_sensitivity := 0.02
@export var rot_y := 0.0
@export var rot_x := 0.0
@export var view_mode := ViewMode.FIRST_PERSON
@export var focusing := false

var fov_focused := 30.0
var fov_unfocused := 75.0
var focus_offset := Vector2(10.0, 10.0)
var _noise := FastNoiseLite.new()
var _noise_time := randf()
var _noise_speed := 10.0
#var _noise_scale := Vector2(0.3, 0.1)

var push_out := Vector2.ZERO: set=set_push_out
var aim_offset_y := 0.0
var aim_look_dist := 0.0

func _ready() -> void:
	_noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	_noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	process_priority = 100
	process_physics_priority = 100

func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func set_target(t):
	target = t
	if target is Agent:
		target.focus_started.connect(_focus_started)
		target.focus_stopped.connect(_focus_stopped)

func is_third_person() -> bool: return view_mode == ViewMode.THIRD_PERSON
func is_first_person() -> bool: return view_mode == ViewMode.FIRST_PERSON

func _focus_started():
	focusing = true
	aim_look_dist = pivot.global_position.distance_to((target as Agent).looking_at)
	UTween.parallel(camera, { "fov": fov_focused }, 0.2)
	if is_third_person():
		UTween.parallel(self, { "push_out": Vector2(1, 0.0) }, 0.2)

func _focus_stopped():
	focusing = false
	aim_look_dist = spring_arm.spring_length
	UTween.parallel(camera, { "fov": fov_unfocused }, 0.2)
	if is_third_person():
		UTween.parallel(self, { "push_out": Vector2.ZERO }, 0.2)

func set_push_out(off: Vector2):
	push_out = off
	camera.position = Vector3(off.x, off.y, 0.0)
	aim_offset_y = atan2(off.x, aim_look_dist) # Correct the rotation.

func set_first_person() -> Signal:
	view_mode = ViewMode.FIRST_PERSON
	var twn := UTween.parallel(self, {"spring_arm:spring_length": 0.0}, 0.5, &"spring_length")
	return twn.finished

func set_third_person() -> Signal:
	view_mode = ViewMode.THIRD_PERSON
	var twn := UTween.parallel(self, {"spring_arm:spring_length": 3.0}, 0.5, &"spring_length")
	return twn.finished

func get_fov_scale() -> float:
	return remap(camera.fov, fov_unfocused, fov_focused, 0.0, 1.0)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var fov_scale := lerpf(0.01, 0.001, get_fov_scale())
		rot_y -= event.relative.x * fov_scale
		rot_x -= event.relative.y * fov_scale
		rot_x = clampf(rot_x, deg_to_rad(-89), deg_to_rad(89))

func _process(delta: float) -> void:
	
	pivot.rotation.y = lerp_angle(pivot.rotation.y, rot_y + aim_offset_y, 30.0 * delta)
	pivot.rotation.x = lerp_angle(pivot.rotation.x, rot_x, 30.0 * delta)
	
	_noise_time += delta * _noise_speed
	#var fov_scale := get_fov_scale()
	#camera.h_offset = _noise.get_noise_1d(_noise_time + 123.456) * _noise_scale.x * fov_scale
	#camera.v_offset = _noise.get_noise_1d(_noise_time + 654.321) * _noise_scale.y * fov_scale
	
	#match view_mode:
		#ViewMode.FIRST_PERSON:
			#if target:
				#global_position = target.global_position
		#
		#ViewMode.THIRD_PERSON:
			#if target:
				#global_position = global_position.slerp(target.global_position, 20.0 * delta)

```

# res://scripts/nodes/camera_master.gd
```gd
class_name CameraMaster extends Camera3D

@export var target: Camera3D: set=set_target
var _remote: RemoteTransform3D
var _remote2: RemoteTransform3D

func set_target(t: Camera3D):
	print("Set target ", t)
	if target == t: return
	if _remote:
		_remote.get_parent().remove_child(_remote)
		_remote.queue_free()
		_remote = null
		
		_remote2.get_parent().remove_child(_remote2)
		_remote2.queue_free()
		_remote2 = null
		
	target = t
	if target:
		_remote = RemoteTransform3D.new()
		target.add_child(_remote)
		_remote.name = "main_camera"
		_remote.update_scale = false
		_remote.remote_path = get_path()
		
		_remote2 = RemoteTransform3D.new()
		target.add_child(_remote2)
		_remote2.name = "fps_camera"
		_remote2.update_scale = false
		_remote2.remote_path = %fps_camera_master.get_path()
		
		var targ_offset := Vector2(target.h_offset, target.v_offset)
		var targ_fov := target.fov
		var targ_size := target.size
		var targ_range := Vector2(target.near, target.far)
		UTween.interp(self, func(blend: float):
			h_offset = lerpf(targ_offset.x, t.h_offset, blend)
			v_offset = lerpf(targ_offset.y, t.v_offset, blend)
			fov = lerpf(targ_fov, t.fov, blend)
			size = lerpf(targ_size, t.size, blend)
			near = lerpf(targ_range.x, t.near, blend)
			far = lerpf(targ_range.y, t.far, blend)
		, 0.5)

```

# res://scripts/nodes/camera_target.gd
```gd
class_name CameraTarget extends Node3D

@export var camera: Camera3D

```

# res://scripts/nodes/camera_top_down.gd
```gd
class_name CameraTopDown extends CameraTarget
# TODO: Move to main camera script

@onready var cursor: MeshInstance3D = %cursor

#func _enter_tree() -> void:
	#make_current()
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
#
#func _exit_tree() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

#func _process(delta: float) -> void:
	#var move := _c.get_move_vector()
	#var speed := 10.0
	#global_position += Vector3(move.x, 0.0, move.y) * speed * delta

```

# res://scripts/nodes/controller.gd
```gd
class_name Controller extends Node

@export var index := 0 ## For multiplayer.
@export var pawn: Pawn: set=set_pawn

func _init(i := 0) -> void:
	index = i
	add_to_group(&"Controller")

func set_pawn(target: Pawn):
	if pawn == target: return
	if pawn:
		pawn._unposessed()
		_ended()
	pawn = target
	pawn._posessed(self)
	_started.call_deferred()

func is_npc() -> bool: return self is ControllerNPC
func is_player() -> bool: return self is ControllerPlayer

func get_move_vector() -> Vector2:
	return Vector2.ZERO

func _started():
	print("Control Started ", pawn)

func _ended():
	print("Control Ended ", pawn)

```

# res://scripts/nodes/controller_npc.gd
```gd
class_name ControllerNPC extends Controller

```

# res://scripts/nodes/controller_player.gd
```gd
class_name ControllerPlayer extends Controller

signal view_state_changed()
signal focus_exited(con: Control)
signal focus_entered(con: Control)

enum ViewState { None, FirstPerson, ThirdPerson, TopDown }

@onready var viewport_container: ControllerPlayer = %viewport_container
@onready var fps_viewport_container: SubViewportContainer = %fps_viewport_container
@onready var viewport: SubViewport = %viewport
@onready var camera_master: CameraMaster = %camera_master
var input_remap: Dictionary[StringName, StringName] # TODO: Move to some global area?
var _widgits: Dictionary[StringName, Widget]
var _event: InputEvent
var _focused_control: Control

var view_state := ViewState.FirstPerson:
	set(vs):
		view_state = vs
		view_state_changed.emit()
		prints(name, view_state_changed.get_connections(), pawn)

func hide_fps_viewport():
	UTween.parallel(fps_viewport_container, { "modulate:a": 0.0 }, 0.2)\
		.finished.connect(func(): fps_viewport_container.visible = false)

func show_fps_viewport():
	fps_viewport_container.visible = true
	UTween.parallel(fps_viewport_container, { "modulate:a": 1.0 }, 0.2)

func grab_control_focus(c: Control):
	c.grab_focus()

func get_move_vector() -> Vector2:
	return Input.get_vector(
		input_remap.get(&"move_left", &"move_left"),
		input_remap.get(&"move_right", &"move_right"),
		input_remap.get(&"move_forward", &"move_forward"),
		input_remap.get(&"move_backward", &"move_backward"))

func get_move_vector_camera() -> Vector2:
	var dir := camera_master.global_rotation.y
	return get_move_vector().rotated(-dir)

func is_widgit_visible(id: StringName) -> bool:
	return id in _widgits

func toggle_widgit(id: StringName, props := {}) -> Node:
	if is_widgit_visible(id):
		hide_widgit(id)
		return null
	else:
		return show_widgit(id, props)

func show_widgit(id: StringName, props := {}) -> Widget:
	var widgit: Widget = _widgits.get(id)
	if not widgit:
		widgit = Assets.create_scene(id, self, props)
		if widgit.is_pauser():
			State.add_pauser(widgit)
		_widgits[id] = widgit
	return widgit

func hide_widgit(id: StringName) -> bool:
	var widgit: Widget = _widgits.get(id)
	if widgit:
		if widgit.is_pauser():
			State.remove_pauser(widgit)
		remove_child(widgit)
		widgit.queue_free()
		_widgits.erase(id)
		return true
	return false

func is_action_pressed(action: StringName, allow_echo := false, exact_match := false) -> bool:
	return _event.is_action_pressed(input_remap.get(action, action), allow_echo, exact_match)

func is_action_released(action: StringName, exact_match := false):
	return _event.is_action_released(action, exact_match)

func _unhandled_input(event: InputEvent) -> void:
	if name != "player_1": return
	_event = event
	
	if _focused_control:
		var next: Control
		if is_action_pressed(&"move_left"):
			next = _focused_control.find_valid_focus_neighbor(SIDE_LEFT)
			if not next: next = _focused_control.find_prev_valid_focus()
		elif is_action_pressed(&"move_right"):
			next = _focused_control.find_valid_focus_neighbor(SIDE_RIGHT)
			if not next: next = _focused_control.find_next_valid_focus()
		elif is_action_pressed(&"move_forward"):
			next = _focused_control.find_valid_focus_neighbor(SIDE_TOP)
			if not next: next = _focused_control.find_prev_valid_focus()
		elif is_action_pressed(&"move_down"):
			next = _focused_control.find_valid_focus_neighbor(SIDE_BOTTOM)
			if not next: next = _focused_control.find_next_valid_focus()
		if next:
			if _focused_control: focus_exited.emit(_focused_control)
			_focused_control = next
			if _focused_control: focus_entered.emit(_focused_control)
			get_viewport().input_as_handled()
	
	if is_action_pressed(&"toggle_first_person", false, true):
		print("first person")
		view_state = ViewState.FirstPerson
		get_viewport().set_input_as_handled()
	elif is_action_pressed(&"toggle_third_person", false, true):
		print("third person")
		view_state = ViewState.ThirdPerson
		get_viewport().set_input_as_handled()
	elif is_action_pressed(&"toggle_top_down", false, true):
		print("top down")
		view_state = ViewState.TopDown
		get_viewport().set_input_as_handled()

```

# res://scripts/nodes/damageable.gd
```gd
@tool
@icon("res://addons/odyssey/icons/damageable.svg")
class_name Damageable extends Area3D

signal died()
signal damaged(amnt: float)
signal healed(amnt: float)
signal revived()

@export var max_health := 100.0
@export var health := 100.0:
	set(h): health = clampf(h, 0.0, max_health)

func _init() -> void:
	monitoring = false
	collision_layer = 1 << 10
	collision_mask = 0

func damage(amount: float, _type := -1):
	var old_health := health
	health -= amount
	if health == old_health: return
	print("DAMAGE %s/%s" % [health, max_health])
	var diff := old_health - health
	if diff > 0:
		damaged.emit(diff)
	if health == 0:
		died.emit()

func heal(amount: float, _type := -1):
	var old_health := health
	health += amount
	if health == old_health: return
	var diff := health - old_health
	if diff > 0:
		healed.emit(diff)
	if old_health == 0:
		revived.emit()
	
	
	

```

# res://scripts/nodes/debug_area.gd
```gd
extends Node3D

@export var area: Area3D:
	get: return area if area else get_parent()

func _ready() -> void:
	area.body_entered.connect(_body_entered)
	area.body_exited.connect(_body_exited)
	area.body_shape_entered.connect(_body_shape_entered)
	area.body_shape_exited.connect(_body_shape_exited)
	
func _body_entered(body: Node3D):
	pass

func _body_exited(body: Node3D):
	pass

func _body_shape_entered(b):
	pass

func _body_shape_exited(b):
	pass

```

# res://scripts/nodes/detectable_sound.gd
```gd
class_name DetectableSound extends Area3D

static func create(sound: StringName, at: Vector3, distance := 5.0, duration := 1.0) -> DetectableSound:
	var node: DetectableSound = Assets.create_scene(&"detectable_sound")
	Global.get_tree().current_scene.add_child(node)
	node.name = "detsound_" + sound
	node.global_position = at
	var strm: AudioStreamPlayer3D = node.get_node(^"%stream")
	strm.max_distance = distance
	strm.stream = load(Assets.get_sound(sound))
	var shape: CollisionShape3D = node.get_node(^"%shape")
	shape.shape = SphereShape3D.new()
	shape.shape.radius = distance
	Global.wait(duration, node.queue_free)
	return node

```

# res://scripts/nodes/detector.gd
```gd
@icon("res://addons/odyssey/icons/detector.svg")
class_name Detector extends Area3D
## Manages a list of things it can see.
## Used for hearing, seeing, and interaction.

signal started() ## Started noticing things.
signal entered(area: Node3D) ## Noticed something.
signal exited(area: Node3D) ## Lost something.
signal moved(area: Node3D)
signal ended() ## Stopped noticing anything.
signal visible_changed() ## List of detected changed.

var ignore: Array[Node3D]
var _nodes: Array[Node3D] ## Nodes in area, but may not be visible w raycast.
var _visible: Array[Node3D] ## Nodes in area and visible w raycast.
var _confidence: Dictionary[Node3D, float]
var _last_position: Dictionary[Node3D, Vector3]

func _ready() -> void:
	set_physics_process(false)
	
	area_entered.connect(_entered)
	area_exited.connect(_exited)
	body_entered.connect(_entered)
	body_exited.connect(_exited)

func is_detecting() -> bool:
	return _visible.size() > 0

func get_nearest(point: Vector3) -> Node3D:
	var dist := INF
	var near: Node3D = null
	for area in _visible:
		var d := point.distance_to(area.global_position)
		if d < dist:
			dist = d
			near = area
	return near

func get_last_position(area: Node3D, default := Vector3.ZERO) -> Vector3:
	return _last_position.get(area, default)

func _entered(node: Node3D):
	if node in ignore: return
	if node == owner: return
	if not node in _nodes:
		_nodes.append(node)
		if _nodes.size() == 1:
			set_physics_process(true)

func _exited(node: Node3D):
	if node in ignore: return
	if node == owner: return
	if node in _nodes:
		_nodes.erase(node)
		if _invisible(node):
			visible_changed.emit()
		if _nodes.size() == 0:
			set_physics_process(false)

func _physics_process(_delta: float) -> void:
	var _visible_changed := false
	
	for node in _nodes:
		if _is_ray_path_clear(node):
			_confidence[node] = _confidence.get(node, 0.0) + 1.0
			
			if not node in _visible:
				_visible.append(node)
				entered.emit(node)
				_visible_changed = true
				if _visible.size() == 1:
					started.emit()
			
			var last: Vector3 = _last_position.get(node, Vector3.ZERO)
			var curr := node.global_position
			if last != curr:
				_last_position[node] = curr
				moved.emit(node)
		else:
			_confidence[node] = _confidence.get(node, 0.0) - 0.1
			if _confidence[node] < 0.0:
				_confidence[node] = 0.0
				if _invisible(node):
					_visible_changed = true
	
	if _visible_changed:
		visible_changed.emit()

func _invisible(node: Node3D):
	if not node in _visible: return
	
	var _detected_changed := false
	_visible.erase(node)
	exited.emit(node)
	_detected_changed = true
	if _visible.size() == 0:
		ended.emit()
	
	# Remove last position from trackers after a minute?
	Global.wait(60.0, func():
		if not node in _nodes:
			_last_position.erase(node))
	
	return _detected_changed

func _is_ray_path_clear(_target: Node3D) -> bool:
	return true
	#var from := global_position
	#var targ_pos := target.global_position
	#var targ_radius := ((target.get_child(0) as CollisionShape3D).shape as SphereShape3D).radius
	#var space_state := get_world_3d().direct_space_state
	#const RAY_COUNT := 3
	#for i in RAY_COUNT:
		#var to := targ_pos + targ_radius * Rand.point_on_sphere() * (i / float(RAY_COUNT))
		#var query := PhysicsRayQueryParameters3D.create(from, to, 1 << 1)
		#query.exclude = [self, target]  # Ignore ear/source
		#var result := space_state.intersect_ray(query)
		#if result:
			#return false
	#return true

```

# res://scripts/nodes/elevator.gd
```gd
extends Node3D

@onready var origin: Vector3 = global_position
@onready var target: Vector3 = get_node("target").global_position

#var _anim := 0.0
#
#func _physics_process(delta: float) -> void:
	#_anim += delta
	#if mount.is_mounted():
		#global_position = global_position.slerp(lerp(origin, target, absf(sin(_anim))), 10.0 * delta)
	#else:
		#global_position = global_position.move_toward(origin, 5.0 * delta)
#
#func _can_interact(_con: Controllable) -> bool:
	#return not mount.is_mounted()
#
#func _interacted(con: Controllable):
	#if mount.is_mounted():
		#pass
	#else:
		#mount.controllable = con

```

# res://scripts/nodes/humanoid.gd
```gd
class_name Humanoid extends Agent

func pickup(_item_node: ItemNode):
	print("TODO: PICKUP")
	#var dummy := MeshInstance3D.new()
	#get_tree().current_scene.add_child(dummy)
	#dummy.mesh = BoxMesh.new()
	#dummy.mesh.size = Vector3.ONE * .2
	#dummy.layers = 1<<1
	#var camera := player_controller.camera_master.target.get_parent()
	#var remote := RemoteTransform3D.new()
	#camera.add_child(remote)
	#remote.remote_path = dummy.get_path()
	#remote.position = Vector3(-0.2, -0.2, -0.2)
	
	#_held_item = item_node
	#_held_item.item._node_equipped(_held_item)
	#_held_item.mount = self
	#_held_item.process_mode = Node.PROCESS_MODE_DISABLED
	#
	#_held_item_remote = RemoteTransform3D.new()
	#camera.add_child(_held_item_remote)
	#_held_item_remote.name = "held_item"
	#_held_item_remote.update_scale = false
	#_held_item_remote.update_rotation = true
	#_held_item_remote.update_position = true
	#_held_item_remote.global_position = _held_item.global_position
	#_held_item_remote.global_basis = _held_item.global_basis
	#_held_item_remote.remote_path = _held_item.get_path()
	
	#UTween.parallel(self, {
		#"_held_item_remote:position": Vector3(0.2, -0.2, -0.2),
		#"_held_item_remote:basis": Basis.IDENTITY
	#}, 0.1)

func stand():
	_next_prone_state = ProneState.Stand
	UTween.parallel(self, {
		#"%head:position:y": 1.5,
		"%collision_shape:position:y": 1.0,
		"%collision_shape:shape:height": 2.0}, 0.2, &"prone").finished.connect(func():
		prone_state = ProneState.Stand
		prone_state_changed.emit())

func crouch():
	_next_prone_state = ProneState.Crouch
	UTween.parallel(self, {
		#"%head:position:y": 0.5,
		"%collision_shape:position:y": 0.5,
		"%collision_shape:shape:height": 1.0 }, 0.2, &"prone").finished.connect(func():
		prone_state = ProneState.Crouch
		prone_state_changed.emit())
	
func crawl():
	_next_prone_state = ProneState.Crawl
	UTween.parallel(self, {
		#"%head:position:y": 0.2,
		"%collision_shape:position:y": 0.25,
		"%collision_shape:shape:height": 0.5}, 0.2, &"prone").finished.connect(func():
		prone_state = ProneState.Crawl
		prone_state_changed.emit())

```

# res://scripts/nodes/humanoid_animator.gd
```gd
@tool
extends Node3D

@export var humanoid: Humanoid: set=set_humanoid
@export var highlightable: Array[MeshInstance3D]
@export var highlight := false: set=set_highlight
@onready var _tree: AnimationTree = %animation_tree
var _walk_blend := 0.0
var _highlight_material: Material

func _ready() -> void:
	if Engine.is_editor_hint():
		set_process(false)

func set_humanoid(h: Humanoid):
	humanoid = h
	if not humanoid:
		set_process(false)
		return
	if not Engine.is_editor_hint():
		_connect.call_deferred()

func _connect():
	set_process(not Engine.is_editor_hint())
	humanoid.jumped.connect(func(): travel(&"Jump"))
	humanoid.landed.connect(func(_m: float = 0.0): travel(&"Standing"))
	humanoid.prone_state_changed.connect(func():
		match humanoid.prone_state:
			Humanoid.ProneState.Stand: travel(&"Standing")
			Humanoid.ProneState.Crouch: travel(&"Crouching")
			Humanoid.ProneState.Crawl: travel(&"Crawling")
		)
	humanoid.head_looked_at.connect(func(at: Vector3): %lookat_head.global_position = at)
	humanoid.head_looking_amount_changed.connect(func(amount: float): %head.influence = amount)
	humanoid.interactive_node.highlight_changed.connect(func():
		match humanoid.interactive_node.highlight:
			Interactive.Highlight.NONE: highlight = false
			Interactive.Highlight.FOCUSED: highlight = true
		)
	humanoid.trigger_animation.connect(travel)
	
func set_highlight(h: bool):
	highlight = h
	if highlight:
		_highlight_material = load("res://assets/materials/highlighted.tres")
		_highlight_material.albedo_color.a = 0.0
		_highlight_material.stencil_color.a = 0.0
		UTween.parallel(self, {
			"_highlight_material:albedo_color:a": 0.2,
			"_highlight_material:stencil_color:a": 1.0 }, 0.2)
		for mesh in highlightable:
			mesh.material_overlay = _highlight_material
	elif _highlight_material:
		UTween.parallel(self, {
			"_highlight_material:albedo_color:a": 0.0,
			"_highlight_material:stencil_color:a": 0.0 }, 0.2)\
		.finished.connect(func():
			for mesh in highlightable:
				mesh.material_overlay = null
			_highlight_material = null)

func travel(to: StringName):
	var sm: AnimationNodeStateMachinePlayback = _tree.get(&"parameters/main/playback")
	sm.travel(to)

func _process(delta: float) -> void:
	if not humanoid: return
	_walk_blend = lerpf(_walk_blend, humanoid.movement.length(), 15.0 * delta)
	_tree.set(&"parameters/main/Standing/blend_position", _walk_blend)
	_tree.set(&"parameters/main/Crouching/blend_position", _walk_blend)
	_tree.set(&"parameters/main/Crawling/blend_position", _walk_blend)

```

# res://scripts/nodes/interactive.gd
```gd
@tool @icon("res://addons/odyssey/icons/interactive.svg")
class_name Interactive extends Area3D

signal toggled()
signal toggled_on()
signal toggled_off()
signal charge_started()
signal charge_percent(amnt: float)
signal charge_ended()
signal interacted(pawn: Pawn, form: Form)
signal highlight_changed()

enum Form { INTERACT, ENTERED, EXITED }
enum ToggleIterationMode { FORWARD, BACKWARD, RANDOM }
enum Highlight { NONE, FOCUSED }

@export var label: String = "Interact"
@export var label_world_space_offset := Vector3.ZERO
@export var humanoid_lookat_offset := Vector3.ZERO
var can_interact := func(_pawn: Pawn): return true

@export var disabled := false:
	get: return not monitorable
	set(d): monitorable = not d

@export var highlight := Highlight.NONE:
	set(h):
		highlight = h
		highlight_changed.emit()

@export_group("Toggleable")
@export var toggleable := false:
	get: return toggle_states != 0
	set(t):
		if t:
			if toggle_states == 0:
				toggle_states = 1
		else:
			toggle_states = 0
@export var on := false:
	get: return toggle_state != 0
	set(o):
		if o:
			if toggle_state == 0:
				toggle_state = 1
		else:
			toggle_state = 0
@export var toggle_states := 0 ## 0 == no toggle. 1 = on/off.
@export var toggle_state := 0:
	set(t):
		toggle_state = t
		if toggle_state == 0:
			toggled_off.emit()
		else:
			toggled_on.emit()
		toggled.emit()
@export var toggle_labels: PackedStringArray = ["Interact [Turn Off]", "Interact [Turn On]"]
@export var toggle_iteration_mode := ToggleIterationMode.FORWARD ## Only when toggle_states > 0.
@export var toggle_iteration_loop := true ## Loop or clamp.
var toggle_count := 0 ## How many times interactive was toggled.
var _toggle_next := 0 ## Next state we will enter. Needed for setting accurate labels.

@export_group("Chargeable")
@export var chargeable := false: ## Based on charge_time state. 0.0 == false.
	get: return charge_time != 0.0
	set(c):
		if c:
			if charge_time == 0.0:
				charge_time = 1.0
		else:
			charge_time = 0.0
@export var charge_time := 0.0 ## Seconds to hold interact down.
@export var charge_instant_reset := true
@export var charge_increase_scale := 1.0
@export var charge_decrease_scale := 1.0
var _charging := false
var _charge_time := 0.0
var _charge_pawn: Pawn
var _charge_form: Form

@export_group("Enterable & Exitable")
@export var interact_on_enter := false ## Interaction occurs when object enters.
@export var interact_on_exit := false ## Interaction occurs when object leaves.
@export_custom(PROPERTY_HINT_EXPRESSION, "") var ioe_expression: String ## Expression to test if interact_on_enter == true.
@export var ioe_delay := 0.1 ## Slight time delay, so it's not instant. If no longer inside, this cancels interaction.
@export var ioe_scene: PackedScene ## A scene to swap to if interaction occurs.

func _init() -> void:
	add_to_group(&"Interactive")
	monitoring = false
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(10, true)

func _ready() -> void:
	body_entered.connect(_entered)
	body_exited.connect(_exited)
	set_process(false)

func _entered(body: Node3D):
	if not interact_on_enter: return
	if ioe_delay == 0:
		interact(body, Form.ENTERED)
	else:
		Global.wait(ioe_delay, func():
			if body in get_overlapping_bodies():
				interact(body, Form.ENTERED))

func _exited(body: Node3D):
	if not interact_on_exit: return
	if ioe_delay == 0:
		interact(body, Form.EXITED)
	else:
		Global.wait(ioe_delay, func():
			if not body in get_overlapping_bodies():
				interact(body, Form.EXITED))

func interact(pawn: Pawn, form := Form.INTERACT):
	if not can_interact.call(pawn): return
	if charge_time == 0:
		_interacted(pawn, form)
	else:
		_charging = true
		_charge_pawn = pawn
		_charge_form = form
		charge_started.emit()
		set_process(true)

## Cancel the interaction.
## Only used when hold_time != 0.0
func cancel(pawn: Pawn):
	if _charging and pawn == _charge_pawn:
		_charging = false
		_charge_pawn = null
		charge_ended.emit()

func _process(delta: float) -> void:
	if _charging:
		_charge_time += delta * charge_increase_scale
		if _charge_time >= charge_time:
			set_process(false)
			_charge_time = charge_time
			_interacted(_charge_pawn, _charge_form)
			_charge_pawn = null
	else:
		if charge_instant_reset:
			_charge_time = 0.0
		else:
			_charge_time -= delta * charge_decrease_scale
		
		if _charge_time <= 0.0:
			set_process(false)
			_charge_time = 0.0
	
	var percent := remap(_charge_time, 0.0, charge_time, 0.0, 1.0)
	charge_percent.emit(percent)
	print(percent)

func _interacted(pawn: Pawn, form: Form) -> void:
	interacted.emit(pawn, form)
	
	if toggleable:
		toggle_count += 1
		toggle_state = _toggle_next
		match toggle_iteration_mode:
			ToggleIterationMode.FORWARD: _toggle_next += 1
			ToggleIterationMode.BACKWARD: _toggle_next -= 1
			ToggleIterationMode.RANDOM: _toggle_next = randi() % toggle_states
			
		if toggle_iteration_loop:
			_toggle_next = wrapi(_toggle_next, 0, toggle_state)
		else:
			_toggle_next = clampi(_toggle_next, 0, toggle_states)
		
		# Label is what happens *next*
		label = toggle_labels[_toggle_next]
	
	if interact_on_enter and ioe_scene:
		get_tree().change_scene_to_packed(ioe_scene)

```

# res://scripts/nodes/item_inventory_node.gd
```gd
extends Node

@export var inventory: StringName
@export var interactive: Interactive

```

# res://scripts/nodes/item_node.gd
```gd
class_name ItemNode extends RigidBody3D

#signal damage_dealt(info: DamageInfo)

@export var item: ItemInfo
@export_custom(PROPERTY_HINT_EXPRESSION, "") var debug_properties_yaml: String
#@export var _state: Dictionary[StringName, Variant]
@export var mount: Node3D: set=set_mount ## Humanoid or ItemMount.
@onready var animation_player: AnimationPlayer = %animation_player
@onready var animation_tree: AnimationTree = %animation_tree
@onready var interactive: Interactive = %interactive
@export var highlight := false: set=set_highlight
@export var highlightable: Array[Node3D]
var _highlight_material: Material
var _reset_state := false
var _reset_transform: Transform3D

func _ready() -> void:
	var yaml := YAML.parse(debug_properties_yaml)
	if not yaml.has_error():
		var props: Variant = yaml.get_data()
		if props is Dictionary:
			for prop in props:
				if prop in self:
					self[prop] = props[prop]
	
	interactive.highlight_changed.connect(_highlight_changed)
	interactive.interacted.connect(_interacted)
	interactive.can_interact = _can_interact

func _highlight_changed():
	highlight = interactive.highlight == Interactive.Highlight.FOCUSED

func set_highlight(h: bool):
	highlight = h
	if highlight and not mount:
		_highlight_material = Assets.get_material(&"highlighted")
		_highlight_material.albedo_color.a = 0.0
		_highlight_material.stencil_color.a = 0.0
		UTween.parallel(self, {
			"_highlight_material:albedo_color:a": 0.2,
			"_highlight_material:stencil_color:a": 1.0 }, 0.2)
		for mesh in highlightable:
			mesh.material_overlay = _highlight_material
	elif _highlight_material:
		UTween.parallel(self, {
			"_highlight_material:albedo_color:a": 0.0,
			"_highlight_material:stencil_color:a": 0.0 }, 0.2)\
		.finished.connect(func():
			for mesh in highlightable:
				mesh.material_overlay = null
			_highlight_material = null)

func _can_interact(pawn: Pawn) -> bool:
	return pawn.node is Humanoid

func _interacted(pawn: Pawn, _form: Interactive.Form):
	if pawn.node is Humanoid:
		pawn.node.pickup(self)

func set_mount(to: Node3D):
	if mount == to: return
	mount = to
	if mount:
		freeze = true
		sleeping = true
		collision_layer = 0
		for h in highlightable:
			if "layers" in h:
				h.layers = 1 << 1
			if "material_overlay" in h:
				h.material_overlay = null
		highlight = false
	else:
		freeze = false
		sleeping = false
		collision_layer = 1 << 1
		for h in highlightable:
			if "layers" in h:
				h.layers = 1 << 0

func anim_travel(anim_id: StringName):
	var playback: AnimationNodeStateMachinePlayback = animation_tree.get(&"parameters/playback")
	playback.travel(anim_id)

func _integrate_forces(physics_state: PhysicsDirectBodyState3D) -> void:
	if _reset_state:
		physics_state.transform = _reset_transform
		_reset_state = false

func reset_state(trans: Transform3D):
	_reset_state = true
	_reset_transform = trans

```

# res://scripts/nodes/marker.gd
```gd
class_name Marker extends Node3D

#func _ready() -> void:
	#visibility_changed.connect(func(): (Controllers.EV_SHOW_MARKER if visible else Controllers.EV_HIDE_MARKER).emit(self))
	#tree_entered.connect(Controllers.EV_SHOW_MARKER.emit.bind(self))
	#tree_exited.connect(Controllers.EV_HIDE_MARKER.emit.bind(self))
	#Controllers.EV_SHOW_MARKER.fire.call_deferred(self)

```

# res://scripts/nodes/minimap.gd
```gd
@tool
class_name Minimap extends Control

const SAVE_DIR := "res://assets/_debug"

@export_tool_button("Load All") var _tool_load_all := load_all_cells
@export var minimap: MinimapData

func clear_cells():
	var cell_parent := %cells
	for child in cell_parent.get_children():
		cell_parent.remove_child(child)
		child.queue_free()

func load_all_cells():
	clear_cells()
	if not minimap: return
	var dir := SAVE_DIR.path_join(minimap.scene.get_basename().get_file())
	var cell_parent := %cells
	for cell in minimap.cells:
		var cell_node := TextureRect.new()
		cell_parent.add_child(cell_node)
		cell_node.owner = self
		cell_node.name = "%s %s %s" % [cell.x, cell.y, cell.z]
		cell_node.texture = load(dir.path_join("%s_%s_%s.%s" % [cell.x, cell.y, cell.z, minimap.texture_format]))
		cell_node.position = Vector2(cell.y, cell.z) * Vector2(minimap.texture_size)

```

# res://scripts/nodes/minimap_generator.gd
```gd
@tool
class_name MinimapGenerator extends SubViewport
## WARNING: Cells are stores as (z, x, y)

const CAMERA_HEIGHT := 10.0
const SAVE_DIR := "res://assets/_debug"

@export var packed_scene: PackedScene
@export_enum("webp", "png", "jpg") var texture_format := "webp"
@export var cell_meters := 16.0 ## Are of game space to render per cell.
@export var cell_pixels := 512 ## Texture size.

@export_tool_button("Run") var run := func():
	size = Vector2i(cell_pixels, cell_pixels)
	
	var scene := packed_scene.instantiate()
	scene.process_mode = Node.PROCESS_MODE_DISABLED
	add_child(scene)
	print("Generating minimap for %s." % scene.scene_file_path)
	
	var camera: Camera3D = %camera
	camera.size = cell_meters
	camera.make_current()
	
	# Collect occupied cells.
	var cells: Array[Vector3i]
	var navs := scene.find_children("", "NavigationRegion3D", true, true)
	for nav: NavigationRegion3D in navs:
		var verts := nav.navigation_mesh.get_vertices()
		for i in nav.navigation_mesh.get_polygon_count():
			var poly := nav.navigation_mesh.get_polygon(i)
			# convert polygon to Vector2 list (X,Z)
			var poly2d := []
			var min_x := 1e9
			var max_x := -1e9
			var min_z := 1e9
			var max_z := -1e9
			for idx in poly:
				var v: Vector3 = verts[idx]
				poly2d.append(Vector2(v.x, v.z))
				min_x = min(min_x, v.x)
				max_x = max(max_x, v.x)
				min_z = min(min_z, v.z)
				max_z = max(max_z, v.z)
			var start_x := int(floor(min_x / cell_meters))
			var end_x   := int(floor(max_x / cell_meters))
			var start_z := int(floor(min_z / cell_meters))
			var end_z   := int(floor(max_z / cell_meters))
			for cx in range(start_x, end_x + 1):
				for cz in range(start_z, end_z + 1):
					var center := Vector2(cx, cz) * (cell_meters + cell_meters * 0.5)
					var cell := Vector3i(0, cx, cz)
					if not cell in cells and Geometry2D.is_point_in_polygon(center, poly2d):
						cells.append(cell)
	
	if not cells:
		push_error("No cells. Is there a NavigationRegion3d?")
		return
	
	cells.sort()
	
	var scene_name := scene.scene_file_path.get_basename().get_file()
	var save_dir := SAVE_DIR.path_join(scene_name)
	var err := DirAccess.make_dir_recursive_absolute(save_dir)
	if err != OK:
		push_error("Couldn't create dir: %s" % save_dir)
		return
	
	var save_path: String
	
	for cell in cells:
		camera.global_position = Vector3(
			(cell.y * cell_meters) + cell_meters * .5,
			CAMERA_HEIGHT,
			(cell.z * cell_meters) + cell_meters * .5)
		await get_tree().process_frame
		var img := get_texture().get_image()
		save_path = save_dir.path_join("%s_%s_%s.%s" % [cell.x, cell.y, cell.z, texture_format])
		match texture_format:
			"webp": err = img.save_webp(save_path)
			"png": err = img.save_png(save_path)
			"jpg": err = img.save_jpg(save_path)
		if err != OK:
			push_error("Couldn't save %s." % save_path)
		else:
			print("Saved cell: %s." % save_path)
	
	var res := MinimapData.new()
	res.scene = scene.scene_file_path
	res.cells = cells
	res.meters = camera.size
	res.texture_size = size
	res.texture_format = texture_format
	save_path = save_dir.path_join("minimap.tres")
	ResourceSaver.save(res, save_path)
	print("Saved data: %s." % save_path)
	
	remove_child(scene)
	scene.queue_free()

```

# res://scripts/nodes/mount.gd
```gd
class_name Mount extends Node3D
## Object that can handle multiple Pawns.

@export var interactive: Interactive
@export var max_occupants := 1_000
@export var states: Array[PawnState]
var _occupants: Array[Pawn]

func _ready() -> void:
	interactive.can_interact = _can_interact
	interactive.interacted.connect(_interacted)

func _interacted(pawn: Pawn, _form: Interactive.Form):
	_occupants.append(pawn)
	
	var mount := Pawn.new()
	mount.name = pawn.name + "_mount"
	for state in states:
		var pstate := state.duplicate()
		pstate.dummy = false
		pstate.pawn = mount
		mount.add_state(state)
	add_child(mount)
	mount.set_rider.call_deferred(pawn)

func _can_interact(_pawn: Pawn) -> bool:
	return _occupants.size() < max_occupants

```

# res://scripts/nodes/pawn.gd
```gd
@tool
@icon("res://addons/odyssey/icons/pawn.svg")
class_name Pawn extends Node3D
## Controllable by Player or NPC.
## Mountable by other Pawns.

signal posessed(con: Controller)
signal unposessed(con: Controller)
signal rider_mounted(r: Pawn)
signal rider_unmounted(r: Pawn)
signal mounted(ride: Pawn)
signal unmounted(ride: Pawn)

@export var node: Node:
	get: return node if node else self
@export var rider_interact: Interactive ## Interactive that takes control.
@export var rider_unmount_area: Area3D ## Area to scan if attempting to unmount.
var rider: Pawn: set=set_rider ## Set internally. TODO: Set from scene.
var controller: Controller
var player_controller: ControllerPlayer:
	get: return controller
var _mount: Pawn: set=set_mount ## What we are riding.

@export var states: Array[PawnState]
var _active_states: Array[PawnState]

func _init() -> void:
	add_to_group(&"Pawn")

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
	
	if Engine.is_editor_hint(): return
	
	if node.name == "player":
		Controllers.player.set_pawn.call_deferred(self)
	elif node.name.begins_with("npc_"):
		Controllers.get_or_create_npc(node.name).set_pawn.call_deferred(self)
	
	if rider_interact:
		rider_interact.interacted.connect(_rider_interacted)
	
	for state in states:
		state.set_pawn(self)

func add_state(s: PawnState):
	states.append(s)
	s.set_pawn(self)

func enable_state(s: PawnState):
	if s in _active_states: return
	_active_states.append(s)
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)

func disable_state(s: PawnState):
	if not s in _active_states: return
	_active_states.erase(s)
	if _active_states.size() > 0: return
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)

func can_unmount() -> bool:
	if rider_unmount_area:
		if rider_unmount_area.get_overlapping_bodies().size() > 0:
			return false
	return true

func _process(delta: float) -> void:
	for s in _active_states:
		s._process(delta)

func _physics_process(delta: float) -> void:
	for s in _active_states:
		s._physics_process(delta)

func _unhandled_input(event: InputEvent) -> void:
	for s in _active_states:
		s._unhandled_input(event)

func _rider_interacted(pawn: Pawn, _form: Interactive.Form):
	set_rider(pawn)

func get_controller_recursive() -> Controller:
	return rider.controller if rider else controller

func _posessed(con: Controller) -> void:
	print("[%s controls %s]" % [con.name, node.name])
	controller = con
	posessed.emit(con)

func _unposessed() -> void:
	unposessed.emit(controller)
	controller = null

func is_controlled() -> bool: return controller != null
func is_player() -> bool: return controller is ControllerPlayer
func is_npc() -> bool: return controller is ControllerNPC
func is_ridden() -> bool: return rider != null
func is_mounted() -> bool: return _mount != null

#func set_frozen(f):
	#if frozen == f: return
	#if frozen: unfroze.emit()
	#frozen = f
	#if frozen: froze.emit()

func set_mount(m: Pawn):
	if _mount == m: return
	if _mount:
		if not can_unmount():
			push_error("Can't unmount.")
			return
		unmounted.emit(_mount)
	_mount = m
	if _mount: mounted.emit(_mount)

func set_rider(r: Pawn):
	if rider == r: return
	if rider: # Unmount old.
		# Take back control.
		if is_controlled():
			controller.set_pawn.call_deferred(rider)
		rider._mount = null
		rider_unmounted.emit(rider)
	rider = r
	if rider: # Remound new.
		# Give control to rider.
		if rider.is_controlled():
			rider.controller.set_pawn.call_deferred(self)
		rider._mount = self
		rider_mounted.emit(rider)
	

```

# res://scripts/nodes/projectile.gd
```gd
class_name Projectile extends Node3D

static func create(at: Vector3, to: Vector3, speed := 1.0, shape := false) -> Projectile:
	var node: Node3D = (ShapeCast3D if shape else RayCast3D).new()
	node.set_script(Projectile)
	Global.get_tree().current_scene.add_child(node)
	node.global_position = at
	node.dir = (to - at).normalized()
	node.spd = speed
	if shape:
		var shp: ShapeCast3D = node
		shp.shape = SphereShape3D.new()
	else:
		var ray: RayCast3D = node
		ray.collide_with_areas = true
		ray.collision_mask = (1 << 0) | (1 << 10)
		ray.target_position = node.dir * speed
	return convert(node, TYPE_OBJECT)

var dir := Vector3.FORWARD
var spd := 1.0

func _process(_delta: float) -> void:
	if call(&"is_colliding"):
		set_process(false)
		global_position = call(&"get_collision_point")
		var obj: Object = call(&"get_collider")
		if obj is Damageable:
			obj.damage(10.0)
		
		await get_tree().create_timer(1.0).timeout
		queue_free()
	else:
		global_position += dir * spd

```

# res://scripts/nodes/remote_transform_3d_tweened.gd
```gd
class_name RemoteTransform3DTweened extends RemoteTransform3D
## Instead of snapping, remote_node is lerped into place first.
## Can also call move_to_local() manually to set a new position.

signal finished()

@export var remote_node: Node3D: set=set_node
@export var tween_duration := 0.5
@export var tween_trans := Tween.TRANS_SINE
@export var tween_ease := Tween.EASE_IN_OUT
var _tween: Tween

func set_node(n: Node3D):
	if remote_node == n: return
	remote_node = n
	remote_path = get_path_to(n)
	
	if not remote_node: return
	
	var end_pos := position
	var end_rot := basis
	global_position = remote_node.global_position
	global_rotation = remote_node.global_rotation
	move_to_local(end_pos, end_rot)

func move_to_local(end_pos: Vector3, end_rot: Basis):
	var start_pos := position
	var start_rot := basis
	if _tween: _tween.kill()
	_tween = create_tween()
	_tween.set_trans(tween_trans)
	_tween.set_ease(tween_ease)
	_tween.tween_method(func(blend: float):
		position = start_pos.lerp(end_pos, blend)
		basis = start_rot.slerp(end_rot, blend)
		, 0.0, 1.0, tween_duration)
	_tween.finished.connect(finished.emit)

```

# res://scripts/nodes/simple_car.gd
```gd
extends Vehicle

@export_group("Speed")
@export var max_speed := 50.0
@export var acceleration := 120.0
var vehicle_linear_velocity := 0.0

@export_group("Steering & Brake")
@export var steering_speed := 1.5
@export var max_steering_angle := 0.65
@export var brake_force := 5.0

@export_group("Lights")
@onready var light_front_driver: SpotLight3D = %light_front_driver
@onready var light_front_passenger: SpotLight3D = %light_front_passenger
@onready var light_brake_driver: OmniLight3D = %light_brake_driver
@onready var light_brake_passenger: OmniLight3D = %light_brake_passenger
@onready var front_lights: Array[SpotLight3D] = [light_front_driver, light_front_passenger]
@onready var brake_lights: Array[OmniLight3D] = [light_brake_driver, light_brake_passenger]

@export_group("Wheels")
@onready var wheel_front_driver: VehicleWheel3D = %wheel_front_driver
@onready var wheel_front_passenger: VehicleWheel3D = %wheel_front_passenger
@onready var wheel_back_driver: VehicleWheel3D = %wheel_back_driver
@onready var wheel_back_passenger: VehicleWheel3D = %wheel_back_passenger
@onready var wheels: Array[VehicleWheel3D] = [wheel_front_driver, wheel_front_passenger, wheel_back_driver, wheel_back_passenger]

@export_group("Suspension Setting")
@export var wheel_friction := 10.5
@export var suspension_stiff_value := 0.0

@export_group("Stability Control")
@export var roll_influence := 0.5
var anti_roll_torque: Vector3
var downforce: Vector3
@export var anti_roll_force := 20.0
@export var downforce_factor := 50.0

@export_group("Audio")
@onready var aux_engine: AudioStreamPlayer3D = %aux_engine
var engine_rev := 0.0

func _physics_process(delta: float) -> void:
	# Steering.
	var vehicle: VehicleBody3D = self as Object as VehicleBody3D
	vehicle.steering = move_toward(vehicle.steering, -move.x * max_steering_angle, delta * steering_speed)
	
	# Engine force.
	vehicle_linear_velocity = vehicle.linear_velocity.length()
	var speed_factor := 1.0 - minf(vehicle_linear_velocity / max_speed, 1.0)
	vehicle.engine_force = -move.y * acceleration * speed_factor
	
	# Anti-Roll
	anti_roll_torque = -global_transform.basis.z * global_rotation.z * anti_roll_force * max_speed
	vehicle.apply_torque(anti_roll_torque)
	
	# Speed based downforce
	downforce = -global_transform.basis.y * vehicle_linear_velocity * downforce_factor
	vehicle.apply_central_force(downforce)
	
	# Apply to all wheels.
	for wheel in wheels:
		wheel.wheel_roll_influence = roll_influence
	
	# Handbrake.
	if _brake_pressed:
		vehicle.brake = lerpf(vehicle.brake, brake_force, delta * 5.0)
		for light in brake_lights:
			light.visible = true
	else:
		vehicle.brake = 0.0
		for light in brake_lights:
			light.visible = false
	
	var engine_rev_idle := 0.9
	var engine_rev_max := 1.5
	if move.y > 0.5 or move.y < -0.5:
		engine_rev += 3.0 * delta
		if engine_rev > engine_rev_max:
			engine_rev = engine_rev_max
	else:
		engine_rev -= 5.0 * delta
		if engine_rev < engine_rev_idle:
			engine_rev = engine_rev_idle
	
	aux_engine.pitch_scale = engine_rev

func honk():
	%aux_horn.play()

func _process(_delta: float) -> void:
	for wheel in wheels:
		wheel.wheel_friction_slip = wheel_friction
		wheel.suspension_stiffness = suspension_stiff_value

#func _posessed(con: Controller) -> void:
	#super(con)
	#if not aux_engine.playing:
		#aux_engine.play()
	#
	#for light in front_lights:
		#light.visible = true
#
#func _unposessed() -> void:
	#super()
	#if aux_engine.playing:
		#aux_engine.stop()
	#
	#for light in front_lights:
		#light.visible = false

```

# res://scripts/nodes/surface_node.gd
```gd
extends Node
## For use with CSG shapes, which don't otherwise have this.

@export var physics_material_override: SurfaceMaterial

```

# res://scripts/nodes/toggle_node.gd
```gd
@tool extends Node

@export var interactive: Interactive: set=set_interactive
@export var on := true:
	get: return interactive.toggle_state == on_state if interactive else false
	set(o):
		if on_state == 0:
			on_state = 1
		else:
			on_state = 0
@export var on_state := 0:
	set(s):
		on_state = s
		_toggled()
@export_custom(PROPERTY_HINT_EXPRESSION, "") var expr_on := ""
@export_custom(PROPERTY_HINT_EXPRESSION, "") var expr_off := ""

func set_interactive(inter: Interactive):
	if interactive:
		interactive.toggled.disconnect(_toggled)
	if inter == null:
		var parent := get_parent()
		if parent is Interactive:
			inter = parent
	interactive = inter
	if interactive:
		interactive.toggled.connect(_toggled)

func _toggled():
	if on:
		_execute_script(expr_on)
	else:
		_execute_script(expr_off)

func _execute_script(expr: String):
	if not is_inside_tree(): return
	var gd := GDScript.new()
	gd.source_code = "@tool\nstatic var this\nstatic func _run(): %s" % [expr.replace("$", "this.")]
	var err := gd.reload()
	if err != OK:
		push_error(self, error_string(err))
		return
	gd.this = self
	gd._run()

```

# res://scripts/nodes/vehicle.gd
```gd
class_name Vehicle extends VehicleBody3D

var _brake_pressed := false ## 
var move := Vector2.ZERO ## X=throttle (forward/backward), Y=steering (left/right)

func honk_start(): return true
func honk_stop(): return true

func brake_start():
	_brake_pressed = true
	return true

func brake_stop():
	_brake_pressed = false
	return true

```

# res://scripts/nodes/widget.gd
```gd
@abstract class_name Widget extends Control

var player_index := 0

## Is only one allowed.
func is_exclusive() -> bool: return true
## Will autohide when non-hud widgits are displayed.
func is_hud() -> bool: return false
## Will pause the game when displayed.
func is_pauser() -> bool: return false
## Will stay visible when a cinematic is playing. (Captions, Choice Menu...)
func is_visible_in_cinematic() -> bool: return false

func close() -> void:
	Controllers.get_player(player_index).hide_widgit(name)

func get_controller() -> ControllerPlayer:
	return Controllers.get_player(player_index)

func _unhandled_key_input(event: InputEvent) -> void:
	get_controller()._event = event

## Used by FlowPlayerGenerator to create keyframes.
func _cinematic_step(_gen: FlowPlayerGenerator, _step: Dictionary) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action(&"exit"):
		(get_parent() as ControllerPlayer).hide_widgit(name)

```

# res://scripts/nodes/zone_area_node.gd
```gd
extends Area3D

@export var trigger_zone := true
@export var zone_id: StringName

@export var toast_on_enter := true
@export var toast_on_exit := false

var bodies: Array[Node3D]
var disabled := false

func _ready() -> void:
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)

func _body_entered(body: Node3D):
	if disabled: return
	disabled = true
	Global.wait(3.0, func(): disabled = false)
	
	if not body is Agent: return
	if body in bodies: return
	bodies.append(body)
	var agent: Agent = body
	if trigger_zone and zone_id:
		var zone := State.find_zone(zone_id)
		var who := agent.char_info
		if not zone or not who: return
		State.ZONE_ENTERED.fire({ zone=zone, who=who })
		var msg := "%s entered %s" % [who.name, zone.name]
		print(msg)
		if toast_on_enter:
			State.TOAST.fire({ type="simple_toast", data={text=msg} })
		
func _body_exited(body: Node3D):
	if not body is Agent: return
	if not body in bodies: return
	bodies.erase(body)
	var agent: Agent = body
	if trigger_zone and zone_id:
		var zone := State.find_zone(zone_id)
		var who := agent.char_info
		if not zone or not who: return
		State.ZONE_EXITED.fire({ zone=zone, who=who }) 
		if toast_on_exit:
			var msg := "%s exited %s" % [who.name, zone.name]
			State.TOAST.fire({ type="simple_toast", data={text=msg} })

```

# res://scripts/nodes/zone_node.gd
```gd
class_name ZoneNode extends Node3D

@export var info: ZoneInfo

```

# res://scripts/overrides.gd
```gd
class_name Overrides

static var version := "v0.0.0"

static var main_menu_title: String
static var main_menu_subtitle: String
static var main_menu_options: Array[Dictionary] = [
	{ id="start", text="Start", pressed=func(): Global.change_scene("res://scenes/worlds/test_world.tscn") },
	{ id="continue", text="Continue" },
	{ id="load", text="Load" },
	{ id="settings", text="Settings" },
	{ id="quit", text="Quit", pressed=func(): Global.get_tree().quit() },
]

```

# res://scripts/resources/assets_db.gd
```gd
@tool
class_name AssetsDB extends Resource

@warning_ignore("unused_private_class_variable")
@export_tool_button("Reload") var _tb_update := reload

@export var audio: Dictionary[StringName, String]
@export var music: Dictionary[StringName, String]
@export var scenes: Dictionary[StringName, String]
@export var materials: Dictionary[StringName, String]

func reload() -> void:
	for d in [audio, music, scenes, materials]:
		d.clear()
	var old_audio := len(audio)
	var old_music := len(music)
	var old_scenes := len(scenes)
	var old_materials := len(materials)
	_scan_dir(audio, "res://assets/audio/", "res://assets/audio", [ "mp3", "wav", "ogg" ])
	_scan_dir(music, "res://assets/music/", "res://assets/music")
	_scan_dir(scenes, "res://scenes/", "res://scenes", [ "tscn", "scn" ])
	_scan_dir(materials, "res://assets/materials/", "res://assets/materials", [ "tres" ])
	
	var new_audio := len(audio)
	var new_music := len(music)
	var new_scenes := len(scenes)
	var new_materials := len(materials)
	var dif_audio := new_audio - old_audio
	var dif_music := new_music - old_music
	var dif_scenes := new_scenes - old_scenes
	var dif_materials := new_materials - old_materials
	var str_audio := "" if dif_audio == 0 else ((" [color=red]-%s[/color]" if dif_audio < 0 else " [color=green]+%s[/color]") % dif_audio)
	var str_music := "" if dif_music == 0 else ((" [color=red]-%s[/color]" if dif_music < 0 else " [color=green]+%s[/color]") % dif_audio)
	var str_scenes := "" if dif_scenes == 0 else ((" [color=red]-%s[/color]" if dif_scenes < 0 else " [color=green]+%s[/color]") % dif_audio)
	var str_materials := "" if dif_materials == 0 else ((" [color=red]-%s[/color]" if dif_materials < 0 else " [color=green]+%s[/color]") % dif_audio)
	print_rich("Prefabs: [i]%s[/i]%s, Audio: [i]%s[/i]%s, Music: [i]%s[/i]%s, Materials: [i]%s[/i]%s" % [
		new_scenes, str_scenes,
		new_audio, str_audio,
		new_music, str_music,
		new_materials, str_materials])

func _scan_dir(paths: Dictionary[StringName, String], head: String, dir: String, ext: Array[String] = []):
	for subdir in DirAccess.get_directories_at(dir):
		_scan_dir(paths, head, dir.path_join(subdir), ext)
	
	for file in DirAccess.get_files_at(dir):
		if file.get_extension() in ext:
			var id := file.get_basename()
			paths[id] = dir.path_join(file).trim_prefix(head)

```

# res://scripts/resources/attribute_db.gd
```gd
class_name AttributeDB extends Database

func get_field_script() -> GDScript:
	return AttributeInfo

```

# res://scripts/resources/attribute_info.gd
```gd
class_name AttributeInfo extends DatabaseObject

@export var max_level: int

```

# res://scripts/resources/award_db.gd
```gd
class_name AwardDB extends Database

func connect_signals() -> void:
	State.event.connect(_event)
	
	for ach: AwardInfo in objects():
		for event_id in ach.events:
			var ev: Event = State[event_id]
			ev.connect_to(ach._ev)

func _event(event: Event):
	match event:
		pass

func get_field_script() -> GDScript:
	return AwardInfo

```

# res://scripts/resources/award_info.gd
```gd
class_name AwardInfo extends DatabaseObject

@export var desc: String
@export var icon: String
@export var hint: String ## Text shown when locked.
@export var events: Array[StringName] ## Events to check condition on.
@export var cond: String ## Condition that when true will unlock.
@export var expr_progress := "" ## Expression for calculating progress.
@export var expr_max_progress := "" ## Expression for calculating max progress.
@export var unlocked: bool
@export var unlocked_date: String = ""
@export var progress: float = -1.0

func connect_signals():
	for event_id in events:
		var event: Event = State[event_id]
		event.connect_to(_event)

func _event(e: Event):
	if unlocked: return
	if not e.id in events: return
	if not State.test(cond): return
	var new_progress: float = State.expression(expr_progress)
	if new_progress == progress: return
	State.AWARD_PROGRESSED.fire({ award=self, old=progress, new=new_progress })
	progress = new_progress
	var max_progress: float = State.expression(expr_max_progress)
	if progress <= max_progress: return
	unlocked = true
	unlocked_date = "TODO"
	State.AWARD_UNLOCKED.fire({ award=self })
	
func set_unlocked(u: bool):
	if unlocked == u: return
	unlocked = u
	
	State.AWARD_UNLOCKED.fire()
	for event_id in events:
		State[event_id].disconnect(_event)

```

# res://scripts/resources/char_db.gd
```gd
class_name CharDB extends Database

func get_object_script() -> GDScript:
	return CharInfo

```

# res://scripts/resources/char_group_db.gd
```gd
class_name CharGroupDB extends Database

func get_object_script() -> GDScript:
	return CharGroupInfo

```

# res://scripts/resources/char_group_info.gd
```gd
class_name CharGroupInfo extends DatabaseObject

@export var desc: String

func get_chars(id: StringName) -> Array[CharInfo]:
	var out: Array[CharInfo]
	for ch: CharInfo in State.chars:
		if id in ch.groups:
			out.append(ch)
	return out

```

# res://scripts/resources/char_info.gd
```gd
class_name CharInfo extends Equipment

@export var desc: String
@export var zone: ZoneInfo
@export var following: CharInfo ## ID of Character being followed.
@export var occupying: StringName ## Furniture, vehicles, traps, machines...
@export var groups: Dictionary[StringName, StatDB]

func add_to_group(group: CharGroupInfo):
	groups[group.id] = StatDB.new()

func remove_from_group(group: CharGroupInfo):
	if not group.id in groups: return
	groups.erase(group.id)

```

# res://scripts/resources/damage_info.gd
```gd
class_name DamageInfo extends Resource

var _source: NodePath
var source: Node3D:
	get: return Global.get_node(_source)
var _target: NodePath
var target: Damageable:
	get: return Global.get_node(_target)
var amount: float
var type: StringName
var position: Vector3
var normal: Vector3

```

# res://scripts/resources/database.gd
```gd
class_name Database extends Resource

@export var _objects: Dictionary[StringName, DatabaseObject]
var _default_state: Dictionary[StringName, Dictionary]

func size() -> int:
	return _objects.size()

## Used by State class.
func connect_signals() -> void:
	pass

func has_notification() -> bool:
	return get_notification_count() > 0

func get_notification_count() -> int:
	var count := 0
	for obj in _objects.values():
		if obj.has_notification():
			count += 1
	return count

func update_default_state():
	_default_state = get_state()

func get_changed_state():
	var state := get_state()
	var out: Dictionary[StringName, Dictionary]
	for item_id in state:
		var item_state := state[item_id]
		if item_id in _default_state:
			var default_state := _default_state[item_id]
			for prop in default_state:
				if item_state[prop] != default_state[prop]:
					if not item_id in out:
						out[item_id] = {}
					out[item_id][prop] = item_state[prop]
	return out
	
func get_state() -> Dictionary[StringName, Dictionary]:
	var out: Dictionary[StringName, Dictionary]
	for item_id in _objects:
		out[item_id] = _objects[item_id].get_state()
	return out

func has(id: StringName) -> bool:
	return id in _objects

func find(id: StringName, default: DatabaseObject = null, silent := false) -> DatabaseObject:
	if has(id):
		return _objects[id]
	if not silent:
		push_error("No item %s in %s. %s" % [id, self, _objects.keys()])
	return default

func find_id(data: DatabaseObject) -> StringName:
	for id in _objects:
		if _objects[id] == data:
			return id
	return &""

func get_ids() -> PackedStringArray:
	return PackedStringArray(_objects.keys())

func merge(db: Database):
	for id in db._objects:
		if id in _objects:
			push_warning("DB Merge: Overriding %s." % id)
		_objects[id] = db._objects[id]

func _add(id: StringName, obj: DatabaseObject, props := {}, silent := false) -> DatabaseObject:
	if id in _objects:
		push_warning("Replacing %s." % [id])
	_objects[id] = UObj.set_properties(obj, props, silent)
	obj.id = id
	return obj

func _get(property: StringName) -> Variant:
	return _objects.get(property, null)

func _iter_init(iter: Array) -> bool:
	iter[0] = 0
	return iter[0] < _objects.size()

func _iter_next(iter: Array) -> bool:
	iter[0] += 1
	return iter[0] < _objects.size()

func _iter_get(iter: Variant) -> Variant:
	return _objects.values()[iter]

func get_object_script() -> GDScript:
	return null

func objects() -> Array[DatabaseObject]:
	return _objects.values()

```

# res://scripts/resources/database_object.gd
```gd
@abstract class_name DatabaseObject extends Resource

@export var id: StringName
@export var name: String
@export var tags: Array[PackedStringArray]

## Used with RichTextLabels.
func _to_rich_string() -> String:
	return "%s" % [name]

func _to_string() -> String:
	return "%s(%s)" % [UObj.get_class_name(self), id]

## Has any tag?
func tagged_any(...tgs: Array) -> bool:
	for tag in tgs: if tag in tags: return true
	return false

## Has all tags?
func tagged(...tgs: Array) -> bool:
	for tag in tgs: if not tag in tags: return false
	return true

## Override. Will mark in database as having had a state change.
func has_notification() -> bool: return false
## Override. Mark as player has seen this.
func clear_notification(): pass
func mark_notification(): pass

func get_state() -> Dictionary[StringName, Variant]:
	var out: Dictionary[StringName, Variant]
	for prop in get_property_list():
		if not UBit.is_enabled(prop.usage, PROPERTY_USAGE_STORAGE): continue
		if UBit.is_enabled(prop.usage, PROPERTY_USAGE_EDITOR): continue
		out[prop.name] = self[prop.name]
	return out

```

# res://scripts/resources/equipment.gd
```gd
class_name Equipment extends Inventory

signal item_equipped(slot: EquipmentSlotInfo, item: InventoryItem)
signal item_unequipped(slot: EquipmentSlotInfo, item: InventoryItem)
signal equipment_changed()

@export var wearing: Dictionary[StringName, InventoryItem]

func is_wearing(slot: StringName) -> bool:
	return slot in wearing

func can_equip(item: InventoryItem, slot_id: StringName = &"") -> bool:
	return slot_id in item.item_info.wear_to

func equip(item: InventoryItem, slot_id: StringName = &""):
	if not can_equip(item, slot_id):
		push_error("Can't equip %s to %s on %s." % [item, slot_id, self])
		return
		
	var slot_info := State.find_equipment_slot(slot_id)
	var bare: Array[StringName]
	bare.append_array(slot_info.bare)
	
	# Unequip if occupied.
	if is_wearing(slot_id):
		bare.append(slot_id)
	
	# Unequip all slots.
	for sid in bare:
		unequip_slot(sid)
	
	var slot_index := items.find(item)
	if slot_index != -1:
		items.remove_at(slot_index)
	
	wearing[slot_id] = item
	item_equipped.emit(slot_info, item)
	equipment_changed.emit()

func unequip_slot(slot_id: StringName):
	if not slot_id in wearing:
		return
	var slot_info := State.find_equipment_slot(slot_id)
	var item := wearing[slot_id]
	wearing.erase(slot_id)
	items.append(item)
	item_unequipped.emit(slot_info, item)
	equipment_changed.emit()

```

# res://scripts/resources/equipment_slot_info.gd
```gd
class_name EquipmentSlotInfo extends DatabaseObject

```

# res://scripts/resources/event.gd
```gd
class_name Event extends RefCounted

signal fired(ev: Event)

var id: StringName ## Set by state base.
var _default: Dictionary[StringName, Variant]
var _current: Dictionary[StringName, Variant]

func _init(props := {}) -> void:
	_default.assign(props)
	for prop in _default:
		if _default[prop] is int:
			_current[prop] = type_convert(null, _default[prop])
		else:
			_current[prop] = type_convert(null, typeof(_default[prop]))

func _get(property: StringName) -> Variant:
	return _current.get(property, null)

func get_bool(property: StringName, default := false) -> bool: return _current.get(property, default)
func get_int(property: StringName, default := 0) -> int: return _current.get(property, default)
func get_float(property: StringName, default := 0.0) -> float: return _current.get(property, default)
func get_str(property: StringName, default := "") -> String: return _current.get(property, default)
func get_str_name(property: StringName, default := &"") -> StringName: return _current.get(property, default)
func get_dict(property: StringName, default := {}) -> Dictionary: return _current.get(property, default)
func get_array(property: StringName, default := []) -> Array: return _current.get(property, default)

func connect_to(method: Callable):
	fired.connect(method)

func test(props: Dictionary) -> bool:
	for prop in props:
		if not prop in _current: continue
		elif _current[prop] is DatabaseObject and typeof(props[prop]) in [TYPE_STRING, TYPE_STRING_NAME]:
			if _current[prop].id != props[prop]: return false
		elif _current[prop] != props[prop]: return false
	return true

func fire(kwargs: Dictionary = {}):
	for prop in kwargs:
		if prop in _default:
			_current[prop] = kwargs[prop]
		else:
			push_warning("Event %s has no property %s. (%s)" % [get_state_property_name(), prop, self])
	State.event.emit(self)
	fired.emit(self)

func get_state_property_name() -> StringName:
	for prop in State.get_property_list():
		if not UBit.is_enabled(prop.usage, PROPERTY_USAGE_SCRIPT_VARIABLE): continue
		if prop.type == TYPE_OBJECT and State[prop.name] == self:
			return prop.name
	return &""

```

# res://scripts/resources/inventory.gd
```gd
class_name Inventory extends DatabaseObject
# TODO: Allow sorting in grid format. Currently it's just a list.

## Sort all slots in the inventory.
enum Sort { 
	NAME_A, ## Name from A to Z.
	NAME_Z, ## Name from Z to A.
	MOST,	## Most to least.
	LEAST	## Least to most.
}

signal item_gained(id: ItemInfo, amount: int)
signal item_lost(id: ItemInfo, amount: int)

@export var items: Array[InventoryItem]
@export var stats := StatDB.new()

# TODO: var max_items: int
# TODO: var max_slots: int
# TODO: var max_weight: int
# TODO: var weight_scale: float # 0.0 -> 1.0 on how heavy.
# TODO: var block_items: Array[StringName]
# TODO: var block_types: Array[StringName]
# TODO: var allow_items: Array[StringName]
# TODO: var allow_types: Array[StringName]

func get_item_slot_count() -> int:
	return items.size()

func clear_items():
	items.clear()

func give_item(other: Inventory, item: Variant, amount := 1):
	if item is StringName:
		lose_item(item, amount)
		other.gain(item, amount)
	elif item is InventoryItem:
		items.erase(item)
		other._items.append(item)
		changed.emit()
		other.changed.emit()

func gain_everything():
	for item in State.objects.items:
		gain_item(item)

func gain_item(item_info: ItemInfo, state: Variant = null):
	var amount: int = state if state is int else 1
	var total_gained := 0
	
	if item_info.is_special():
		for i in amount:
			items.append(InventoryItem.new(item_info, state))
			total_gained += 1
	else:
		# Look for space in other slots.
		for slot in items:
			if slot.item_info == item_info:
				var space_left := slot.get_empty_space()
				var add_amount := mini(space_left, amount)
				slot.amount += add_amount
				changed.emit()
				amount -= add_amount
				total_gained += add_amount
		# Create new slots with remainder.
		if amount > 0:
			for i in ceili(amount / float(item_info.max_per_slot)):
				var add_amount := mini(item_info.max_per_slot, amount)
				items.append(InventoryItem.new(item_info, add_amount))
				changed.emit()
				amount -= add_amount
				total_gained += add_amount
	
	item_gained.emit(item_info, total_gained)

func _gain_stack(stack: InventoryItem):
	if stack is InventoryItem:
		items.append(stack)
	else:
		gain_item(stack.item_info, stack.amount)

func lose_item(item: ItemInfo, amount := 1):
	for i in range(len(items)-1, -1, -1):
		var slot := items[i]
		if slot.item_info == item:
			var sub_amount := mini(slot.amount, amount)
			slot.amount -= sub_amount
			changed.emit()
			amount -= sub_amount
			
			if slot.amount <= 0:
				items.remove_at(i)
				changed.emit()
	
	item_lost.emit(item, amount)

func count_items(item_info: ItemInfo) -> int:
	var total := 0
	for slot in items:
		if slot.item_info == item_info:
			total += slot.amount
	return total

func has_item(item_info: ItemInfo, amount := 1) -> bool:
	return count_items(item_info) >= amount

func sort_items(on: Sort = Sort.NAME_A):
	match on:
		Sort.NAME_A: items.sort_custom(func(a, b): return a.id < b.id)
		Sort.NAME_Z: items.sort_custom(func(a, b): return a.id > b.id)
		Sort.MOST: items.sort_custom(func(a, b): return a.amount > b.amount)
		Sort.LEAST: items.sort_custom(func(a, b): return a.amount < b.amount)
	changed.emit()

## Counts ItemInfoCurrency objects.
func count_currency(currency: StringName) -> int:
	var total := 0
	for slot in items:
		var item_info := slot.item_info
		if item_info._properties.get(&"currency", &"") == currency:
			var currency_amount: int = item_info._properties.get(&"currency_amount", 0)
			total += currency_amount * slot.amount
	return total

```

# res://scripts/resources/inventory_db.gd
```gd
class_name InventoryDB extends Database

const EVENT_GAIN_ITEM := &"GAIN_ITEM"
const EVENT_LOSE_ITEM := &"LOSE_ITEM"
const ALL_EVENTS := [EVENT_GAIN_ITEM, EVENT_LOSE_ITEM]

func connect_signals() -> void:
	Cinema.event.connect(_cinema_event)

func _cinema_event(ev: StringName, data: String):
	if not ev in ALL_EVENTS: return
	var _data_args := data # TODO
	match ev:
		EVENT_GAIN_ITEM: pass
		EVENT_LOSE_ITEM: pass

func get_object_script() -> GDScript:
	return Inventory

```

# res://scripts/resources/inventory_item.gd
```gd
class_name InventoryItem extends Resource

@export var item: StringName
@export var amount: int
@export var state: Dictionary[StringName, Variant]

var item_info: ItemInfo:
	get: return State.find_item(item)
	set(itm): item = itm.item

func _init(itm: ItemInfo, amount_or_state: Variant = 1) -> void:
	item = itm.id
	if itm.is_special():
		for key in itm.default_state:
			state[key] = itm.default_state[key]
		if amount_or_state is Dictionary:
			for key in amount_or_state:
				state[key] = amount_or_state[key]
		else:
			push_error("Can't set state %s for %s." % [amount_or_state, itm])
	else:
		if amount_or_state is int:
			amount = amount_or_state
		else:
			push_error("Can't set amount %s for %s." % [amount_or_state, itm])

func _to_string() -> String:
	return "InventoryItem(%s x%s)" % [item, amount]

## Adds commas. If minimise == true: 1_000 to "1K"
func get_nice_amount(minimise := false) -> String:
	if minimise:
		return UStr.number_abbreviated(amount)
	return UStr.number_with_commas(amount)

func get_empty_space() -> int:
	return maxi(0, item_info.max_per_slot - amount)

```

# res://scripts/resources/item_db.gd
```gd
class_name ItemDB extends Database

func add(id: StringName, name: String, desc := "", props := {}) -> ItemInfo:
	var itm := ItemInfo.new()
	itm.name = name
	itm.desc = desc
	return _add(id, itm, props)

func get_field_script() -> GDScript:
	return ItemInfo

```

# res://scripts/resources/item_info.gd
```gd
class_name ItemInfo extends DatabaseObject

@export var desc: String
@export var max_per_slot: int = 1_000_000_000:
	get: return 1 if is_special() else max_per_slot
@export var wear_to: PackedStringArray ## Equipment slots.
@export var cells: Array[Vector2i] = [Vector2i.ZERO] ## TODO: How wide and high it is.
@export var default_state: Dictionary[StringName, Variant] = {} ## Setting this will mark the item as a special one.
@export var scene_held: PackedScene
@export var stats: StatDB

# TODO: weight: float
# TODO: types: Array[StringName]

## [Currency]
## currency: StringName
## currency_amount: int
##
## [Shooter]
## max_ammo: int = 16
## projectile_item: StringName

var _properties: Dictionary[StringName, Variant]

func _node_equipped(_node: ItemNode) -> bool: return true
func _node_unequipped(_node: ItemNode) -> bool: return true
func _node_use(_node: ItemNode) -> bool: return true
func _node_reload(_node: ItemNode) -> bool: return true

func _to_string() -> String:
	return "Item(%s:%s)" % [id, name]

func _get(property: StringName) -> Variant:
	return _properties.get(property)

func get_texture() -> Texture:
	var path := "res://assets/images/items/%s.png" % id
	if FileAccess.file_exists(path):
		return load(path)
	return null

## Max area the cells occupy.
## The cells array allows for non-rectangular shapes.
var cell_extents: Vector2i:
	get:
		var minn := Vector2i(INF, INF)
		var maxx := Vector2i(-INF, -INF)
		for cell in cells:
			for i in 2:
				minn[i] = mini(minn[i], cell[i])
				maxx[i] = maxi(maxx[i], cell[i])
		var diff := maxx - minn
		return diff

func is_special() -> bool:
	return default_state.size() > 0

```

# res://scripts/resources/minimap_data.gd
```gd
class_name MinimapData extends Resource

@export var scene: String
@export var cells: Array[Vector3i]
@export var meters: float
@export var texture_size: Vector2i
@export var texture_format: String

```

# res://scripts/resources/mod_info.gd
```gd
@tool
class_name ModInfo extends StateObjects

@export var mod_name := "Unnamed Mod"
@export var mod_desc := "Adds features."
@export var mod_author := "Author"
@export var mod_version := "0.0.1"
@export_global_dir var data_dir: String: ## Directory to scan for data files.
	get: return data_dir if data_dir else resource_path.get_base_dir()
@export_multiline var _debug_info := ""
@export var _script_conds: Dictionary[StringName, String]
@export var _script_exprs: Dictionary[StringName, String]

@export var awards: AwardDB

func clear() -> void:
	super()
	awards = AwardDB.new()

func get_persistent_dbs() -> Array[Database]:
	return [awards]

func load_dir(dir: String) -> void:
	data_dir = dir
	_load_dir(dir)
	_debug_info = get_counts_string("\n")

func _load_dir(dir: String) -> void:
	for subdir in DirAccess.get_directories_at(dir):
		_load_dir(dir.path_join(subdir))
	for file in DirAccess.get_files_at(dir):
		var path := dir.path_join(file)
		match file.get_extension():
			"json": _load_json(path)
			"yaml": _load_yaml(path)

func _load_yaml(file: String) -> void:
	var yaml_str := FileAccess.get_file_as_string(file)
	var yaml_result := YAML.parse(yaml_str)
	if yaml_result.has_error():
		push_error(yaml_result.get_error())
		return
	var data: Variant = yaml_result.get_data()
	_load_data(data)

func _load_json(file: String) -> void:
	var json := FileAccess.get_file_as_string(file)
	var data: Variant = JSON.parse_string(json)
	_load_data(data)

func _process_flow(flow_script: FlowScript) -> void:
	var parsed := flow_script.get_parsed()
	for step in parsed.tabbed:
		if step.type == FlowToken.CMND:
			match step.cmnd:
				&"CODE": _add_expr(step.rest)
				&"IF": _add_cond(step.rest)
				&"ELIF": _add_cond(step.rest)
				&"ELSE": _add_cond("true")

func _add_cond(st: String) -> StringName:
	var meth_name := StringName("_cond_%s" % hash(st))
	_script_conds[meth_name] = st
	return meth_name

func _add_expr(st: String) -> StringName:
	var meth_name := StringName("_expr_%s" % hash(st))
	_script_exprs[meth_name] = st
	return meth_name

func _load_data(data: Variant):
	if data is Dictionary: data = [data]
	for dict: Dictionary in data:
		var type: StringName = dict.get(&"TYPE", &"")
		match type:
			&"mod_info":
				mod_name = dict.get(&"name", mod_name)
				mod_desc = dict.get(&"desc", mod_desc)
				mod_author = dict.get(&"author", mod_author)
				mod_version = dict.get(&"version", mod_version)
				
			&"char", &"character":
				var id: StringName = dict.get(&"ID", &"")
				chars._add(id, CharInfo.new(), dict)
			&"char_list", &"characters":
				var char_list: Dictionary = dict.get(type)
				for id in char_list:
					chars._add(id, CharInfo.new(), char_list[id])
			&"item":
				var id: StringName = dict.get(&"ID", &"")
				items._add(id, ItemInfo.new(), dict)
			&"items", &"item_list":
				var item_list: Dictionary = dict.get(type)
				for id in item_list:
					items._add(id, ItemInfo.new(), item_list[id])
			
			&"zone":
				var id: StringName = dict.get(&"ID", &"")
				zones.add(id, dict)
			&"zones":
				var zone_list: Dictionary = dict.get(type)
				for id in zone_list:
					zones.add(id, zone_list[id])
			
			&"award":
				var id: StringName = dict.get(&"ID", &"")
				awards.add(id, dict)
			
			&"quest":
				var id: StringName = dict.get(&"ID", &"")
				var quest := QuestInfo.new()
				quests._add(id, quest)
				
				var ticks: Dictionary = UDict.pop(dict, &"ticks", {})
				var triggers: Dictionary = UDict.pop(dict, &"triggers", {})
				_init_triggers(id, quest.triggers, triggers)
				UObj.set_properties(quest, dict)
				
				for tick_id in ticks:
					var tick_data: Dictionary = ticks[tick_id]
					var tick := QuestTick.new()
					quest.ticks[tick_id] = tick
					var tick_triggers: Dictionary = UDict.pop(tick_data, &"triggers", {})
					_init_triggers(id + "#" + tick_id, tick.triggers, tick_triggers)
					UObj.set_properties(tick, tick_data)
					tick.id = tick_id
					tick.quest_id = id

func _init_triggers(id: StringName, triggers: Dictionary[QuestInfo.QuestState, Array], json: Dictionary):
	for state_id in json:
		var state: QuestInfo.QuestState = QuestInfo.QuestState.keys().find(state_id) as QuestInfo.QuestState
		triggers[state] = []
		var trigger_index := 0
		for trigger_data in json[state_id]:
			var trigger := TriggerInfo.new()
			trigger.event = UDict.pop(trigger_data, &"event", &"")
			trigger.state.assign(UDict.pop(trigger_data, &"state", {}))
			trigger.condition = _add_cond(UDict.pop(trigger_data, &"cond", ""))
			UObj.set_properties(trigger, trigger_data)
			triggers[state].append(trigger)
			
			var path := data_dir.path_join("_dbg-%s-%s-%s" % [ id, state_id, trigger_index])
			var flow_script := FlowScript.new()
			flow_script.code = trigger_data.flow
			print_rich("[color=cyan]" + flow_script.code)
			trigger.flow_script = flow_script
			_process_flow(flow_script)
			ResourceSaver.save(flow_script, path + ".tres")
			
			var player := FlowPlayerGenerator.generate([load(path + ".tres")])
			var packed := PackedScene.new()
			packed.pack(player)
			ResourceSaver.save(packed, path + ".tscn")
			trigger_index += 1

```

# res://scripts/resources/quest_db.gd
```gd
class_name QuestDB extends Database

const EVENT_START := &"QUEST_START"
const EVENT_PASS := &"QUEST_PASS"
const EVENT_FAIL := &"QUEST_FAIL"
const EVENT_TICK := &"QUEST_TICK"
const EVENT_SHOW := &"QUEST_SHOW"
const EVENT_HIDE := &"QUEST_HIDE"
const ALL_EVENTS := [EVENT_START, EVENT_PASS, EVENT_FAIL, EVENT_TICK, EVENT_SHOW, EVENT_HIDE]

func connect_signals() -> void:
	State.event.connect(_state_event)
	Cinema.event.connect(_cinema_event)

func _cinema_event(id: StringName, data: String) -> void:
	if not id in ALL_EVENTS: return
	var quest_id: StringName = data
	var tick_id: StringName = &""
	if "#" in data:
		var parts := data.split("#", true, 1)
		quest_id = parts[0]
		tick_id = parts[1]
	var quest: QuestInfo = find(quest_id)
	if not quest:
		push_error("No quest ", data)
		return
	var tick: QuestTick
	if tick_id:
		tick = quest.find_tick(tick_id)
		if not tick:
			push_error("No quest tick ", data)
			return
	
	match id:
		EVENT_START: quest.start()
		EVENT_PASS: quest.set_passed()
		EVENT_FAIL: quest.set_failed()
		EVENT_TICK: tick.tick += 1
		EVENT_SHOW: tick.show()
		EVENT_HIDE: push_warning("Quest hiding not implemented. Just don't call show().")

func _check_triggers(obj: Object, event: Event):
	var state: QuestInfo.QuestState = obj.state
	var triggers: Dictionary[QuestInfo.QuestState, Array] = obj.triggers
	if not state in triggers: return
	for trigger: TriggerInfo in triggers[state]:
		if trigger.check(event):
			Cinema.queue(trigger.flow_script)

func _state_event(e: Event):
	for quest: QuestInfo in _objects.values():
		# Check for state event triggers.
		_check_triggers(quest, e)
		# Check for tick event triggers.
		for tick_id in quest.ticks:
			var tick := quest.ticks[tick_id]
			_check_triggers(tick, e)
		
	match e:
		State.QUEST_STARTED:
			Audio.play(&"quest_log_updated")
			State.TOAST.fire({ data={text="Quest Started"} })
			
		State.QUEST_TICKED:
			Audio.play(&"quest_log_updated")
			State.TOAST.fire({ data={text="Quest Updated"} })

func get_object_script() -> GDScript:
	return QuestInfo

```

# res://scripts/resources/quest_info.gd
```gd
class_name QuestInfo extends DatabaseObject

enum QuestState {
	HIDDEN,			## Not started.
	ACTIVE,			## Started.
	PASSED,			## Finished success.
	FAILED,			## Finished failed.
}

static func get_state_color(s := QuestState.HIDDEN) -> Color:
	match s:
		QuestState.HIDDEN: return Color(1., 1., 1., 0.5)
		QuestState.ACTIVE: return Color.WHITE
		QuestState.PASSED: return Color.GREEN_YELLOW
		QuestState.FAILED: return Color.TOMATO
	return Color.PURPLE

@export var desc: String
@export var types: Array[StringName]
@export var ticks: Dictionary[StringName, QuestTick]
@export var state := QuestState.HIDDEN: set=set_state
@export var stats := StatDB.new()
@export var triggers: Dictionary[QuestState, Array]
@export var visible := true ## Sometimes invisible quests are wanted. They shouldn't create toasts.
@export var marked_for_notification := false

func has_notification() -> bool:
	for tick in ticks.values():
		if tick.marked_for_notification:
			return true
	return marked_for_notification
func mark_notification(): marked_for_notification = true
func clear_notification():
	for tick in ticks.values():
		tick.marked_for_notification = false
	marked_for_notification = false

func find_tick(tid: String) -> QuestTick:
	for tick_id in ticks:
		if tick_id == tid:
			return ticks[tick_id]
	return null

func set_state(s: QuestState):
	if state == s: return
	state = s
	changed.emit()

#func _get_devmode() -> Array:
	#var options := []
	#for s in [Style.HIDDEN, Style.ACTIVE, Style.PASSED, Style.FAILED]:
		#options.append({text=Style.keys()[s]})
		#if style != s:
			#options[-1].call = set_style.bind(s)
	#return options

func start():
	if state == QuestState.HIDDEN:
		state = QuestState.ACTIVE
		State.QUEST_STARTED.fire({ quest=self })

func set_passed():
	if state != QuestState.PASSED:
		state = QuestState.PASSED
		State.QUEST_PASSED.fire({ quest=self })
		
func set_failed():
	if state != QuestState.FAILED:
		state = QuestState.FAILED
		State.QUEST_FAILED.fire({ quest=self })

func ticked(...tick_ids) -> bool:
	for tid in tick_ids:
		if not tid in ticks:
			push_error("No tick %s in quest %s." % [tid, id])
			return false
		if not ticks[tid].completed: return false
	return true

func _get(property: StringName) -> Variant:
	for tick_id in ticks:
		if tick_id == property:
			return ticks[tick_id]
	if stats.has(property):
		return stats.get(property)
	return null

func _set(property: StringName, value: Variant) -> bool:
	for tick_id in ticks:
		if tick_id == property:
			push_error("Can't set tick as property.", self, property)
			return true
	if stats.has(property):
		stats.set(property, value)
		return true
	return false

func _iter_init(iter) -> bool:
	iter[0] = 0
	return iter[0] < ticks.size()

func _iter_next(iter) -> bool:
	iter[0] += 1
	return iter[0] < ticks.size()

func _iter_get(iter) -> Variant:
	return ticks[iter]

func get_db() -> Database:
	return State.quests

```

# res://scripts/resources/quest_tick.gd
```gd
class_name QuestTick extends Resource

@export var id: StringName
@export var quest_id: StringName
@export var state := QuestInfo.QuestState.HIDDEN: set=set_state
@export var tick := 0: set=set_tick
@export var max_ticks := 1
@export var name := ""
@export var desc := ""
@export var need: Array[StringName] ## Must all be true for any triggers to check.
@export var mark: Array[StringName] ## Highlights characts, zones, items...
@export var triggers: Dictionary[QuestInfo.QuestState, Array] ## Event that triggers this tick.
@export var mark_for_notification := false
@export var visible := true ## Sometimes a hidden tick is desired.

var quest: QuestInfo:
	get: return State.quests.find(quest_id)

var completed: bool:
	get: return tick == max_ticks
	set(t):
		if completed == t: return
		tick = max_ticks if t else 0
		mark_for_notification = true
		if completed:
			set_state(QuestInfo.QuestState.PASSED)

func set_state(s := QuestInfo.QuestState.HIDDEN):
	if state == s: return
	state = s
	mark_for_notification = true
	changed.emit()

func set_tick(t: int):
	if tick == t: return
	tick = t
	show()
	State.QUEST_TICKED.fire({ tick=self })
	if completed:
		state = QuestInfo.QuestState.PASSED
		State.QUEST_TICK_COMPLETED.fire({ tick=self })

func show() -> void:
	if state == QuestInfo.QuestState.HIDDEN:
		state = QuestInfo.QuestState.ACTIVE

func _to_string() -> String:
	return "QuestTick(%s#%s)" % [quest_id, id]

#func _get_devmode() -> Array:
	#var options := []
	#var flow_id := quest.name + "#" + name
	#options.append({
		#text="Queue: %s" % name,
		#call=Flow.queue.bind(flow_id, { quest=quest, tick=tick }) })
	#if event:
		#options.append({
			#text="Trigger: %s" % [event],
			#call=event.fire.bind(event_state) })
	#if completed:
		#options.append(func set_complete(): completed = true)
	#if completed:
		#options.append(func set_uncomplete(): completed = false)
	#return options

```

# res://scripts/resources/shooter_info.gd
```gd
class_name ShooterInfo extends ItemInfo

@export var max_ammo: int = 16
@export var projectile_item_id: StringName

func _node_equipped(node: ItemNode) -> bool:
	if not node._state:
		node._state.ammo = max_ammo
		node._state.max_ammo = max_ammo
	return true

func _node_unequipped(_node: ItemNode) -> bool:
	return true

func _node_use(node: ItemNode) -> bool:
	if node.mount is Humanoid:
		if node._state.ammo > 0:
			#var hum: Humanoid = node.mount
			var from: Vector3 = node.get_node("%projectile_spawn").global_position
			var to := (node.mount as Humanoid).looking_at
			var proj := Projectile.create(from, to)
			var sphere := SphereMesh.new()
			sphere.height = 0.2
			sphere.radius = sphere.height * .5
			var mesh := MeshInstance3D.new()
			proj.add_child(mesh)
			mesh.mesh = sphere
			
			node.anim_travel("fire")
			node._state.ammo -= 1
			print("%s/%s" % [node._state.ammo, node._state.max_ammo])
			return true
		else:
			print("No ammo left.")
	return false

func _node_reload(node: ItemNode) -> bool:
	node.anim_travel("reload")
	node._state.ammo = max_ammo
	print("%s/%s" % [node._state.ammo, node._state.max_ammo])
	return true

```

# res://scripts/resources/stat_db.gd
```gd
class_name StatDB extends Database

func _get(property: StringName) -> Variant:
	if has(property):
		var prop: StatInfo = _objects[property]
		return prop.value
	return null

func _set(property: StringName, value: Variant) -> bool:
	if has(property):
		var prop: StatInfo = _objects[property]
		prop.set_value(value)
		return true
	return false

func add_range(id: StringName, default: Variant, minn: Variant = 0, maxx: Variant = 100, desc := "") -> StatInfo:
	var prop := StatInfo.new()
	prop.default = default
	prop.value = default
	prop.minimum = minn
	prop.maximum = maxx
	prop.desc = desc
	return _add(id, prop)
	
func add_flag(id: StringName, default: Variant = false, allowed := [true, false], desc := "") -> StatInfo:
	var prop := StatInfo.new()
	prop.default = default
	prop.value = default
	prop.allowed.assign(allowed)
	prop.desc = desc
	return _add(id, prop)

func get_object_script() -> GDScript:
	return StatInfo

```

# res://scripts/resources/stat_info.gd
```gd
class_name StatInfo extends DatabaseObject

@export var value: Variant: set=set_value
@export var desc: String
@export var allowed: Array[Variant]
@export var minimum: Variant = null
@export var maximum: Variant = null
@export var default: Variant

func set_value(v: Variant) -> bool:
	var type := typeof(default)
	var converted: Variant = type_convert(v, type)
	if minimum: converted = min(minimum, converted)
	if maximum: converted = min(maximum, converted)
	if allowed and not converted in allowed:
		push_error("Couldn't set %s to %s. Only %s allowed." % [id, v, allowed])
		return false
	if value == converted: return false
	var old: Variant = value
	value = converted
	State.STAT_CHANGED.fire({ stat=self, old=old, new=value })
	return true

```

# res://scripts/resources/state_objects.gd
```gd
class_name StateObjects extends Resource

@export var chars: CharDB
@export var char_groups: CharGroupDB
@export var items: ItemDB
@export var zones: ZoneDB
@export var stats: StatDB
@export var quests: QuestDB
@export var attributes: AttributeDB
@export var inventories: InventoryDB
@export var equip_slots: Database

func _init() -> void:
	clear()

func get_dbs() -> Array[Database]:
	return [chars, items, zones, stats, quests]

func get_counts_string(join_str := ", ") -> String:
	var counts := []
	for db in get_dbs():
		var size: int = db.size()
		if size > 0:
			counts.append([size, UObj.get_class_name(db)])
	counts.sort_custom(func(a, b): return a[0] > b[0])
	return join_str.join(counts.map(func(a): return "%sx %s" % a))

func clear() -> void:
	chars = CharDB.new()
	char_groups = CharGroupDB.new()
	items = ItemDB.new()
	zones = ZoneDB.new()
	stats = StatDB.new()
	quests = QuestDB.new()
	attributes = AttributeDB.new()
	inventories = InventoryDB.new()
	equip_slots = Database.new()

```

# res://scripts/resources/surface_material.gd
```gd
@tool
class_name SurfaceMaterial extends PhysicsMaterial

@export var footstep_sounds: Array[AudioStream]
@export var footstep_scene: PackedScene
@export var impact_sounds: Array[AudioStream]
@export var impact_scene: PackedScene

```

# res://scripts/resources/trigger_info.gd
```gd
class_name TriggerInfo extends Resource

@export var event: StringName
@export var state: Dictionary[StringName, Variant]
@export var condition: String
@export var flow_script: FlowScript

func check(evnt: Event) -> bool:
	if not State[event] == evnt: return false
	if not evnt.test(state): return false
	if condition and not State.call(condition): return false
	return true

```

# res://scripts/resources/zone_db.gd
```gd
class_name ZoneDB extends Database

var _astar: AStar3D ## For finding routes.
var _astar_index_to_id: Dictionary[int, StringName]
var _astar_id_to_index: Dictionary[StringName, int]

func get_object_script() -> GDScript:
	return ZoneInfo

func add(id: StringName, data := {}):
	_add_nested([id], data)

func _add_nested(stack: Array, data) -> ZoneInfo:
	var id := "#".join(stack)
	var zone := ZoneInfo.new()
	_add(id, zone) 
	for prop in data:
		if prop == &"zones":
			for subzone_id in data.zones:
				var subzone_data: Dictionary = data.zones[subzone_id]
				var subzone := _add_nested([id, subzone_id], subzone_data)
				subzone.parent = zone
		elif prop in zone:
			zone[prop] = data[prop]
	return zone

func reload_astar():
	_astar = AStar3D.new()
	
	var index := 0
	for zid in _objects.keys():
		_astar.add_point(index, Vector3.ZERO)
		_astar_id_to_index[zid] = index
		_astar_index_to_id[index] = zid
		index += 1
	
	for loc: ZoneInfo in _objects.values():
		for obj in loc.objects.values():
			if obj is ZoneLink:
				var from_index: int = _astar_id_to_index.get(loc.id + "#" + obj.from_zone_id, -1)
				var to_index: int = _astar_id_to_index.get(loc.id + "#" + obj.to_zone_id, -1)
				if from_index != -1 and to_index != -1:
					_astar.connect_points(from_index, to_index)

# Tries to find a route between two zones.
static func get_route(a: ZoneInfo, b: ZoneInfo) -> Array[ZoneInfo]:
	return State.locations._get_route(a, b)

func _get_route(a: ZoneInfo, b: ZoneInfo) -> Array[ZoneInfo]:
	var path: Array[ZoneInfo]
	var a_id := _astar_id_to_index[a.id]
	var b_id := _astar_id_to_index[b.id]
	var id_path := _astar.get_id_path(a_id, b_id, false)
	for index in id_path:
		path.append(_objects[_astar_index_to_id[index]])
	return path

```

# res://scripts/resources/zone_info.gd
```gd
class_name ZoneInfo extends DatabaseObject

@export var objects: Dictionary[StringName, Resource]
@export var parent: ZoneInfo

func is_subzone() -> bool:
	return "#" in id

func _to_string() -> String:
	return "Zone(%s)" % [id]

func has_link(link_id: StringName) -> bool:
	return link_id in objects and objects[link_id] is ZoneLink

func get_link(link_id: StringName, silent := true) -> ZoneLink:
	if has_link(link_id):
		return objects[link_id]
	if not silent:
		push_error("No link %s in %s: " % [link_id, id], UStr.get_similar(link_id, objects.keys()))
	return null

func get_links_to(dest: ZoneInfo) -> Dictionary[StringName, ZoneLink]:
	var out: Dictionary[StringName, ZoneLink]
	for oid: StringName in objects:
		if objects[oid] is ZoneLink:
			var link: ZoneLink = objects[oid]
			if link.a == dest or link.b == dest:
				out[oid] = link
	return out

func get_links_between(a: ZoneInfo, b: ZoneInfo) -> Dictionary[StringName, ZoneLink]:
	var out: Dictionary[StringName, ZoneLink]
	for oid: StringName in objects:
		if objects[oid] is ZoneLink:
			var link: ZoneLink = objects[oid]
			if (link.a == a and link.b == b) or (link.a == b and link.b == a):
				out[oid] = link
	return out

func get_children() -> Array[ZoneInfo]:
	var out: Array[ZoneInfo]
	for loc: ZoneInfo in State.locations:
		if loc.parent == self:
			out.append(loc)
	return out

```

# res://scripts/resources/zone_link.gd
```gd
class_name ZoneLink extends Resource
## Used by AStar system.

@export var type: StringName
@export var locked := false
@export var opened := false
@export var password := ""
var a: ZoneInfo
var b: ZoneInfo

func _to_string() -> String:
	return "ZoneLink(%s <-> %s)" % [a.id, b.id]

func get_inverse(loc: ZoneInfo) -> ZoneInfo:
	if loc == a: return b
	if loc == b: return a
	push_error("Link doesn't connect to %s." % [loc])
	return null

```

# res://scripts/screen.gd
```gd
class_name Screen extends Node

```

# res://scripts/states/pawn_state.gd
```gd
@icon("res://addons/odyssey/icons/control.svg")
class_name PawnState extends Resource
## Optional states that are enabled/disabled when Pawn is:
## - Mounted/unmounted.
## - Posessed/unpossesed.
## - Rider mounted/rider unmounted.

var pawn: Pawn: set=set_pawn
var _enabled := false
var _controller: Controller

func set_pawn(p: Pawn) -> void:
	if pawn == p: return
	pawn = p

func _process(_delta: float) -> void: pass
func _physics_process(_delta: float) -> void: pass
func _unhandled_input(_event: InputEvent) -> void: pass

func is_action_pressed(action: StringName, allow_echo := false, exact_match := false) -> bool:
	return get_player_controller().is_action_pressed(action, allow_echo, exact_match)

func is_action_released(action: StringName, exact_match := false):
	return get_player_controller().is_action_released(action, exact_match)

func is_action_both(action: StringName, start: Callable, stop: Callable) -> bool:
	if is_action_pressed(action):
		if start.call():
			handle_input()
			return true
	elif is_action_released(action):
		if stop.call():
			handle_input()
			return true
	return false

func handle_input():
	pawn.get_viewport().set_input_as_handled()

func _accept_controller(_con: Controller) -> bool:
	return false

func _enable() -> void:
	pawn.enable_state(self)
	_enabled = true

func _disable() -> void:
	pawn.disable_state(self)
	_enabled = false

func get_controller() -> Controller: return _controller
func get_player_controller() -> ControllerPlayer: return get_controller() as ControllerPlayer
func get_npc_controller() -> ControllerNPC: return get_controller() as ControllerNPC
func is_player() -> bool: return get_controller() is ControllerPlayer 
func is_npc() -> bool: return get_controller() is ControllerNPC

func is_first_person() -> bool:
	return get_player_controller().view_state == ControllerPlayer.ViewState.FirstPerson

func is_third_person() -> bool:
	return get_player_controller().view_state == ControllerPlayer.ViewState.ThirdPerson

```

# res://scripts/states/pstate_mounted.gd
```gd
@abstract class_name PStateMounted extends PawnState
## Enables when mounted to a Pawn.

func set_pawn(p: Pawn) -> void:
	super(p)
	pawn.mounted.connect(_mounted)
	pawn.unmounted.connect(_unmounted)

func _mounted(_mount: Pawn) -> void:
	if not _accept_controller(pawn.get_controller_recursive()): return
	_enable()

func _unmounted(_mount: Pawn) -> void:
	if not _accept_controller(pawn.get_controller_recursive()): return
	if not _enabled: return
	_disable()

```

# res://scripts/states/pstate_posessed.gd
```gd
@abstract class_name PStatePosessed extends PawnState
## Enabled when Pawn is posessed.

func set_pawn(p: Pawn) -> void:
	super(p)
	pawn.posessed.connect(_posessed)
	pawn.unposessed.connect(_unposessed)

func _posessed(con: Controller):
	if not _accept_controller(con): return
	if _enabled: return
	_controller = con
	_enable()

func _unposessed(con: Controller):
	if _enabled and _controller == con:
		_disable()
		_controller = null

```

# res://scripts/states/pstate_posessed_agent_npc.gd
```gd
@icon("res://addons/odyssey/icons/control_npc.svg")
class_name PStatePosessedAgentNPC extends PStatePosessed

var agent: Agent:
	get: return pawn.node

var _dest_point: Vector3
var _dest_inter: Interactive

func _accept_controller(con: Controller) -> bool:
	return con is ControllerNPC

func _physics_process(delta: float) -> void:
	if _dest_inter:
		var dir := _dest_point - agent.global_position
		var nrm := Vector2(dir.x, dir.z).normalized()
		agent.movement = nrm
		agent.direction = lerp_angle(agent.direction, atan2(-nrm.y, nrm.x) - PI * .5, 5.0 * delta)
		agent.head_looking_at = _dest_inter.global_position
		if dir.length() <= 2.0:
			#print("Reached ", _dest_inter)
			_dest_inter = null
	else:
		var inter := Group.rand(&"Interactive")
		#print("goto ", inter)
		goto(inter)

func goto(inter: Interactive) -> void:
	_dest_inter = inter
	_dest_point = inter.global_position

```

# res://scripts/states/pstate_posessed_agent_player.gd
```gd
class_name PStatePosessedAgentPlayer extends PStatePosessed

var agent: Agent:
	get: return pawn.node

var camera: CameraTarget ## TODO: Move to controller...
var _crouch_hold_time := 0.0
var _crouch_held := false
var _interactive_hud: Widget

func _accept_controller(con: Controller) -> bool:
	return con is ControllerPlayer

func _enable() -> void:
	super()

	#agent.interactive_detector.visible_changed.connect(agent.interactive_changed.emit)
	get_player_controller().view_state_changed.connect(_view_state_changed)
	if not camera:
		camera = Assets.create_scene(&"camera_follow", true)
		camera.target = agent
		get_player_controller().camera_master.target = camera.camera
		camera.get_node("%head_remote").remote_path = agent.get_node("%head").get_path()
		
		var remote := RemoteTransform3D.new()
		remote.name = "camera_target"
		remote.update_position = true
		remote.update_rotation = false
		remote.update_scale = false
		agent.get_node("%head").add_child(remote)
		remote.remote_path = camera.get_path()
		
		_view_state_changed()
	get_player_controller().show_widgit(&"toast_manager")
	_interactive_hud = get_player_controller().show_widgit(&"interaction_label")
	_interactive_hud.set_agent(agent)

func _disable() -> void:
	super()
	
	_interactive_hud = null
	#agent.interactive_detector.visible_changed.disconnect(agent.interactive_changed.emit)
	get_player_controller().view_state_changed.disconnect(_view_state_changed)
	get_player_controller().hide_widgit(&"interaction_label")
	get_player_controller().hide_widgit(&"toast_manager")

func _view_state_changed():
	match get_player_controller().view_state:
		ControllerPlayer.ViewState.FirstPerson:
			Global.wait(0.35, get_player_controller().show_fps_viewport)
			await camera.set_first_person()
			agent.get_node(^"%model").visible = false
		ControllerPlayer.ViewState.ThirdPerson:
			get_player_controller().hide_fps_viewport()
			camera.set_third_person()
			agent.get_node(^"%model").visible = true

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	get_player_controller()._event = event
	
	if is_action_pressed(&"quick_equip_menu"):
		get_player_controller().toggle_widgit(&"radial_menu", { choices=[
			{ text="Yes"},
			{ text="No" },
			{ text="Maybe"}
		]})
		handle_input()
		
	elif is_action_pressed(&"toggle_quest_log"):
		get_player_controller().toggle_widgit(&"quest_log")
	
	elif is_action_pressed(&"interact"):
		if agent.interact_start(pawn):
			handle_input()
	elif is_action_released(&"interact"):
		if agent.interact_stop(pawn):
			handle_input()
	
	elif is_action_both(&"fire", agent.fire_start, agent.fire_stop): pass
	elif is_action_both(&"reload", agent.reload_start, agent.reload_stop): pass
	
	elif is_action_pressed(&"jump"):
		print("jump")
		if agent.prone_state in [Humanoid.ProneState.Crouch, Humanoid.ProneState.Crawl]:
			agent.stand()
		else:
			agent.jump_start()
		handle_input()
	elif is_action_released(&"jump"):
		print("release jump")
		if agent.jump_stop():
			handle_input()
	
	elif is_action_pressed(&"drop"):
		if agent.drop():
			handle_input()
	
	elif is_action_both(&"aim", agent.focus_start, agent.focus_stop): pass
	#elif is_action_pressed(&"aim"):
		#agent.focus_start()
		#camera.focus()
		#handle_input()
	#elif is_action_released(&"aim"):
		#agent.focus_stop()
		#camera.unfocus()
		#handle_input()
		
	elif is_action_pressed(&"crouch", false, true):
		_crouch_held = true
		if agent.is_standing():
			agent.crouch()
		elif agent.is_crawling():
			agent.crouch()
		handle_input()
	elif is_action_released(&"crouch", true):
		_crouch_held = false
		_crouch_hold_time = 0.0
		if agent.is_crouching():
			agent.stand()
		handle_input()
	
	elif is_action_both(&"sprint", agent.sprint_start, agent.sprint_stop): pass

func _process(delta: float) -> void:
	#camera.get_node("%pivot").position.y = humanoid.get_node("%head").position.y
	#humanoid.get_node("%head").global_rotation = camera.camera.global_rotation
	
	if _crouch_held:
		_crouch_hold_time += delta
		if _crouch_hold_time > 0.5:
			if not agent.is_crawling():
				agent.crawl()

func _physics_process(delta: float) -> void:
	var inter: Interactive
	if is_third_person():
		var pos := agent.interactive_detector.global_position
		inter = agent.interactive_detector.get_nearest(pos)
	elif is_first_person():
		inter = agent.interactive_detector.get_nearest(agent.looking_at)
	
	if inter != agent._interactive:
		if agent._interactive:
			agent._interactive.highlight = Interactive.Highlight.NONE
		agent._interactive = inter
		if agent._interactive:
			agent._interactive.highlight = Interactive.Highlight.FOCUSED
	
	var input_dir := get_player_controller().get_move_vector_camera()
	
	if agent.is_focusing():
		var cam_dir := camera.camera.global_rotation.y
		agent.direction = lerp_angle(agent.direction, cam_dir, delta * 10.0)
	else:
		if input_dir:
			agent.direction = lerp_angle(agent.direction, -input_dir.angle() - PI * .5, delta * 10.0)
	
	agent.movement = input_dir
	
	var cam := camera.camera
	var mp := cam.get_viewport().get_mouse_position()
	var from := cam.project_ray_origin(mp)
	var to := from + cam.project_ray_normal(mp) * 1000.0
	var space := cam.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.exclude = [agent]
	var hit := space.intersect_ray(query)
	var target_pos = hit.position if hit else to
	
	agent.looking_at = target_pos
	
	if inter:
		agent.head_looking_at = inter.global_position + inter.humanoid_lookat_offset
		agent.head_looking_amount = 1.0
	elif agent.is_focusing():
		agent.head_looking_at = target_pos
		agent.head_looking_amount = 1.0
	else:
		var node: Node3D = agent.get_node("%direction")
		var forward := -node.global_transform.basis.z
		var front_pos := node.global_position + forward * 2.0 + Vector3.UP * 1.3
		agent.head_looking_at = front_pos
		agent.head_looking_amount = 0.0

```

# res://scripts/states/pstate_rider.gd
```gd
@abstract class_name PStateRider extends PawnState
## PawnState that enables when someone is riding.

@export var pawn_as_remote := true ## Attaches rider to Pawn using a RemoteTransform3D.
@export_node_path("Node3D") var rider_remote: NodePath ## Attaches rider here using a RemoteTransform3D.
@export var rider_update_position := true
@export var rider_update_rotation := true
@export var rider_update_scale := false
var _rider: Node3D
var _remote: RemoteTransform3D

@export var play_animation := true
@export var animation_enter := &"Sitting_Idle"
@export var animation_exit := &"Standing"
@export var tween_position := true ## Animation controllable position.
@export var tween_rotation := true ## A
@export var tween_time := 0.5

@export var cinematic: FlowScript ## Cinematic to play.
@export var eject_on_cinematic_finished := false ## TODO:

func set_pawn(p: Pawn) -> void:
	super(p)
	pawn.rider_mounted.connect(_rider_mounted)
	pawn.rider_unmounted.connect(_rider_unmounted)

func kick_rider():
	pawn.set_rider(null)

func _rider_mounted(rider: Pawn) -> void:
	if not _accept_controller(rider.controller): return
	
	_rider = rider.node
	_controller = rider.controller
	_rider.freeze()
	
	if pawn_as_remote or rider_remote:
		
		_remote = RemoteTransform3D.new()
		if pawn_as_remote:
			pawn.add_child(_remote)
		else:
			pawn.get_node(rider_remote).add_child(_remote)
		
		if tween_position:
			_remote.global_position = _rider.global_position
		if tween_rotation:
			_remote.global_rotation.y = _rider.direction
			_rider.direction = 0.0
		
		_remote.name = _rider.name + "_remote"
		_remote.update_position = rider_update_position
		_remote.update_rotation = rider_update_rotation
		_remote.update_scale = rider_update_scale
		_remote.remote_path = _rider.get_path()
	
	_enable()

func _rider_unmounted(rider: Pawn) -> void:
	if _rider != rider.node: return
	print("Rider unmounted...")
		
	if _remote:
		_remote.get_parent().remove_child(_remote)
		_remote.queue_free()
		_remote = null
	
	_disable()
	
	_rider.unfreeze()
	_rider = null
	_controller = null

func _enable() -> void:
	super()
	
	if cinematic:
		Cinema.queue(cinematic)
	
	if not _rider is Humanoid: return
	var humanoid: Humanoid = _rider
	
	if play_animation and animation_enter:
		humanoid.trigger_animation.emit(animation_enter)
	
	if tween_position or tween_rotation:
		if _remote:
			var dir_from := _remote.rotation.y
			var pos_from := _remote.position
			UTween.interp(_remote, 
				func(x: float):
					if tween_rotation:
						_remote.rotation.y = lerp_angle(dir_from, 0.0, x)
					if tween_position:
						_remote.position = lerp(pos_from, Vector3.ZERO, x),
				tween_time)
		else:
			var dir_from := humanoid.global_rotation.y
			var pos_from := humanoid.global_position
			UTween.interp(humanoid, 
				func(x: float):
					if tween_rotation:
						humanoid.direction = lerp_angle(dir_from, 0.0, x)
					if tween_position:
						humanoid.position = lerp(pos_from, Vector3.ZERO, x),
				tween_time)

func _disable() -> void:
	super()
	if not _rider is Agent: return
	var agent: Agent = _rider
	
	if play_animation and animation_exit:
		agent.trigger_animation.emit(animation_exit)
	
	if pawn.rider_unmount_area:
		var from_pos := agent.global_position
		var from_rot := agent.global_rotation.y
		var to_pos := pawn.rider_unmount_area.global_position
		var to_rot := pawn.rider_unmount_area.global_rotation.y
		agent.fix_direction()
		UTween.interp(agent,
			func(x: float):
				agent.global_position = lerp(from_pos, to_pos, x)
				agent.global_rotation.y = lerp_angle(from_rot, to_rot, x)
				, 0.5).finished.connect(agent.fix_direction)
	else:
		agent.fix_direction()

```

# res://scripts/states/pstate_rider_agent_player.gd
```gd
class_name PStateRiderAgentPlayer extends PStateRider
## Player Agent is riding that Pawn.

@export var widget: StringName ## If player, scene added to hud.
var _widget: Widget

func _accept_controller(con: Controller) -> bool:
	return con is ControllerPlayer

func _enable() -> void:
	super()
	if widget:
		_widget = get_player_controller().show_widgit(widget)

func _disable() -> void:
	super()
	if _widget:
		get_player_controller().hide_widgit(widget)

func _unhandled_input(event: InputEvent) -> void:
	get_player_controller()._event = event
	if is_action_pressed(&"exit"):
		kick_rider()
		handle_input()

```

# res://scripts/states/pstate_rider_agent_player_ladder.gd
```gd
class_name PStateRiderAgentPlayerLadder extends PStateRiderAgentPlayer

func _physics_process(delta: float) -> void:
	var move := get_player_controller().get_move_vector()
	pawn.rider.global_transform.origin.y -= move.y * delta * 1.0
	
	var dif := pawn.rider.global_transform.origin.y - pawn.global_transform.origin.y
	if dif > 4.5:
		kick_rider()

```

# res://scripts/states/pstate_rider_agent_player_turret.gd
```gd
class_name PStateRiderAgentPlayerTurret extends PStateRiderAgentPlayer

var _angle := 0.0

func _process(delta: float) -> void:
	var vec := get_controller().get_move_vector()
	_angle -= vec.x * 2.0 * delta
	pawn.rotation.y = lerp_angle(pawn.rotation.y, _angle, delta * 10.0)

```

# res://scripts/states/pstate_rider_agent_player_vehicle.gd
```gd
class_name PStateRiderAgentPlayerVehicle extends PStateRiderAgentPlayer

var vehicle: Vehicle:
	get: return pawn.node

func _unhandled_input(event: InputEvent) -> void:
	get_player_controller()._event = event
	if is_action_pressed(&"exit"):
		kick_rider()
		handle_input()
	
	elif is_action_both(&"honk", vehicle.honk_start, vehicle.honk_stop): pass
	elif is_action_both(&"brake", vehicle.brake_start, vehicle.brake_stop): pass

func _physics_process(_delta: float) -> void:
	var move := get_player_controller().get_move_vector()
	vehicle.move = move

func _disable() -> void:
	super()
	
	vehicle.move = Vector2.ZERO
	vehicle.brake = false

```

# res://scripts/util/group.gd
```gd
class_name Group extends RefCounted

static func all(group: StringName) -> Array[Node]:
	return Global.get_tree().get_nodes_in_group(group)

static func first(group: StringName) -> Node:
	return Global.get_tree().get_first_node_in_group(group)

static func rand(group: StringName) -> Node:
	return Global.get_tree().get_nodes_in_group(group).pick_random()

static func named(group: StringName, name: String) -> Node:
	for node in Global.get_tree().get_nodes_in_group(group):
		if node.name == name:
			return node
	return null

static func do(group: StringName, fnc: Callable):
	for node in Global.get_tree().get_nodes_in_group(group):
		fnc.call(node)

static func queue_free(group: StringName):
	for node in Global.get_tree().get_nodes_in_group(group):
		node.queue_free()

## Returns a dict of nodes where keys are their names.
static func dict(group: StringName) -> Dictionary[StringName, Node]:
	var out: Dictionary[StringName, Node]
	for node in Global.get_tree().get_nodes_in_group(group):
		out[node.name] = node
	return out

```

# res://scripts/util/rand.gd
```gd
class_name Rand extends RefCounted

static func point_on_sphere() -> Vector3:
	var u := randf() * TAU
	var v := randf() * TAU
	var z := randf() * 2.0 - 1.0
	var r := sqrt(1.0 - z * z)
	return Vector3(r * cos(u) * sin(v), r * sin(u) * sin(v), z * cos(v)).normalized()

static func point_on_circle() -> Vector2:
	var rad := randf() * TAU
	return Vector2(cos(rad), sin(rad))

```

# res://scripts/util/shadmat.gd
```gd
@tool
class_name ShadMat extends RefCounted

var material: ShaderMaterial
var _tween: Tween

func _init(obj: Variant, props: Dictionary) -> void:
	if obj is Material:
		material = obj
	elif obj is Node:
		if "material" in obj:
			material = obj.material
	for prop in props:
		material.set_shader_parameter(prop, props[prop])

#func _get(property: StringName) -> Variant:
	#return material.get_shader_parameter(property)
#
#func _set(property: StringName, value: Variant) -> bool:
	#material.set_shader_parameter(property, value)
	#return true

func tween(property: StringName, value: Variant, duration := 0.5, trans := Tween.TRANS_LINEAR, ease := Tween.EASE_IN_OUT):
	var from: Variant = convert(material.get_shader_parameter(property), typeof(value))
	if _tween: _tween.kill()
	_tween = Global.create_tween()
	_tween.tween_method(func(x): material.set_shader_parameter(property, x), from, value, duration)\
		.set_trans(trans)\
		.set_ease(ease)

```

# res://scripts/util/ubit.gd
```gd
class_name UBit extends RefCounted

const FLAG_NONE := 0

# Static cache for layer mappings (avoids repeated ProjectSettings lookups)
static var _physics3d_cache: Dictionary = {}
static var _render3d_cache: Dictionary = {}

static func is_enabled(b: int, flag: int) -> bool:
	return (b & flag) != 0

static func enable(b: int, flag: int) -> int:
	return b | flag

static func disable(b: int, flag: int) -> int:
	return b & ~flag

static func is_physics3d_enabled(id: StringName, b: int) -> bool:
	var flag := get_physics3d_flag(id)
	return flag != 0 and is_enabled(b, flag)

static func enable_physics3d(id: StringName, b: int) -> int:
	var flag := get_physics3d_flag(id)
	return enable(b, flag) if flag != 0 else b

static func disable_physics3d(id: StringName, b: int) -> int:
	var flag := get_physics3d_flag(id)
	return disable(b, flag) if flag != 0 else b

static func build_physics3d_mask(...ids) -> int:
	var out := 0
	for id in ids:
		var flag := get_physics3d_flag(id)
		if flag != 0:
			out = enable(out, flag)
	return out

static func get_physics3d_flag(id: StringName) -> int:
	if _physics3d_cache.has(id):
		return _physics3d_cache[id]
	
	for layer in range(1, 33):
		if ProjectSettings.get_setting("layer_names/3d_physics/layer_%d" % layer) == id:
			var mask := 1 << (layer - 1)
			_physics3d_cache[id] = mask
			return mask
	
	push_error("No 3D physics layer named '%s' found." % id)
	return 0

static func get_render3d_flag(id: StringName) -> int:
	if _render3d_cache.has(id):
		return _render3d_cache[id]
	
	for layer in range(1, 33):
		if ProjectSettings.get_setting("layer_names/3d_render/layer_%d" % layer) == id:
			var mask := 1 << (layer - 1)
			_render3d_cache[id] = mask
			return mask
	
	push_error("No 3D render layer named '%s' found." % id)
	return 0

static func build_render3d_mask(...ids) -> int:
	var out := 0
	for id in ids:
		var flag := get_render3d_flag(id)
		if flag != 0:
			out = enable(out, flag)
	return out

```

# res://scripts/util/udict.gd
```gd
class_name UDict

static func pop(dict: Dictionary, key: Variant, default: Variant = null) -> Variant:
	if key in dict:
		var out: Variant = dict[key]
		dict.erase(key)
		return out
	return default

```

# res://scripts/util/unode.gd
```gd
class_name UNode extends RefCounted

static func remove_children(n: Node, qfree := true):
	for child in n.get_children():
		n.remove_child(child)
		if qfree:
			child.queue_free()

```

# res://scripts/util/uobj.gd
```gd
class_name UObj extends RefCounted

static func get_class_name(obj: Object) -> String:
	var scr: GDScript = obj.get_script()
	var scode := scr.source_code
	var rm := RegEx.create_from_string(r'class_name\s+(\w+)').search(scode)
	var clss_name := rm.strings[1]
	return clss_name

static func set_properties(obj: Object, props: Dictionary, silent := true) -> Object:
	for prop in props:
		if prop in obj:
			match typeof(obj[prop]):
				TYPE_DICTIONARY: (obj[prop] as Dictionary).assign(props[prop])
				TYPE_ARRAY: (obj[prop] as Array).assign(props[prop])
				TYPE_OBJECT: set_properties(obj[prop], props[prop], silent)
				var type: obj[prop] = convert(props[prop], type)
		elif prop == prop.to_upper():
			pass # Skip ID and TYPE.
		elif not silent:
			push_error("Object %s has no property %s to set to %s." % [obj, prop, props[prop]])
	return obj

```

# res://scripts/util/ustate.gd
```gd
class_name UState extends RefCounted

static func get_state(obj: Object) -> Dictionary:
	var state: Dictionary[StringName, Variant]
	for prop in obj.get_property_list():
		if not prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE == 0: continue
		match prop.type:
			TYPE_OBJECT: state[prop.name] = get_state(obj[prop.name])
			TYPE_DICTIONARY: state[prop.name] = _get_state_dict(obj[prop.name])
			TYPE_ARRAY: state[prop.name] = _get_state_array(obj[prop.name])
	return state

static func set_state(obj: Object, state: Dictionary[StringName, Variant]):
	for prop in obj.get_property_list():
		if not prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE == 0: continue
		if not prop in state: continue
		match prop.type:
			TYPE_OBJECT: set_state(obj[prop.name], state[prop.name])
			TYPE_DICTIONARY: _set_state_dict(obj[prop.name], state[prop.name])
			TYPE_ARRAY: _set_state_array(obj[prop.name], state[prop.name])

static func _set_state_dict(dict: Dictionary, state: Dictionary):
	var val_type := dict.get_typed_value_builtin()
	match val_type:
		TYPE_OBJECT:
			var dclass := dict.get_typed_value_class_name()
			for key in state:
				var inst: Variant = ClassDB.instantiate(dclass)
				set_state(inst, state[key])
				dict[key] = inst
		_:
			for key in state:
				dict[key] = state[key]

static func _set_state_array(array: Array, state: Array):
	var atype := array.get_typed_builtin()
	match atype:
		TYPE_OBJECT:
			var aclass := array.get_typed_class_name()
			if aclass:
				for substate in state:
					var inst: Variant = ClassDB.instantiate(aclass)
					set_state(inst, substate)
					array.append(inst)
			else:
				array.assign(state)
		_: array.assign(state)

static func _get_state_dict(dict: Dictionary) -> Dictionary:
	var out: Dictionary[Variant, Variant]
	for prop in dict:
		match typeof(dict[prop]):
			TYPE_OBJECT: out[prop] = get_state(dict[prop])
			TYPE_DICTIONARY: out[prop] = _get_state_dict(dict[prop])
			TYPE_ARRAY: out[prop] = _get_state_array(dict[prop])
			_: out[prop] = dict[prop]
	return out

static func _get_state_array(array: Array) -> Array[Variant]:
	var out: Array[Variant]
	for item in array:
		match typeof(item):
			TYPE_OBJECT: out.append(get_state(item))
			TYPE_DICTIONARY: out.append(_get_state_dict(item))
			TYPE_ARRAY: out.append(_get_state_array(item))
			_: out.append(item)
	return out

```

# res://scripts/util/ustr.gd
```gd
class_name UStr extends RefCounted

static func get_similar_str(key: String, list: Array, threshold := 0.5, msg := " Did you mean %s?") -> String:
	var sim := get_similar(key, list, threshold)
	return "" if not sim else msg % ", ".join(sim)

static func get_similar(key: String, list: Array, threshold := 0.5) -> Array:
	var out := []
	for item: String in list:
		var sim := key.similarity(item)
		if sim >= threshold:
			out.append([item, sim])
	out.sort_custom(func(a, b): return a[1] > b[1])
	return out.map(func(a): return a[0])

static func from_json(variant: Variant) -> String:
	return JSON.stringify(variant, "\t", false)

static func print_json(variant: Variant):
	print(from_json(variant))

static func print_yaml(variant: Variant):
	print(YAML.stringify(variant))

static func number_with_commas(number: float) -> String:
	var num_str := str(int(number))
	var result := ""
	var count := 0
	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result
	return result

static func number_abbreviated(number: float, commas := true) -> String:
	const ABREVS := {
		1_000_000_000.0: "B",
		1_000_000.0: "M",
		1_000.0: "K"
	}
	var abs_n := absf(number)
	var sign_char := "-" if number < 0 else ""
	for amnt in ABREVS:
		if abs_n >= amnt:
			return "%s%.1f%s" % [sign_char, str(abs_n / amnt).rstrip("0").rstrip("."), ABREVS[amnt]]
	if commas:
		return number_with_commas(number)
	return "%s%d" % [sign_char, int(abs_n)]

```

# res://scripts/util/utween.gd
```gd
class_name UTween extends RefCounted

static func _create(node: Node, tween_id: StringName) -> Tween:
	var tween: Tween = node.get_meta(tween_id) if node.has_meta(tween_id) else null
	if tween: tween.kill()
	tween = node.create_tween()
	node.set_meta(tween_id, tween)
	tween.finished.connect(func(): node.set_meta(tween_id, null))
	return tween
	
static func interp(node: Node, meth: Callable, duration := 1.0, tween_id := &"_tween", trans := Tween.TRANS_SINE) -> Tween:
	var tween := _create(node, tween_id)
	tween.set_trans(trans)
	tween.tween_method(meth, 0.0, 1.0, duration)
	return tween
	
static func parallel(node: Node, props: Dictionary, duration := 1.0, tween_id := &"_tween", trans := Tween.TRANS_SINE) -> Tween:
	var tween := _create(node, tween_id)
	tween.set_parallel(true)
	tween.set_trans(trans)
	for prop: String in props:
		if "/" in prop:
			var parts := prop.rsplit("/", true, 1)
			var child := node.get_node(parts[0])
			tween.tween_property(child, parts[1], props[prop], duration)
		elif prop.begins_with("%"):
			var parts := prop.split(":", true, 1)
			var child := node.get_node(parts[0])
			tween.tween_property(child, parts[1], props[prop], duration)
		else:
			tween.tween_property(node, prop, props[prop], duration)
	return tween

```

# res://scripts/widgits/hud_marker.gd
```gd
class_name HUDMarker extends Control
## 2D position for a 3D node.

signal entered_view()
signal exited_view()

@export var target: Marker ## Object being tracked.
@export var origin := Vector2(0.5, 1.0) ## Multiplied by size.
var camera: Camera3D
var viewport: SubViewport
var _inview := false

func _process(_delta: float) -> void:
	if not target: return
	var screen_size := viewport.get_visible_rect().size
	var camera_transform := camera.global_transform
	var camera_basis := camera_transform.basis
	var camera_origin := camera_transform.origin
	var world_pos := target.global_position
	var to_target := world_pos - camera_origin
	var camera_forward := -camera_basis.z
	var dot := camera_forward.dot(to_target)
	
	var dist := world_pos.distance_to(camera_origin)
	%label.text = "%sm" % [int(dist)]
	
	if dot > 0.0:
		# In front of camera.
		position = camera.unproject_position(world_pos)
		
		if not _inview:
			_inview = true
			entered_view.emit()
	else:
		# Behind camera — mirror point across camera.
		var mirrored_pos := camera_origin - to_target
		position = camera.unproject_position(mirrored_pos)
		
		# Move to edge: center screen + vector toward projected point.
		var screen_center := screen_size * 0.5
		var dir := (position - screen_center).normalized()
		position = screen_center + dir * (screen_size.length() * 0.5)
		
		if _inview:
			_inview = false
			exited_view.emit()
	
	# Offset based on origin.
	position -= size * origin
	# Clamp final 2D position to screen edges with margin.
	position.x = clampf(position.x, 0.0, screen_size.x - size.x)
	position.y = clampf(position.y, 0.0, screen_size.y - size.y)

```

# res://scripts/widgits/hud_markers.gd
```gd
extends Widget

var _markers: Dictionary[Marker, HUDMarker]

#func _ready() -> void:
	#Controllers.event.connect(_event)

func _event(event: Event, data: Variant):
	match event:
		Controllers.EV_SHOW_MARKER:
			var node: Marker = data
			if not node in _markers:
				var marker: HUDMarker = load("res://scenes/ui/marker.tscn").instantiate()
				add_child(marker)
				marker.target = node
				marker.camera = %camera_master
				marker.viewport = %viewport
				_markers[node] = marker
		
		Controllers.EV_HIDE_MARKER:
			var node: Marker = data
			if node in _markers:
				var marker: HUDMarker = _markers[node]
				_markers.erase(node)
				remove_child(marker)

```

