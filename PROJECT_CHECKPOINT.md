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

```text
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