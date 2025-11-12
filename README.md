![Odysset Framework](./addons/odyssey/icon_of.svg)
# v0.1.1
![Godot](https://img.shields.io/badge/Godot-4.x-blue.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg) (LICENSE)

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
- AFAP: As few components as possible:
	- Player & npc share most scripts
	- Weapons/items share most components
	
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
- [x] IK: Inverse Kinematics
	- [x] Hands
		- [ ] 1st Person: Hold items
		- [ ] Press buttons/interactives in world space
		- [ ] Align to objects (Ladders)
		- [ ] Hold hands w NPCs
	- [x] Feet
		- [ ] Align to floor

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
