# Another Eden Bot

A bot to help automate some of the game's grind, including farming experience and clearing another dungeons semi automatically. Built with [Ankulua](http://ankulua.boards.net/thread/181/api-quick-reference). 

## Installing

Prerequisites

- Ankulua, either [pro](http://ankulua.boards.net/thread/204/ankulua-pro2) or [trial](http://ankulua.boards.net/thread/1395/free-ankulua-trial-apk-download) (has 15 minutes cooldown after running for 30 minutes), tested with v7.2 and v8.5
- 1280x720 resolution device or emulator, similar ratios may or may not work
- Rooted emulator **if playing on PC**, tested with Bluestacks v4 with resolution set to 1280x720

Steps to run

- download this project, move it to `/sdcard/Ankulua` on phone or emulator
- open Ankulua app, select the script `/sdcard/Ankulua/AnotherEdenBot/main.lua`
- go to game and start bot, **note** some features have specific starting positions, read below for details

## Features

### Farm mobs

Move sideways on the spot, battles enemy for specified amount of times, may optionally use food. Can be started from **anywhere**. Options include:

- number of battles, `n`, before script exits
- option to eat food after `n` battles (if enabled, a total of `2*n` battles will be done before exit)
- able to [set combat](#set-combat) for mobs

### Farm experience

Farms experience with rate ~1.2M exp/hour by farming mobs in Beast King Castle, healing is automated by the bot. **Must start in Rinde**, in front of the inn. Options include:

- number of battles, `n`, before and after food is used. After `2*n` battles, will heal in Rinde and go back farming
- duration of farming in minutes, script will exit after specified duration has elapsed. This will not be exact, instead will most likely be over the duration when the script exits
- able to [set combat](#set-combat) for mobs

### Run Another Dungeon

Clear selected another dungeon up to specified number of times. **Must start inside selected another dungeon**. Options include:

- number of runs, including the one the player is in at the start
- dungeon selection, currently supported dungeons:
  -  Miglace Labyrinth
  -  Saki's Dream World
- difficulty selection
- able to [set different combat](#set-combat) for mobs and boss
- if an error occurs in the middle of a run, player can specify **whether 5 mobs in floor is cleared** and **current floor**

### Set Combat

Combat can be modified when battling against mobs and another dungeon's boss, switching characters with reserve not implemented. Set by specifying a string as follows: 

- a sequence of 4-digit numbers marks a single turn
- index of digit indicates which character
- digit itself indicates which skill, digit `0` indicates no change of skill
- each turn is seperated by a space, will repeat the last turn if battle is not yet finished.

Example: `0440 2000` will set combat as follows

- on turn 1, 2nd and 3rd character use 4th skill, others use basic attack
- on turn 2 and above, 1st character use 2nd skill, others use the same skill as before, in this case 2nd and 3rd character still use 4th skill and 4th character still use basic attack
