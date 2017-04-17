// import Foundation
//
// class Tile: CustomStringConvertible {
//   let letter: Character
//   let score: Int
//
//   init(letter: Character, score: Int = 0) {
//       self.letter = letter
//       self.score = score
//   }
//
//   var description: String {
//     return "\(letter) with \(score)"
//   }
// }
//
// class Cell: CustomStringConvertible {
//   let index: (Int, Int)
//   var bonusType: String? = nil
//   var bonusMultiplier: Int? = nil
//   var tile: Tile? = nil
//
//   init(index: (Int, Int)) {
//     self.index = index
//   }
//
//   init(index: (Int, Int), tile: Tile) {
//     self.index = index
//     self.tile = tile
//   }
//
//   init(index: (Int, Int), bonusType: String, bonusMultiplier: Int, tile: Tile) {
//     self.index = index
//     self.bonusType = bonusType
//     self.bonusMultiplier = bonusMultiplier
//     self.tile = tile
//   }
//
//   func hasBonus() -> Bool {
//     return self.bonusType != ""
//   }
//
//   func setTile(tile: Tile) {
//     self.tile = tile
//   }
//
//   func hasTile() -> Bool {
//     return self.tile != nil
//   }
//
//   var description: String {
//     return "\(index) - \(bonusType) with \(bonusMultiplier) - \(tile)"
//   }
// }

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
