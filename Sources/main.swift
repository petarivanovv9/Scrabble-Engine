import Foundation


func printBoard(cells: [[Cell]]) {
  for i in 0..<cells.count {
    for j in 0..<cells[i].count {
    // var bonusType: String? = ]]
      print(cells[i][j])
    }
  }
}


let path = FileManager.default.currentDirectoryPath

// let file = "\(path)/Sources/game_configurations.txt"
let game_config_file = "\(path)/Sources/temp_game_configurations.txt"

let saved_game_file = "\(path)/Sources/saved_game.txt"


do {
  // let gameConfigurations: String = try String(
  //   contentsOfFile: game_config_file,
  //   encoding: String.Encoding.utf8
  // )
  var game_config = GameConfigParser(filename: game_config_file)
  var game_config_lines = game_config.getLines()
  // var lines = gameConfigurations.components(separatedBy: "\n")

  // remove unnecessary lines like commented and empty one
  game_config_lines = game_config_lines.filter { $0.isEmpty == false }
  game_config_lines = game_config_lines.filter { $0[$0.startIndex] != "#" }
  print(game_config_lines)


  let boardSectionStartIndex = game_config_lines.index(of: "--BOARD--")!
  let lettersSectionStartIndex = game_config_lines.index(of: "--LETTERS--")!


  // ====EXTRACT BOARD====

  let boardSize = game_config_lines[boardSectionStartIndex+1].components(separatedBy: " ").map { Int($0) ?? 0 }
  print(boardSize)

  ///////////
  let boardDims = (boardSize[0], boardSize[1])
  var board = Board(dims: boardDims)
  ///////////

  // bonuses = [ (Coordinates: (Int, Int), Type: String, Points: Int) ]

  var bonuses : [((Int, Int), String, Int)] = [((Int, Int), String, Int)]()

  for l in game_config_lines[boardSectionStartIndex+2...lettersSectionStartIndex-1] {
    let line = l.components(separatedBy: " ")
    let row = Int(line[0]) ?? 0
    let col = Int(line[1]) ?? 0
    let coordinates = (row, col)
    let type = line[2]
    let multiplyBy = Int(line[3]) ?? 0
    bonuses.append(coordinates, type, multiplyBy)
    ///////
    var currentCell = Cell(bonusType: type, bonusMultiplier: multiplyBy)
    board.cells[row][col] = currentCell
    print("BONUS")
    print(currentCell)
    // check for nil before unwrapping and using an optional
    if currentCell.bonusType != nil {
      print(currentCell.bonusType!)
    }
    ///////
  }
  print(bonuses)
  printBoard(cells: board.cells)
  print("-------------------- ")
  print(board.cells[3][0])


  // ====END, EXTRACT BOARD====


  // ====EXTRACT LETTERS====

  // letters = [ (Letter: Character, Occurences: Int, Points: Int) ] -> [ ("A", 8, 1), ("Б", 3, 2)]

  // var letters : [(Character, Int, Int)] = [(Character, Int, Int)]()

  var tiles : [Tile] = [Tile]()

  // [Tile(A, 1), Tile(A, 1), Tile(A, 1) ....]
  // OR [(Tile(A, 1), 3) ....]
  var tilesOccurences : [(Tile, Int)] = [(Tile, Int)]()

  for l in game_config_lines[lettersSectionStartIndex+1...game_config_lines.count-1] {
    let line = l.components(separatedBy: " ")
    print(line)
    let letter = Character(line[0])
    let occurences = Int(line[1]) ?? 0
    let points = Int(line[2]) ?? 0
    // letters.append((letter, occurences, points))

    var currentTile = Tile(letter: letter, score: points)
    var i = occurences
    while i > 0 {
      i -= 1
      tiles.append(currentTile)
    }
    print(currentTile)
    print("COUNT: ")
    print(tiles.count)
    tilesOccurences.append((currentTile, occurences))
  }
  // print(letters)
  print(tiles)
  print(tilesOccurences)

  // ====END, EXTRACT LETTERS====


  print("-------END OF PARSING GAME CONFIGURATION FILE------")
  ///////////////////////////////////////////////////////

  // PARSING SAVED GAME FILE

  let savedGame: String = try String(
    contentsOfFile: saved_game_file,
    encoding: String.Encoding.utf8
  )
  var l_2 = savedGame.components(separatedBy: "\n")

  // remove unnecessary lines like commented and empty one
  l_2 = l_2.filter { $0.isEmpty == false }
  l_2 = l_2.filter { $0[$0.startIndex] != "#" }
  print(l_2)

  let playersSectionStartIndex = l_2.index(of: "--PLAYERS--")!
  let turnsSectionStartIndex = l_2.index(of: "--TURNS--")!

  var players : [Player] = [Player]()

  // print("HERE>>")
  for name in l_2[playersSectionStartIndex+1...turnsSectionStartIndex-1] {
    var curr_player = Player(name: name)
    players.append(curr_player)
  }
  print(players)


} catch let error {
  print(error)
}
