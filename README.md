# Godot_Game_Development
What you see here is my first attempt at moble game development.

# ----------Twister Fall----------:

Description: 
  This game consists falling blocks and each block has a number from 1 to 14. Rotating the block will either raise
or drop the number by 1. When the blocks reach the bottom of the screen they stack up and there numbers drop down to the 
lowest blocks and add up. If a block reaches 15 then it turns into an brick that can not be destroyed. Blocks that are 
of the same collor and number will destroy each other. The goal of the game is to not creat to many bricks.

Implements:
- Texture buttons and block animation.
- A main screen.
- Block generation with randomly determined color and numbers.
- A selected block animation that shows which block the player can change the number.

To Do's:
- Game mostly complete Still need to add font. 
- Fix bug where blocks do not turn into bricks.
- Speed up game drop timer.

# ----------Jumper Squish----------:
Has main scene and start to GUI.

Description:
  Game where the player starts down in a gully of sorts with a problem, there seems to be rocks coming in to squish them.The 
player must jump to escape before they are killed. Each set of rocks has a collor that will say how fast they will inclose. 
Either the game will be level based or go untill the player dies.

Implements:
- Rock levels that use staticbody2d.
- Rock levels that will move at different speeds.
- Rock level Generation with randomly selected color coded rocks.
- A player that uses a rigid body.
- Animated Sprite 
- The use of signals to trigger animations and game actions.
- Global script for variables that can be past between scenes.


To Do's:
- More game modes
- Finnish GUI.
- Implement way for player RigidBody scene to slide with the platform when it jumps up to it.

Pictures:
