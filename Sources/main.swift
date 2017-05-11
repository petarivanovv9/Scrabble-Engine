import Foundation


let path = FileManager.default.currentDirectoryPath
let game_config_file = "\(path)/Sources/game_configurations.txt"
// let game_config_file = "\(path)/Sources/new_saved_game.txt"

let saved_game_file  = "\(path)/Sources/saved_game.txt"

// let new_saved_game_file  = "\(path)/Sources/new_saved_game.txt"

print("-------------------------------------------------------------")
var game_config = Parser.parseGameConfiguration(path: game_config_file)!
print("[game_config]")
print(game_config)

var saved_game_data = Parser.parseSavedGameData(path: saved_game_file)!
print("[saved_game_data]")
print(saved_game_data)
print("\n")

var board = Board(dims: game_config.board_dims)

print(game_config.bonuses)
for item in game_config.bonuses {
  if item.bonusType != "WS" && item.bonusType != "LS" {
    let curr_tile = Tile(letter: Character(item.bonusType), score: item.bonusMultiplier)
    board[item.coordinates.0, item.coordinates.1].setTile(tile: curr_tile)
  }
  else {
    let curr_cell = Cell(bonusType: item.bonusType, bonusMultiplier: item.bonusMultiplier)
    board[item.coordinates.0, item.coordinates.1] = curr_cell
  }
}
// print("\n")
// print(board)

for turn in saved_game_data.turns {
  print(turn)
  let player_word_tiles = Array(turn.word.characters).map { Tile(letter: $0, score: getLetterScore(game_config.tiles_occurences, $0)) }

  let player_word_score = board.addWord(tiles_word: player_word_tiles, start_row_col: turn.start_pos, direction: turn.direction)
  print(player_word_score)
  print("-------------------------------------------------------------")
}

print(board)

let new_saved_game_file = FileManager.default.currentDirectoryPath + "/Sources/new_saved_game.txt"

do {
  try FileManager.default.removeItem(atPath: new_saved_game_file)
} catch {
  print("Error removing \(new_saved_game_file)")
}

board.saveBoardToFile()
Parser.writeToFile(content: "--LETTERS--", filePath: new_saved_game_file)

for (tile, occurences) in game_config.tiles_occurences {
  var line = "\(tile.letter) \(occurences) \(tile.score)"
  Parser.writeToFile(content: line, filePath: new_saved_game_file)
}


/// TODO : !!!документация!!! - коментари, на проекта, класове и т.н.
// наследяне: базова клетка, друга клетка която умножава по 2
// в Board да имам структура BoardSize и с 2 полета - редове колони
// за наследяване
// за смятането на думата
// записването на дъската(обновената) във файл

//////////////
// THE GAME

// possibility: Rack class to store the tiles

// на всеки ход:
//  - дали може да се изпише думата ( за място, началото на дъската, наличие на плочки и т.н )
//  - смятам точките които ще бъдат добавени на съответния игра
//  - премахвам използваните плочки
//  - добавям точките и "слагам" плочките в/у дъската
