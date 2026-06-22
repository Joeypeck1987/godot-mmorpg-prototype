# Stillturn Godot Prototype Checkpoint

Godot version: 4.3 stable

## Current Working Features

- GitHub repo is working
- PROJECT_CHECKPOINT.md exists in the project root
- `main.tscn` works
- `HouseInterior.tscn` works
- Player movement works
- Player moves only on straight axes, no diagonal movement
- Player animation works
- Collision works
- Tree inspection works
- Grave inspection works
- Dialogue box works
- House entry works
- Rug exit returns to `main.tscn`
- Bookshelf interaction works
- Stair interaction works
- MonkNPC works
- Monk turns to face player during interaction
- Monk idly changes facing direction when not being interacted with
- IntroScene works
- Intro scene transitions cleanly into Ashport
- Scene-based music switching works
- Intro fade-in/fade-out works
- Ashport fade-in works

## Current Story Direction

- Working title: Stillturn
- World name currently remains Veyr, but may be renamed later
- The intro does not name the whole world yet
- Player is a Wayfarer
- Player should not start with Affinity
- Early player should be physical-only
- Affinity awakens later when it calls to the player
- Opening: player begins on a boat and arrives at the port village of Ashport
- The captain introduces Ashport, the ringing bells, dead men walking, changed beasts, strange roads, and Wayfarers

## Intro Scene Current State

- `IntroScene.tscn` has been created
- Root is a `Control` node
- Boat background fills the screen
- Boat background uses blurred grayscale ship deck art
- CaptainIntroSprite uses `captain_intro.png`
- Captain sprite uses nearest texture filtering for crisp pixel art
- Captain portrait is centered
- DialogueLayer, DialogueBox, and DialogueText are present
- DialogueBox is styled as a solid white box with black text
- Intro dialogue advances with the existing `interact` action
- Dialogue box appears after the intro fade-in completes
- After the final intro dialogue line, the scene fades out
- Intro transitions to `res://Scenes/main.tscn`

## Current Intro Dialogue

"Easy now. The tide carried you farther than most folk dare go."
"The shore ahead is Ashport."
"But keep your eyes open..."
"..."
"The bells have started ringing again."
"..."
"Dead men walk... Beasts change shape... Old roads lead where they should not..."
"...Some hear the bells and keep walking..."
"We call those ones Wayfarers."
"Now then... let us get you ashore."


## Ashport Shore Progress

- Ashport exterior is now being reshaped from the original village layout into a coastal shore area.
- Bottom collision-tree border has been opened to create a path from town down toward the shore.
- Player can walk from the town area into the new shore area.
- WaterTileMap is working and water tiles can be painted correctly.
- Dock tiles have been added to the GroundTileMap TileSet and can be painted correctly.
- A walkable dock has been placed leading out into the water.
- A dock platform has been added and is walkable.
- WreckedBoat has been added as a Sprite2D object near the dock.
- WreckedBoat collision works using StaticBody2D + CollisionShape2D.
- CaptainNPC has been added near the wrecked boat/dock area.
- Captain collision works.
- Y-sort has been enabled so the player/captain draw order works correctly.
- CaptainTalkArea has been added and detects the player.
- Captain dialogue works through the existing dialogue system.
- DialogueText wrapping/clipping/font size has been adjusted so dialogue no longer bleeds outside the box.

- Ashport shore path works
- Water painting works
- Dock painting works
- Dock is walkable
- Wrecked boat object works
- Wrecked boat collision works
- CaptainNPC is placed in Ashport
- CaptainNPC collision works
- CaptainNPC interaction works
- Y-sort works for player/NPC layering
- Dialogue text now wraps inside the dialogue box


## Latest Stable Checkpoint

- Water collision has been added around the Ashport shore/dock area.
- Player can no longer walk on the water.
- Dock, dock platform, shore, captain area, and boat area remain usable.
- WreckedBoat collision still works.
- CaptainNPC collision and dialogue still work.
- Y-sort issue with player/house visibility was fixed.
- Houses are visible again in-game.
- Current next step: visual shoreline cleanup around the dock and water edge.


## Latest Stable Checkpoint 6/3/2026

- Shoreline visual cleanup has started.
- Top, left, and right shoreline border tiles work.
- Shore edge around the dock has been cleaned up.
- Corner shoreline tiles are still needed later.
- SupplyChest has been added near Ashport shore/dock area.
- SupplyChest collision works.
- SupplyChest inspect area detects the player.
- SupplyChest dialogue works.
- Captain dialogue and SupplyChest dialogue both work correctly.
- Current next step: make Ashport shore visually cleaner, then decide whether to create corner shore tiles or add a simple supply objective flag.

## Latest Stable Checkpoint

- SupplyChest still works after adding `found_supplies`.
- Inspecting SupplyChest sets `found_supplies = true`.
- Captain dialogue still works.
- Chest dialogue still works.
- Next step: make captain dialogue change after supplies are found, but only after reviewing the full `_process()` function first.

## Character Creation Plan - 06/04/2026

- Character creation should happen during the boat intro before the wreck.
- Player should be able to enter a name.
- Player should choose a base sprite, starting with male and female options.
- Hair, eyes, and mouth customization are desired later.
- For the prototype, use full sprite choices first instead of a complex layered character system.
- Affinity should not be chosen during character creation.
- Affinity still awakens later in the story.

## Latest Stable Checkpoint - 06/04/2026

- SupplyChest interaction still works.
- Inspecting SupplyChest sets `found_supplies = true`.
- Captain dialogue now changes after supplies are found.
- Before supplies, captain asks player to search for supplies.
- After supplies, captain confirms they help but are not enough to sail.
- Sea travel remains locked for much later in the story.
- Next step: update/polish the intro so the ship gets pulled off course before Ashport.

## Player Sprite / Character Choice Progress

- Female 16x16 player sprite set has been added.
- Female idle animations have been created for down, up, left, and right.
- Female walk animations have been created for down, up, left, and right.
- Female animations use 6 FPS to match the male player animations.
- `player.gd` now supports an exported `animation_prefix`.
- Leaving `animation_prefix` blank uses the original/default player animations.
- Setting `animation_prefix` to `female_` uses the female animation set.
- Future character creation can use this system to switch between male/default and female player sprites.

## Next Session Plan

Next priority: polish the intro wreck transition for the Ashport Arrival demo.

Planned order:
1. Review `intro_scene.gd` before editing.
2. Update captain intro dialogue so the current pulls the boat off course.
3. Add a fade-to-black wreck moment.
4. Add short black-screen text during the wreck.
5. Transition into Ashport as normal.
6. Later: add automatic captain dialogue when Ashport loads.

Do not start character creation yet. Female player animations are prepared, but character selection can wait until the Ashport Arrival demo loop feels presentable.

## Current Immediate Priority

- Next major task: polish the intro wreck transition.
- The intro should eventually include:
  - calm boat/captain dialogue
  - player naming and character choice later
  - current pulls the ship off course
  - fade to black
  - short black-screen wreck text
  - transition into Ashport
  - Ashport music fades in
  - captain auto-dialogue near the wreck
- For now, do not build full character creation yet.
- Focus first on making the Ashport Arrival demo loop feel presentable.

## Demo Target: Ashport Arrival

Goal: create a small playable prototype slice suitable for a private demo or LinkedIn progress clip.

Target flow:
1. Boat intro begins.
2. Current pulls ship off course.
3. Screen fades to black with short wreck text.
4. Player arrives at Ashport shore.
5. Captain talks near the wrecked boat.
6. Player finds SupplyChest.
7. Captain dialogue changes after supplies are found.
8. Player is directed into Ashport.

Do not add combat, Affinity, sea travel, or full character creation before this loop feels polished.

## Assistant Workflow Rules

- Move slowly and step-by-step.
- During Godot editor work, confirm the current node/layer/script before giving instructions.
- Only change one system at a time.
- Save after every stable working change.
- For code errors, paste and review the full function before making edits.
- Do not diagnose syntax errors from partial screenshots unless the full function is visible.
- Avoid long task lists during active editing.

## Known Unfinished Items

- Shore corner tiles are missing and should be created later.
- Water animation is not implemented yet.
- Captain auto-dialogue after Ashport load is not implemented yet.
- Intro wreck transition is not implemented yet.
- Character naming is not implemented yet.
- Character selection is not implemented yet, but female animations are prepared.
- Sea travel should remain locked until much later, possibly around the fifth town.
- Affinity should awaken later and should not be part of starting character creation.

## Intro Wreck Transition Progress

- Intro dialogue has been updated so the captain notices the current pulling the boat off course.
- After the final intro line, the scene fades to black.
- Black-screen wreck text has been added.
- Black-screen wreck text advances with the existing interact input.
- Instruction text was intentionally omitted from the black-screen wreck text for a more cinematic feel.
- Intro still transitions into `res://Scenes/main.tscn`.
- Future polish: add wave/crash/wood-break sound effects during the black-screen wreck moment.

## Intro Wreck Sound Progress

- Wreck sound effects have been added to the intro black-screen wreck moment.
- New audio files added:
  - `wreck_wave_swell_original.wav`
  - `wreck_wood_crack_original.wav`
  - `wreck_crash_impact_original.wav`
  - `wreck_low_bell_original.wav`
- `intro_scene.gd` now creates an `AudioStreamPlayer` for wreck sound effects.
- Each black-screen wreck line triggers a matching sound effect.
- Wreck text still advances with the existing interact input.
- Intro still transitions into `res://Scenes/main.tscn`.
- Next step: add automatic captain dialogue when Ashport loads.

## Auto Captain Dialogue Progress

- Captain auto-dialogue now starts after Ashport loads.
- Auto-dialogue begins after the Ashport fade-in finishes.
- Captain reacts to the wreck and directs the player to search the shore.
- Ashport Arrival flow now works from intro to wreck transition to captain dialogue.
- Future polish: make auto-dialogue only happen after the intro wreck, not every time `main.tscn` loads.

## Ashport Intro Auto-Dialogue Polish

- IntroScene now sets a scene-tree meta flag before loading `main.tscn`.
- `main.gd` checks for `play_ashport_intro_dialogue` before starting the captain auto-dialogue.
- Captain auto-dialogue now only plays after the intro wreck transition.
- Running `main.tscn` directly no longer triggers the intro captain dialogue automatically.
- The meta flag is removed after use so the dialogue does not repeat.