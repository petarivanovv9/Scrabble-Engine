import Foundation


class Board {
  let rows: Int
  let columns: Int
  var cells: [[Cell]] = []

  typealias Coordinate = (row: Int, col: Int)

  init(dims: (Int, Int)) {
    self.rows = dims.0
    self.columns = dims.1
    self.cells = Array(
      repeating: Array(repeating: Cell(), count: self.columns),
      count: self.rows
    )
  }

  convenience init?(dim: Int) {
    self.init(dims: (dim, dim))
  }

  func indexIsValid(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }

  // subscript(coordinate: Coordinate) -> Cell {
  subscript(row: Int, col: Int) -> Cell {
    get {
      // assert(indexIsValid(row: coordinate.row, column: coordinate.col), "Index out of range")
      assert(indexIsValid(row: row, column: col), "Index out of range")
      return self.cells[row][col]
    }
    set {
      // assert(indexIsValid(row: coordinate.row, column: coordinate.col), "Index out of range")
      assert(indexIsValid(row: row, column: col), "Index out of range")
      self.cells[row][col] = newValue
    }
  }

}

extension Board: CustomStringConvertible {

  var description: String {
    return self.cells.map { row in row.map { $0.description }.joined(separator: " | ") }
        .joined(separator: "\n") + "\n"
  }
}


// var board = Board(dims: (7, 7))
// for i in 0..<board.cells.count {
//   for j in 0..<board.cells[i].count {
//     print(board.cells[i][j])
//   }
// }
