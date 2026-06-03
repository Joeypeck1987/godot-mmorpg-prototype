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