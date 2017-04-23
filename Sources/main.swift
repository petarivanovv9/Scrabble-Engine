import Foundation


let path = FileManager.default.currentDirectoryPath

// let file = "\(path)/Sources/game_configurations.txt"
let game_config_file = "\(path)/Sources/temp_game_configurations.txt"

let saved_game_file = "\(path)/Sources/saved_game.txt"


do {

  var game_config = Parser.getEncodedFileContent(filename: game_config_file)!
  var game_config_lines = Parser.getLines(file: game_config)

  game_config_lines = Parser.removeUnnecessaryLines(lines: game_config_lines)
  print(game_config_lines)


  let board_section_start_index = game_config_lines.index(of: "--BOARD--")!
  let letters_section_start_index = game_config_lines.index(of: "--LETTERS--")!


  // ====EXTRACT BOARD====

  let board_size = game_config_lines[board_section_start_index+1].components(separatedBy: " ").map { Int($0) ?? 0 }
  print(board_size)

  ///////////
  let board_dims = (board_size[0], board_size[1])
  var board = Board(dims: board_dims)
  ///////////

  // bonuses = [ (Coordinates: (Int, Int), Type: String, Points: Int) ]

  var bonuses : [((Int, Int), String, Int)] = [((Int, Int), String, Int)]()

  for l in game_config_lines[board_section_start_index+2...letters_section_start_index-1] {
    let line = l.components(separatedBy: " ")
    let row = Int(line[0]) ?? 0
    let col = Int(line[1]) ?? 0
    let coordinates = (row, col)
    let type = line[2]
    let multiplyBy = Int(line[3]) ?? 0
    bonuses.append(coordinates, type, multiplyBy)

    var currentCell = Cell(bonusType: type, bonusMultiplier: multiplyBy)
    // board[row][col] = currentCell
    board[row, col] = currentCell

    // check for nil before unwrapping and using an optional
    if currentCell.bonusType != nil {
      // print(currentCell.bonusType!)
    }
  }
  print(board)
  print(board[3, 0])
  // print(bonuses)
  // printBoard(cells: board.cells)
  // print("-------------------- ")
  // print(board.cells[3][0])


  // ====END, EXTRACT BOARD====


  // ====EXTRACT LETTERS====

  // letters = [ (Letter: Character, Occurences: Int, Points: Int) ] -> [ ("A", 8, 1), ("Б", 3, 2)]

  var tiles : [Tile] = [Tile]()

  // [Tile(A, 1), Tile(A, 1), Tile(A, 1) ....]
  // OR [(Tile(A, 1), 3) ....]
  var tiles_occurences : [(Tile, Int)] = [(Tile, Int)]()

  for l in game_config_lines[letters_section_start_index+1...game_config_lines.count-1] {
    let line = l.components(separatedBy: " ")
    let letter = Character(line[0])
    let occurences = Int(line[1]) ?? 0
    let points = Int(line[2]) ?? 0
    // letters.append((letter, occurences, points))

    var current_tile = Tile(letter: letter, score: points)
    var i = occurences
    while i > 0 {
      i -= 1
      tiles.append(current_tile)
    }
    tiles_occurences.append((current_tile, occurences))
  }
  // print(letters)
  // print(tiles)
  print(tiles_occurences)

  // ====END, EXTRACT LETTERS====


  print("\n" + "-------END OF PARSING GAME CONFIGURATION FILE------" + "\n")


  // PARSING SAVED GAME FILE

  var saved_game = Parser.getEncodedFileContent(filename: saved_game_file)!
  var saved_game_lines = Parser.getLines(file: saved_game)

  saved_game_lines = Parser.removeUnnecessaryLines(lines: saved_game_lines)
  print(saved_game_lines)

  let playersSectionStartIndex = saved_game_lines.index(of: "--PLAYERS--")!
  let turnsSectionStartIndex = saved_game_lines.index(of: "--TURNS--")!

  var players : [Player] = [Player]()

  // print("HERE>>")
  for name in saved_game_lines[playersSectionStartIndex+1...turnsSectionStartIndex-1] {
    var curr_player = Player(name: name)
    players.append(curr_player)
  }
  print(players)


  //////////////
  // THE GAME

  // на всеки ход:
  //  - дали може да се изпише думата ( за място, началото на дъската, наличие на плочки и т.н )
  //  - смятам точките които ще бъдат добавени на съответния игра
  //  - премахвам използваните плочки
  //  - добавям точките и "слагам" плочките в/у дъската



} catch let error {
  print(error)
}
