import Foundation


// === Tile class ===
class Tile: CustomStringConvertible {
  let letter: Character
  let score: Int

  init(letter: Character, score: Int) {
      self.letter = letter
      self.score = score
  }

  var description: String {
    return "\(letter) with \(score)"
  }
}
// === END Tile class ===


// === Cell class ===
class Cell: CustomStringConvertible {
  var index: (Int, Int)? = nil
  var bonusType: String? = nil
  var bonusMultiplier: Int? = nil
  var tile: Tile? = nil

  init() {
    // self.bonusType = ""
    // self.bonusMultiplier = 1
  }

  ////
  // TODO NEED TO REFACTOR THE CONSTRUCTORS
  ////

  init(index: (Int, Int)) {
    self.index = index
  }

  init(index: (Int, Int), tile: Tile) {
    self.index = index
    self.tile = tile
  }

  init(bonusType: String, bonusMultiplier: Int) {
    self.bonusType = bonusType
    self.bonusMultiplier = bonusMultiplier
  }

  init(index: (Int, Int), bonusType: String, bonusMultiplier: Int) {
    self.index = index
    self.bonusType = bonusType
    self.bonusMultiplier = bonusMultiplier
  }

  init(index: (Int, Int), bonusType: String, bonusMultiplier: Int, tile: Tile) {
    self.index = index
    self.bonusType = bonusType
    self.bonusMultiplier = bonusMultiplier
    self.tile = tile
  }

  func hasBonus() -> Bool {
    return self.bonusType != ""
  }

  func setTile(tile: Tile) {
    self.tile = tile
  }

  func hasTile() -> Bool {
    return self.tile != nil
  }

  var description: String {
    return "\(index) - \(bonusType) with \(bonusMultiplier) - \(tile)"
  }
}
// === END Cell class ===


// === Board class ===
class Board {
  var cells: [[Cell]] = []

  init(dims: (Int, Int)) {
    self.cells = Array(
      repeating: Array(repeating: Cell(), count: dims.1),
      count: dims.0
    )
    // print("HERE")
    // print(self.cells!)
  }

  convenience init?(dim: Int) {
    self.init(dims: (dim, dim))
  }
}
// === END Board class ===


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
let file = "\(path)/Sources/temp_game_configurations.txt"

do {
  let gameConfigurations: String = try String(
    contentsOfFile: file,
    encoding: String.Encoding.utf8
  )
  var lines = gameConfigurations.components(separatedBy: "\n")

  // remove unnecessary lines like commented and empty one
  lines = lines.filter { $0.isEmpty == false }
  lines = lines.filter { $0[$0.startIndex] != "#" }
  print(lines)


  let boardSectionStartIndex = lines.index(of: "--BOARD--")!
  let lettersSectionStartIndex = lines.index(of: "--LETTERS--")!


  // ====EXTRACT BOARD====

  let boardSize = lines[boardSectionStartIndex+1].components(separatedBy: " ").map { Int($0) ?? 0 }
  print(boardSize)

  ///////////
  let boardDims = (boardSize[0], boardSize[1])
  var board = Board(dims: boardDims)
  ///////////

  // bonuses = [ (Coordinates: (Int, Int), Type: String, Points: Int) ]

  var bonuses : [((Int, Int), String, Int)] = [((Int, Int), String, Int)]()

  for l in lines[boardSectionStartIndex+2...lettersSectionStartIndex-1] {
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

  for l in lines[lettersSectionStartIndex+1...lines.count-1] {
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


} catch let error {
  print(error)
}
