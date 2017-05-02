import Foundation

class Parser {

  static func getEncodedFileContent(filename: String) -> String? {
    var file : String? = nil
    do {
      file = try String(
        contentsOfFile: filename,
        encoding: String.Encoding.utf8
      )
    } catch let error {
      print(error)
    }
    return file
  }

  static func getLines(file: String) -> [String] {
    let lines = file.components(separatedBy: "\n")
    return lines
  }

  static func removeUnnecessaryLines(lines: [String]) -> [String] {
    return lines.filter { $0.isEmpty == false }.filter { $0[$0.startIndex] != "#" }
  }

  static func parseGameConfiguration(path: String) -> GameConfiguration? {
    var gameConfig = GameConfiguration()

    let config = Parser.getEncodedFileContent(filename: path)!
    var config_lines = Parser.getLines(file: config)
    config_lines = Parser.removeUnnecessaryLines(lines: config_lines)

    let board_section_start_index   = config_lines.index(of: "--BOARD--")!
    let letters_section_start_index = config_lines.index(of: "--LETTERS--")!

    let board_size = config_lines[board_section_start_index+1].components(separatedBy: " ").map { Int($0) ?? 0 }
    let board_dims = (board_size[0], board_size[1])

    var bonuses: [(coordinates: (Int, Int), bonusType: String, bonusMultiplier: Int)] = [((Int, Int), String, Int)]()

    for l in config_lines[board_section_start_index+2...letters_section_start_index-1] {
      let line = l.components(separatedBy: " ")
      if line.count < 4 {
        print("Something went wrong!")
        return nil
      }
      guard let row = Int(line[0]),
            let col = Int(line[1]),
            let multiplyBy = Int(line[3])
      else {
        print("Something went wrong!")
        return nil
      }
      let row_col = (row, col)
      let type = line[2]

      bonuses.append((row_col, type, multiplyBy))
    }

    var tiles_occurences : [(Tile, Int)] = [(Tile, Int)]()

    for l in config_lines[letters_section_start_index+1...config_lines.count-1] {
      let line = l.components(separatedBy: " ")
      if line.count < 3 {
        print("Something went wrong!")
        return nil
      }
      let letter = Character(line[0])
      guard let occurences = Int(line[1]),
            let points = Int(line[2])
      else {
        print("Something went wrong!")
        return nil
      }
      let current_tile = Tile(letter: letter, score: points)
      tiles_occurences.append((current_tile, occurences))
    }

    gameConfig.board_dims = board_dims
    gameConfig.tiles_occurences = tiles_occurences
    gameConfig.bonuses = bonuses

    return gameConfig
  }

  static func parseSavedGameData(path: String) -> SavedGameData? {
    var savedGameData = SavedGameData()

    let saved_game = Parser.getEncodedFileContent(filename: path)!
    var lines = Parser.getLines(file: saved_game)
    lines = Parser.removeUnnecessaryLines(lines: lines)

    let players_section_start_index = lines.index(of: "--PLAYERS--")!
    let turns_section_start_index = lines.index(of: "--TURNS--")!

    var players : [Player] = [Player]()
    for name in lines[players_section_start_index+1...turns_section_start_index-1] {
      let curr_player = Player(name: name)
      players.append(curr_player)
    }

    var turns: [(player: Player, start_pos: (Int, Int), direction: Direction, word: String)] =
      [(Player, (Int, Int), Direction, String)]()

    for l in lines[turns_section_start_index+1...lines.count-1] {
      var line = l.components(separatedBy: " ")
      if line.count < 5 {
        print("Something went wrong!")
        return nil
      }

      let player = Player(name: line[0])
      guard let row = Int(line[1]),
            let col = Int(line[2])
      else {
        print("Something went wrong!")
        return nil
      }
      // var word_start_coordinates = (row: row, col: col)
      var word_start_direction: Direction // vertical OR horizontal
      switch line[3] {
      	case "H":
          word_start_direction = .Horizontal
      	case "V":
          word_start_direction = .Vertical
      	default: return nil
      }
      let player_word = line[4]

      turns.append((player, (row, col), word_start_direction, player_word))

      // make word's tiles
      // var curr_tiles_word = Array(player_word.characters).map { Tile(letter: $0, score: getLetterScore(tiles_occurences: tiles_occurences, letter: $0)) }
    }

    savedGameData.players = players
    savedGameData.turns = turns

    return savedGameData
  }
}
