import Foundation


class Cell {
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
}

extension Cell: CustomStringConvertible {

  var description: String {
    return "\(bonusType)-\(bonusMultiplier)-\(tile)"
  }
}


// var A_cell = Cell(
//   index: (1, 1),
//   bonusType: "LS",
//   bonusMultiplier: 3,
//   tile: Tile(letter: "A", score: 1)
// )
// print(A_cell)
//
// var B_cell = Cell(
//   index: (2, 2),
//   tile: Tile(letter: "B", score: 2)
// )
// print(B_cell)
// print(B_cell.hasBonus())
//
// var C_cell = Cell(
//   index: (2, 3)
// )
// print(C_cell)
// print(C_cell.hasTile())
