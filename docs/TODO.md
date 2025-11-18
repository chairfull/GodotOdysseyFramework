# High Priority
- [ ] Camera position transforms need to be snappier.
	- Maybe using RemoteTransform3D, with camera/head.
	- HUD elements aren't snapping to world space position fast enough.
	- Held items are choppy...
- [ ] NPC
	- [x] Move to point
	- [ ] Follow nav path
	- [ ] Swap states
		- [ ] Notice something
		- [ ] Investigate
		- [ ] Attacking
			- [ ] Move within item range of target
			- [ ] Use item
		- [ ] Flee
			- [ ] Find safe spot
# Medium Priority
# Low Priority

# Humanoid Controller
- [x] Movement
	- [x] First-person
	- [x] Third-person
	- [ ] Top-down
	- [ ] Platformer
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
- [ ] Aim/Focus
	- [ ] 1st Person
	- [x] 3rd Person
- [ ] God-Mode/Flying
- [x] IK: Inverse Kinematics
	- [x] Hands
		- [ ] 1st Person: Hold items
		- [ ] Press buttons/interactives in world space
		- [ ] Align to objects (Ladders)
		- [ ] Hold hands w NPCs
	- [x] Feet
		- [ ] Align to floor
- [x] Interact with Interactive

# Humanoid Animations
- [x] Movement
- [x] Jumping
- [ ] Interact
- [ ] Look at objects
- [ ] Use hands on interactives

# NPC
- [x] Moving
	- [x] Stop moving if stuck
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

# Cinema
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

# Interactions
## Items
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
## Mounts
- [x] Mount: Change control to mount
- [x] Unmount: Revert control to character

# Vehicles
- [x] Enter/Exit
- [ ] Toggle first-third person camera
## Top-Down
- [ ] Click to drive to location

# Audio
- [x] Footsteps
- [ ] Jump
- [ ] Landing

# Items
- [ ] Inventory
	- [ ] UI
- [ ] Pickup
	- [ ] 1st-Person
	- [ ] 3rd-Person
	- [ ] Top-Down
- [ ] Equip
- [ ] Use
- [ ] Mount/Display

# Weapons
- [x] Firing
	- [x] Ray-based
	- [ ] Shape-based
	- [ ] Decals
	- [ ] Particles
	- [ ] Sound
- [ ] Melee
- [x] Damagables
- [ ] Fall Damage

# UI Widgit System
- [ ] Hit direction indicator
- [ ] Damage indicator (red-periphery)
	- [ ] Posion indicator (green)
- [x] Items
	- [x] Weapon
		- [x] Reticle
		- [x] Ammo counter
	- [ ] Input helper (Tells what buttons can be pressed)
- [ ] Sounds
	- [ ] Hover
	- [ ] Unhover
	- [ ] Focus
	- [ ] Unfocus
	- [ ] Select
	- [ ] Select (Disabled)
- [ ] In/out transitions
- [x] Toast system
	- [x] Queue based on type
	- [ ] Update if visible
	- [ ] Templates
		- [ ] Quest state changed
		- [ ] Inventory state changed
		- [ ] Achievement
		- [ ] Location entered
## Markers
- [x] Show markers
- [ ] Fade in/out based on distance
- [ ] Change to arrow when off screen
## Minimap
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
## Meta-Menu
- [x] Quest Log
	- [ ] Quest groups
	- [ ] Mark active quest
	- [ ] Quest markers
	- [ ] Notifications
- [ ] Wiki/Encyclopedia
- [ ] Skills/Stats
- [x] Awards
## Misc
- [ ] Pause Menu
- [ ] Settings
- [ ] Controls
- [ ] Save & Load
	- [x] Save
		- [x] Preview
		- [x] State
		- [ ] Only save changes to resources

# Input
- [ ] Gamepad
- [ ] Customise controls
	- [ ] Presets
	- [ ] Multiplayer

# Other
- [x] Split screen
	- [ ] Control focus per screen
	- [ ] Lighting not working in Mobile/Compatibility mode
