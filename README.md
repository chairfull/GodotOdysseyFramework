# OF: Odyssey Framework

Simplify development of FPS, RPG, ImSims.

# Included Addons
- [Little Camera Preview](https://github.com/anthonyec/godot_little_camera_preview)
- [LimboAI](https://github.com/limbonaut/limboai)
- [YAML](https://github.com/fimbul-works/godot-yaml)

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
- [ ] God-Mode

## Third Person
- [ ] God-Mode
- [x] Click Movement
	- [ ] Auto-Jumping
- [x] Keyboard Movement
	- [x] Jumping
- [x] Interaction
### Animations
- [x] Movement
- [x] Jumping

## NPC
- [ ] Moving
- [ ] Jumping
- [ ] Entering/Exiting mounts
	- [ ] Generic
	- [ ] Vehicles
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

## Cinema
- [ ] Scripting language
- [ ] Pause gameplay
- [ ] Dialogue
	- [ ] Captions
		- [ ] Audio
	- [ ] Choices
	- [ ] Scripted animations
		- [ ] Walking
		- [ ] Animations

## Interactions
### Mounts
- [ ] Mount: Change control to mount
- [ ] Unmount: Revert control to character
### Vehicle
- [ ] Enter/Exit
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

## Input
- [ ] Gamepad
- [ ] Customise controls
	- [ ] Presets
	- [ ] Multiplayer

## Other
- [x] Split screen
	- [ ] Lighting not working in Mobile/Comaptibility mode
