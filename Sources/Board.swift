import Foundation


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


// var board = Board(dims: (7, 7))
// for i in 0..<board.cells.count {
//   for j in 0..<board.cells[i].count {
//     print(board.cells[i][j])
//   }
// }
