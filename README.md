![Version](https://img.shields.io/badge/Version-0.001-deepskyblue.svg)
![Godot](https://img.shields.io/badge/Godot-4.6.dev4-deepskyblue.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-deepskyblue.svg)

> [!WARNING]
> Unstable early development build.

> [!WARNING]
> Project is pro-AI, so if you are anti-clanker you may wish to avoid.

> [!NOTE]
> Feel free to raise issues with features you want or ideas to discuss.

![Odyssey Framework](./addons/odyssey/icon_of.svg)

It's easy to create a single game system, but Herculean to have all systems working together.
This framework aims to make development of imersive story based games easier by creating all those basic integrated systems. 
Ideally for FPS, RPG, & ImSims.

Check [Todo](docs/TODO.md) for features.

# Included Addons
- [Little Camera Preview](https://github.com/anthonyec/godot_little_camera_preview)
- [LimboAI](https://github.com/limbonaut/limboai)
- [Raytraced Audio](https://github.com/WhoStoleMyCoffee/raytraced-audio)
- [YAML](https://github.com/fimbul-works/godot-yaml)
- [Twee](https://github.com/chair_full/GodotTwee)
- [RicherTextLabels](https://github.com/chairfull/GodotRichTextLabel2/tree/v2dev)
- [Date Time](https://github.com/chairfull/GodotDateTime)

# Design Goal
- Open-world gameplay over linear:
	- Max interaction: Everything interactive w everything
	- Pollable world state: `if house.front_door.unlocked or mall.dumpster.is_empty()`
	- NPCs w schedules & reacting to game events & states
	- NPCs w dialogue options that affect states
	- Most cinematics skippable/ffwdable
- Controller that works for 1st-person, 3rd-person, top-down, platformer, point-and-click
- Pawn system for Vehicles, Seats, Stations...
- Split screen multiplayer
	- Widgit (UI) system that handles focus on a per player basis
- Live language/locale changing
- Live mod/patch enabling & disabling
- Easy customisation with config files
- Lots of juice/crunch (Communicating "something happened" to player and "how much")
	- Minimise jerkiness/clankiness
	- [ ] UI buttons animate/communicate on hover, click, unhover
	- [ ] Landing causes camera to tilt based on impact
	- [ ] Sounds change based on object movement speed
- AFAP: As few components as possible:
	- Player & npc share most scripts
	- Weapons/items share most components
