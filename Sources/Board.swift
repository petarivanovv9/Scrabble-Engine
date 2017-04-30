import Foundation


class Board {
  let rows: Int
  let columns: Int
  let middle: Coordinate
  var cells: [[Cell]] = []

  typealias Coordinate = (row: Int, col: Int)

  init(dims: (Int, Int)) {
    self.rows = dims.0
    self.columns = dims.1
    self.middle = (row: self.rows / 2, col: self.columns / 2)
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

  // checks is it possible to write a word on the board
  func tryWord(tiles_word: [Tile], start_row_col: Coordinate, direction: String) -> Bool {
    return true
  }

  // check the center cell of the board
  func isEmpty() -> Bool {
    return self.cells[middle.row][middle.col].hasTile()
  }

  // returns the score of the word
  func addWord(tiles_word: [Tile], start_row_col: Coordinate, direction: String) -> Int {
    if tryWord(tiles_word: tiles_word, start_row_col: start_row_col, direction: direction) == false {
      print("Can't write the word on the board!")
      return 0
    } else {
      // put the tiles on the board
      // calculate the score of the word
      return 0
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
