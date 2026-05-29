# Stillturn Godot Prototype Checkpoint

Godot version: 4.3 stable

## Current Working Features

- Player movement works
- Player moves only on straight axes, no diagonal movement
- Player animation works
- Collision works
- Tree inspection works
- Grave inspection works
- Dialogue box works
- Background music works
- House entry works
- HouseInterior.tscn works
- Rug exit returns to main.tscn
- Bookshelf interaction works
- Stair interaction works
- MonkNPC works
- Monk turns to face player during interaction
- Monk idly changes facing direction when not being interacted with

## Current Story Direction

- Working title: Stillturn
- World: Veyr
- Player is a Wayfarer
- Player should not start with Affinity
- Early player should be physical-only
- Affinity awakens later when it calls to the player
- Opening idea: player begins on a boat and arrives at a port village

## Next Planned Step

Create a reusable NPC system, then use it to add a sea captain NPC.

## Intro Scene Progress

- IntroScene.tscn has been created
- BoatBackground sprite has been added using the grayscale ship deck background
- CaptainIntroSprite has been added using captain_intro.png
- DialogueLayer, DialogueBox, and DialogueText have been added
- DialogueBox is styled as a solid white box with black text
- Intro dialogue advances with the interact button
- Current intro uses the sea captain as the opening guide
- Intro dialogue introduces Ashport, the ringing bells, dead men walking, changed beasts, strange roads, and Wayfarers
- The broader world name is currently undecided; the intro uses Ashport instead of naming the whole world
- Blurred versions of the boat background were created for possible use behind the sharper captain sprite

## Next Planned Step

Finish polishing IntroScene.tscn:
- Make CaptainIntroSprite crisp with nearest texture filtering
- Decide whether to use the soft-blur or medium-blur boat background
- Confirm the intro transitions cleanly into main.tscn
- Then commit the intro scene and assets