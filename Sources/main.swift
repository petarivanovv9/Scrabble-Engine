import Foundation


func getLetterScore(tiles_occurences : [(Tile, Int)], letter: Character) -> Int {
  for item in tiles_occurences {
    if item.0.letter == letter {
      return item.0.score
    }
  }
  return 1
}


let path = FileManager.default.currentDirectoryPath

let game_config_file = "\(path)/Sources/game_configurations.txt"
let saved_game_file  = "\(path)/Sources/saved_game.txt"


do {

  var game_config = Parser.getEncodedFileContent(filename: game_config_file)!
  var game_config_lines = Parser.getLines(file: game_config)

  game_config_lines = Parser.removeUnnecessaryLines(lines: game_config_lines)

  let board_section_start_index = game_config_lines.index(of: "--BOARD--")!
  let letters_section_start_index = game_config_lines.index(of: "--LETTERS--")!


  // ====EXTRACT BOARD====

  let board_size = game_config_lines[board_section_start_index+1].components(separatedBy: " ").map { Int($0) ?? 0 }

  let board_dims = (board_size[0], board_size[1])
  var board = Board(dims: board_dims)

  var bonuses : [(coordinates: (Int, Int), bonusType: String, bonusMultiplier: Int)] = [((Int, Int), String, Int)]()

  for l in game_config_lines[board_section_start_index+2...letters_section_start_index-1] {
    let line = l.components(separatedBy: " ")
    if line.count < 4 {
      print("Something went wrong!")
      exit(0)
    }
    guard let row = Int(line[0]),
          let col = Int(line[1]),
          let multiplyBy = Int(line[3])
    else {
      print("Something went wrong!")
      exit(0)
    }
    let row_col = (row, col)
    let type = line[2]

    bonuses.append((row_col, type, multiplyBy))

    var currentCell = Cell(bonusType: type, bonusMultiplier: multiplyBy)
    board[row, col] = currentCell
  }

  // ====END, EXTRACT BOARD====


  // ====EXTRACT LETTERS====

  var tiles : [Tile] = [Tile]()
  // [Tile(A, 1), Tile(A, 1), Tile(A, 1) ....]
  // OR [(Tile(A, 1), 3) ....]
  var tiles_occurences : [(Tile, Int)] = [(Tile, Int)]()

  for l in game_config_lines[letters_section_start_index+1...game_config_lines.count-1] {
    let line = l.components(separatedBy: " ")
    if line.count < 3 {
      print("Something went wrong!")
      exit(0)
    }
    let letter = Character(line[0])
    guard let occurences = Int(line[1]),
          let points = Int(line[2])
    else {
      print("Something went wrong!")
      exit(0)
    }

    var current_tile = Tile(letter: letter, score: points)
    var i = occurences
    while i > 0 {
      i -= 1
      tiles.append(current_tile)
    }
    tiles_occurences.append((current_tile, occurences))
  }

  print("[tiles_occurences] <><> \(tiles_occurences)")

  // ====END, EXTRACT LETTERS====

  //
  // print("\n" + "-------END OF PARSING GAME CONFIGURATION FILE------" + "\n")
  //
  //
  // // PARSING SAVED GAME FILE
  //
  // var saved_game = Parser.getEncodedFileContent(filename: saved_game_file)!
  // var saved_game_lines = Parser.getLines(file: saved_game)
  //
  // saved_game_lines = Parser.removeUnnecessaryLines(lines: saved_game_lines)
  // print(saved_game_lines)
  //
  // let players_section_start_index = saved_game_lines.index(of: "--PLAYERS--")!
  // let turns_section_start_index = saved_game_lines.index(of: "--TURNS--")!
  //
  // var players : [Player] = [Player]()
  //
  // // print("HERE>>")
  // for name in saved_game_lines[players_section_start_index+1...turns_section_start_index-1] {
  //   var curr_player = Player(name: name)
  //   players.append(curr_player)
  // }
  // print(players)
  //
  // var i = 0
  // for turn in saved_game_lines[turns_section_start_index+1...saved_game_lines.count-1] {
  //
  //   var line = turn.components(separatedBy: " ")
  //   var player_name = line[0]
  //   var word_start_coordinates = (row: Int(line[1]) ?? 0, col: Int(line[2]) ?? 0)
  //   var word_start_direction: Direction? = nil // vertical OR horizontal
  //   switch line[3] {
  //   	case "H":
  //       word_start_direction = .Horizontal
  //   	case "V":
  //       word_start_direction = .Vertical
  //   	default: print("error")
  //   }
  //   var player_word = line[4]
  //   print("\(player_name) -> \(word_start_coordinates) - \(word_start_direction!) - \(player_word)")
  //
  //   // make word's tiles
  //   var curr_tiles_word = Array(player_word.characters).map { Tile(letter: $0, score: getLetterScore(tiles_occurences: tiles_occurences, letter: $0)) }
  //   // print(Array(player_word.characters).map { Tile(letter: $0, score: 1) })
  //   print("[curr_tiles_word]: \(curr_tiles_word)")
  //
  //   // tiles_word: [Tile], start_row_col: Coordinate, direction: String
  //   var curr_player_score = board.addWord(tiles_word: curr_tiles_word, start_row_col: word_start_coordinates, direction: word_start_direction!)
  //   print("[curr_player_score]: \(curr_player_score)")
  //
  //   if i == 1 {
  //     break
  //   }
  //
  //   i += 1
  //   print("\n")
  //
  // }
  //
  // print("\nHHGSFDSSDFSASADSADSADAS\n")
  // print(board)

  //////////////
  // THE GAME

  // Rack class to store the tiles

  // на всеки ход:
  //  - дали може да се изпише думата ( за място, началото на дъската, наличие на плочки и т.н )
  //  - смятам точките които ще бъдат добавени на съответния игра
  //  - премахвам използваните плочки
  //  - добавям точките и "слагам" плочките в/у дъската



} catch let error {
  print(error)
  print("Something went wrong! Try again!")
}
