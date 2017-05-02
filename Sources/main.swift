import Foundation


func getLetterScore(tiles_occurences : [(Tile, Int)], letter: Character) -> Int {
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

  var game_config = Parser.parseGameConfiguration(path: game_config_file)

  

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
