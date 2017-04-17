import Foundation

// === Tile class ===
class Tile: CustomStringConvertible {
  let letter: Character
  let score: Int

  init(letter: Character, score: Int = 0) {
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
    // ?!?!?!
  }

  init(index: (Int, Int)) {
    self.index = index
  }

  init(index: (Int, Int), tile: Tile) {
    self.index = index
    self.tile = tile
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

var board = Board(dims: (7, 7))
for i in 0..<board.cells.count {
  for j in 0..<board.cells[i].count {
    print(board.cells[i][j])
  }
}
// === END Board class ===
