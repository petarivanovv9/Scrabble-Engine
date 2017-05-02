import Foundation


func getLetterScore(_ tiles_occurences : [(Tile, Int)], _ letter: Character) -> Int {
  for item in tiles_occurences {
    if item.0.letter == letter {
      return item.0.score
    }
  }
  return 1
}


do {
  let path = FileManager.default.currentDirectoryPath
  let game_config_file = "\(path)/Sources/game_configurations.txt"
  let saved_game_file  = "\(path)/Sources/saved_game.txt"

  var game_config = Parser.parseGameConfiguration(path: game_config_file)!
  print("[game_config]")
  print(game_config)
  print("\n")

  var saved_game_data = Parser.parseSavedGameData(path: saved_game_file)!
  print("[saved_game_data]")
  print(saved_game_data)
  print("\n")

  var board = Board(dims: game_config.board_dims)
  // print(board)
  for bonus in game_config.bonuses {
    let curr_cell = Cell(bonusType: bonus.bonusType, bonusMultiplier: bonus.bonusMultiplier)
    board[bonus.coordinates.0, bonus.coordinates.1] = curr_cell
  }
  // print(board)

  // for turn in saved_game_data.turns {
  //   print(turn)
  //   let player_word_tiles = Array(turn.word.characters).map { Tile(letter: $0, score: getLetterScore(game_config.tiles_occurences, $0)) }
  //
  //   let player_word_score = board.addWord(tiles_word: player_word_tiles, start_row_col: turn.start_pos, direction: turn.direction)
  //   print(player_word_score)
  //   print("----------------------------------")
  // }

  board.cells[1][2].setTile(tile: Tile(letter: "A", score: 1))
  board.cells[3][3].setTile(tile: Tile(letter: "B", score: 1))
  board.cells[2][3].setTile(tile: Tile(letter: "C", score: 1))
  print(board)

  //////////////
  // THE GAME

  // possibility: Rack class to store the tiles

  // на всеки ход:
  //  - дали може да се изпише думата ( за място, началото на дъската, наличие на плочки и т.н )
  //  - смятам точките които ще бъдат добавени на съответния игра
  //  - премахвам използваните плочки
  //  - добавям точките и "слагам" плочките в/у дъската



} catch let error {
  print(error)
  print("Something went wrong! Try again!")
}
