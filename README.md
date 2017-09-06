# Scrabble-Engine

## Description
Scrabble Engine written in Swift. That's a course project for the Swift-3 course at @ Sofia University based in Sofia, Bulgaria.

## Documentation

### Board.swift
Here is the Board class that stores information about the scrabble board and enum Direction object.
#### Properties
#### Methods

### Cell.swift
Here is the Cell class that stores information about single cell - is there a bonus and/or tile.
#### Properties
#### Methods

### Tile.swift
Here is the Tile class that stores information about single tile such as letter and its score.
#### Properties
#### Methods

### Player.swift
Here is the Player class that stores information about single player such as name and score.
#### Properties
#### Methods

### Helper.swift
That's a file that store structs such as GameConfiguration and SavedGameData to help organizing the code.
#### struct GameConfiguration

#### struct SavedGameData

### Parser.swift
Here is the Player static class that has useful methods for parsing and extracting information from the configuration files.
#### Properties
#### Methods

## Get Started

### 1. Install and setup Swift.

### 2. Setup the project
* You should have Swift correctly configured!
* Download the project.
* Go to project directory. You should be in 'Scrabble-Engine/' folder.
* Run ```pwd``` command in the terminal to be sure that you're in the right directory. One possible output could be: ```/home/Projects/Scrabble-Engine/```.
* Run the code below in the terminal:
```
swift build
./.build/debug/Scrabble-Engine
```
or run in the terminal
```
./swift-compile-and-run.sh
```

That's it! You should have a working instance of the project.
